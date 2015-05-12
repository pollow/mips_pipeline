package arclab.pipeline
package if_stage

import Chisel._
import common.Constants._
import common.MIPSInstructions._

class PipePC extends Module {
  val io = new Bundle{
    val npc = UInt(INPUT, width = 32)
    val wpc = Bool(INPUT)
    val pc  = UInt(OUTPUT, width = 32)
  }

  val pc_r = Reg(init = StartPC)

  when (io.wpc) {
      pc_r := io.npc
  }

  io.pc := pc_r
}

class PipePCTests(c : PipePC) extends Tester(c) {
  poke(c.io.wpc, 0)
  poke(c.io.npc, rnd.nextInt())
  step(1)
  expect(c.io.pc, 0)

  for(i <- 0 to 10) {
    val npc = rnd.nextInt()

    poke(c.io.npc, npc)
    poke(c.io.wpc, 1)
    step(1)
    expect(c.io.pc, npc)
  }

  reset()
  expect(c.io.pc, 0)
}

class RegisterFilePorts extends Bundle {
  val addr_a = UInt(INPUT, 5)
  val data_a = Bits(OUTPUT, 32)
  val addr_b = UInt(INPUT, 5)
  val data_b = Bits(OUTPUT, 32)
  val addr_t = UInt(INPUT, 5)
  val data_t = Bits(OUTPUT, 32)

  val addr_w = UInt(INPUT, 5)
  val data_w = Bits(INPUT, 32)
  val wen    = Bool(INPUT)
}

class RegisterFile extends Module {
  val io = new RegisterFilePorts()

  val regfile = Mem(Bits(width = 32), 32)

  when (io.wen && (io.addr_w != UInt(0))) {
    regfile(io.addr_w) := io.data_w
  }

  io.data_a := regfile(io.addr_a)
  io.data_b := regfile(io.addr_b)
  io.data_t := regfile(io.addr_t)

}

class ID2EXESignals extends Bundle {
  val data_a  = UInt(OUTPUT, 32)
  val data_b  = UInt(OUTPUT, 32)
  val imm     = UInt(OUTPUT, 32)
  val pc      = UInt(OUTPUT, 32)
  val alu_op  = UInt(OUTPUT, alu_len)
  val op1_sel = UInt(OUTPUT, op1_len)
  val op2_sel = UInt(OUTPUT, op2_len)
  val wb_sel  = UInt(OUTPUT, wb_len)
  val wb_dst  = UInt(OUTPUT, 5)
  val rf_wen  = Bool(OUTPUT)
  val mem_ren = Bool(OUTPUT)
  val mem_wen = Bool(OUTPUT)
}

class PipeID extends Module {
  val io = new Bundle {
    // IF input
    val inst = UInt(INPUT, 32)
    val pc   = UInt(INPUT, 32)

    // wb input
    val wb_rf_wen   = Bool(INPUT)
    val wb_rf_addr  = UInt(INPUT, 5)
    val wb_rf_data  = UInt(INPUT, 32)

    // output
    val ctrl = new ID2EXESignals()

    // output test regfile
    val rf_addr_t = UInt(INPUT, 5)
    val rf_data_t = UInt(OUTPUT, 32)
    val ext = Bool(OUTPUT)
  }

  // split inst
  val opcode = io.inst(31, 26)
  val rs     = io.inst(25, 21)
  val rt     = io.inst(20, 16)
  val rd     = io.inst(15, 11)
  val sa     = io.inst(10,  6)
  val func   = io.inst( 5,  0)
  val imm    = io.inst(15,  0)
  val addr   = io.inst(25,  0)
  val sign   = io.inst(15)
  val mf     = io.inst(25, 21)

  // register file
  val regfile = Module(new RegisterFile()).io

  regfile.addr_a := rs
  regfile.addr_b := rt

  regfile.wen    := io.wb_rf_wen
  regfile.addr_w := io.wb_rf_addr
  regfile.data_w := io.wb_rf_data

  regfile.addr_t := io.rf_addr_t
  io.rf_data_t   := regfile.data_t

