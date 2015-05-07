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

  val pc_r = Reg(init = UInt(StartPC))

  when (io.wpc) {
    pc_r := io.npc
  }

  io.pc := pc_r
}

class PipePcTests(c : PipePC) extends Tester(c) {
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

class PipeIF extends Module {
  val io = new Bundle {
    val pcsource  = UInt(INPUT, width = 2)

    val bpc       = UInt(INPUT, width = 32)
    val jpc       = UInt(INPUT, width = 32)

    val imem      = UInt(INPUT, width = 32)
    val inst      = UInt(OUTPUT, width = 32)
    val pc        = UInt(OUTPUT, width = 32)
  }

  val next_pc = UInt()
  val pc_plus_4 = UInt()

  next_pc := MuxCase(pc_plus_4, Array(
    (io.pcsource === pc_plus4)  -> pc_plus_4,
    (io.pcsource === jump_pc)   -> io.jpc,
    (io.pcsource === branch_pc) -> io.bpc
  ))

  val inst_r = Reg(init = UInt(0), next = io.imem)
  val pc_r = Reg(init = UInt(StartPC), next = next_pc)

  pc_plus_4 := pc_r + UInt(4)

  io.inst := inst_r
  io.pc   := pc_r
}

class RegisterFilePorts extends Bundle {
  val addr_a = UInt(INPUT, 5)
  val data_a = Bits(OUTPUT, 32)
  val addr_b = UInt(INPUT, 5)
  val data_b = Bits(OUTPUT, 32)

  val addr_w = UInt(INPUT, 5)
  val data_w = Bits(INPUT, 32)
  val wen    = Bool(INPUT)
}

class RegisterFile extends Module {
  val io = new RegisterFilePorts()

  val regfile = Mem(Bits(0, width = 32), 32)

  when (io.wen && (io.addr_w != UInt(0))) {
    regfile(io.addr_w) := io.data_w
  }

  io.data_a := regfile(io.addr_a)
  io.data_b := regfile(io.addr_b)

}

class ID2EXESignals extends Bundle {
  val data_a  = UInt(OUTPUT, 32)
  val data_b  = UInt(OUTPUT, 32)
}

class PipeID extends Module {
  val io = new Bundle {
    // IF input
    val inst = UInt(INPUT, 32)


  }

  val id_ctrl_signals =  ListLookup(io.inst,
  // valid, branch, ext, da, db, op1, op2, ALU_op, wb_sel, reg_wb, rf_w, mem_ren, mem_wen
    List(N, br_n, xext, da_x, db_x, op1_x, op2_x, alu_x, wb_x, reg_x, N, N, N),
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
    val t k= rnd.nextInt()
    val m = rnd.nextInt()
    poke(c.io.pcsource, 2)
    poke(c.io.imem, m)
    poke(c.io.jpc, t)
    step(1)
    expect(c.io.pc, t)
    expect(c.io.inst, m)
  }
}