  val id_ctrl_signals =  ListLookup(io.inst,
  // valid, branch, da, db, ext, op1, op2, ALU_op, wb_sel, reg_wb, rf_w, mem_ren, mem_wen
    List(N, br_n, da_x, db_x, xext, op1_x, op2_x, alu_x, wb_x, reg_x, N, N, N),
    Array(
      ADD_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_add, wb_alu, reg_rd, Y, N, N),
      SUB_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_sub, wb_alu, reg_rd, Y, N, N),
      AND_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_and, wb_alu, reg_rd, Y, N, N),
      OR_   -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_or , wb_alu, reg_rd, Y, N, N),
      XOR_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_xor, wb_alu, reg_rd, Y, N, N),
      SLT_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_slt, wb_alu, reg_rd, Y, N, N),
      SLL_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_sll, wb_alu, reg_rd, Y, N, N),
      SRL_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_srl, wb_alu, reg_rd, Y, N, N),
      SRA_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_sra, wb_alu, reg_rd, Y, N, N),

      JR_   -> List(Y, br_jr, da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_pc , reg_ra, N, N, N),
      JALR_ -> List(Y, br_jr, da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_pc , reg_ra, Y, N, N),

      ADDI_ -> List(Y, br_n,  da_a, db_x, sext, op1_x, op2_imm, alu_add, wb_alu, reg_rt, Y, N, N),
      ANDI_ -> List(Y, br_n,  da_a, db_x, zext, op1_x, op2_imm, alu_and, wb_alu, reg_rt, Y, N, N),
      ORI_  -> List(Y, br_n,  da_a, db_x, zext, op1_x, op2_imm, alu_or , wb_alu, reg_rt, Y, N, N),
      XORI_ -> List(Y, br_n,  da_a, db_x, zext, op1_x, op2_imm, alu_xor, wb_alu, reg_rt, Y, N, N),

      LW_   -> List(Y, br_n,  da_a, db_x, sext, op1_a, op2_imm, alu_add, wb_mem, reg_rt, Y, Y, N),
      SW_   -> List(Y, br_n,  da_a, db_x, sext, op1_a, op2_imm, alu_add, wb_mem, reg_rt, N, N, Y),

      BEQ_  -> List(Y, br_eq, da_a, db_b, sext, op1_x, op2_imm, alu_add, wb_alu, reg_rt, N, N, N),
      BNE_  -> List(Y, br_ne, da_a, db_b, sext, op1_x, op2_imm, alu_and, wb_alu, reg_rt, N, N, N),
      LUI_  -> List(Y, br_n,  da_a, db_x, xext, op1_x, op2_imm, alu_lui, wb_alu, reg_rt, N, N, N),

      J_    -> List(Y, br_j,  da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_x,     reg_ra, N, N, N),
      JAL_  -> List(Y, br_j,  da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_pc,    reg_ra, N, N, N),

      NOP_  -> List(Y, br_n,  da_x, db_x, xext, op1_x, op2_x, alu_x  , wb_x,     reg_x,  N, N, N)
    ))

  val (valid_signal : Bool) :: br_type :: data_a_sel :: data_b_sel :: extend_type :: op1_sel :: op2_sel :: alu_op :: wb_sel :: reg_dst :: (rf_wen : Bool) :: (mem_ren : Bool) :: (mem_wen : Bool) :: Nil = id_ctrl_signals

  val id_data_a = MuxLookup(data_a_sel, da_a, Array(
    da_a -> regfile.data_a
  ))

  val id_data_b = MuxLookup(data_b_sel, db_b, Array(
    db_b -> regfile.data_b
  ))

  val zero_imm = Cat(Fill(16, UInt(0)), imm)
  val sign_imm = Cat(Fill(16, sign), imm)
  val id_ext_imm = MuxLookup(extend_type, sign_imm, Array(
    sext -> sign_imm,
    zext -> zero_imm
  ))

  val id_wb_addr = MuxLookup(reg_dst, UInt(0), Array(
    reg_ra -> UInt(31),
    reg_rt -> rt,
    reg_rd -> rd
  ))

  val reg_wb_dst  = Reg(init = UInt(0), next = id_wb_addr)

  val reg_data_a = Reg(init = UInt(0), next = id_data_a)
  val reg_data_b = Reg(init = UInt(0), next = id_data_b)

  val reg_imm = Reg(init = UInt(0), next = id_ext_imm)

  val reg_pc = Reg(init = UInt(0), next = io.pc)

  val reg_alu_op = Reg(init = alu_x, next = alu_op)

  val reg_op1_sel = Reg(init = op1_x, next = op1_sel)
  val reg_op2_sel = Reg(init = op2_x, next = op2_sel)
  val reg_wb_sel  = Reg(init = wb_x,  next = wb_sel)
  val reg_rf_wen  = Reg(init = N, next = rf_wen)
  val reg_mem_ren = Reg(init = N, next = mem_ren)
  val reg_mem_wen = Reg(init = N, next = mem_wen)

  io.ctrl.data_a  := reg_data_a
  io.ctrl.data_b  := reg_data_b
  io.ctrl.imm     := reg_imm
  io.ctrl.pc      := reg_pc
  io.ctrl.alu_op  := reg_alu_op
  io.ctrl.op1_sel := reg_op1_sel
  io.ctrl.op2_sel := reg_op2_sel
  io.ctrl.wb_sel  := reg_wb_sel
  io.ctrl.wb_dst  := reg_wb_dst
  io.ctrl.rf_wen  := reg_rf_wen
  io.ctrl.mem_ren := reg_mem_ren
  io.ctrl.mem_wen := reg_mem_wen

  val reg_ext = Reg(init = xext, next = extend_type)
  io.ext          := extend_type
}

class PipeIDTests(c : PipeID) extends Tester(c) {
  // init
  poke(c.io.inst, 0)
  poke(c.io.pc, 0)
  poke(c.io.wb_rf_wen , 0)
  poke(c.io.wb_rf_addr, 0)
  poke(c.io.wb_rf_data, 0)
  poke(c.io.rf_addr_t, 0)

  // test regfile first

  for( i <- 0 to 31) {
    poke(c.io.wb_rf_wen , 1)
    poke(c.io.wb_rf_addr, i)
    poke(c.io.wb_rf_data, i * 100)
    poke(c.io.rf_addr_t, i)

    step(1)

    expect(c.io.rf_data_t, i*100)
  }

  // test instruction signals
  for((inst, pc) <- test_instructions.zipWithIndex) {

    // split inst
    poke(c.io.inst, inst)
    poke(c.io.pc, pc * 4)

    val opcode = c.io.inst(31, 26)
    val rs     = c.io.inst(25, 21)
    val rt     = c.io.inst(20, 16)
    val rd     = c.io.inst(15, 11)
    val sa     = c.io.inst(10,  6)
    val func   = c.io.inst( 5,  0)
    val imm    = c.io.inst(15,  0)
    val addr   = c.io.inst(25,  0)
    val sign   = c.io.inst(15)
    val mf     = c.io.inst(25, 21)

    // did not test regfile
    poke(c.io.wb_rf_wen , 0)
    poke(c.io.wb_rf_addr, 0)
    poke(c.io.wb_rf_data, 0)

    step(1)

    expect(c.io.inst, inst)
    expect(c.io.pc, pc * 4)
  }

  step(2)
}

class PipeIF extends Module {
  val io = new Bundle {
    val pcsource  = UInt(INPUT, width = 3)

    val bpc       = UInt(INPUT, width = 32)
    val jpc       = UInt(INPUT, width = 32)

    val imem      = UInt(INPUT, width = 32)
    val inst      = UInt(OUTPUT, width = 32)
    val pc        = UInt(OUTPUT, width = 32)
  }

  val next_pc = UInt(0, 32)
  val pc_r = Reg(init = UInt(StartPC), next = next_pc)
  val pc_plus_4 = Reg(init = UInt(StartPC + UInt(4)), next = next_pc + UInt(4))

  val next_pc_tmp = MuxLookup(io.pcsource, pc_plus_4, Array(
    pc_plus4   -> pc_plus_4,
    jump_pc    -> io.jpc,
    branch_pc  -> io.bpc
  ))

  next_pc := next_pc_tmp

  val inst_r = Reg(init = UInt(0), next = io.imem)

  io.inst := inst_r
  io.pc   := pc_r
}

class PipeIFTests(c : PipeIF) extends Tester(c) {
  poke(c.io.pcsource, 0)
  poke(c.io.bpc, 0)
  poke(c.io.jpc, 0)
  poke(c.io.imem, 0)

  // expect(c.io.pc, 0)
  // expect(c.io.inst, 0)

  for(i <- 0 to 10) {
    val m = rnd.nextInt()
    poke(c.io.pcsource, 0)
    poke(c.io.imem, m)
    step(1)
    expect(c.io.pc, 4 * i + 4)
    expect(c.io.inst, m)
  }

  for(i <- 0 to 10) {
    val t = rnd.nextInt()
    val m = rnd.nextInt()
    poke(c.io.pcsource, 1)
    poke(c.io.imem, m)
    poke(c.io.bpc, t)
    step(1)
    expect(c.io.pc, t)
    expect(c.io.inst, m)
  }

  for(i <- 0 to 10) {
    val t = rnd.nextInt()
    val m = rnd.nextInt()
    poke(c.io.pcsource, 2)
    poke(c.io.imem, m)
    poke(c.io.jpc, t)
    step(1)
    expect(c.io.pc, t)
    expect(c.io.inst, m)
  }
}
