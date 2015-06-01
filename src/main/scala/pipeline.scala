package arclab.pipeline
package stages

import Chisel._
import common.Constants._
import common.MIPSInstructions._

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

  // required debug
  val regs   = Bits(OUTPUT, 32*32)
}

class RegisterFile extends Module {
  val io = new RegisterFilePorts()

  val regfile = Vec.fill(32) { Reg(init = Bits(0, width = 32)) }

  when (io.wen && (io.addr_w != UInt(0))) {
    regfile(io.addr_w) := io.data_w
  }

  io.regs := regfile.toBits()
  io.data_a := regfile(io.addr_a)
  io.data_b := regfile(io.addr_b)
  io.data_t := regfile(io.addr_t)

}

class PipeIF extends Module {
  val io = new Bundle {
    val pcsource  = UInt(INPUT, width = pc_sel_len)
    val bpc       = UInt(INPUT, width = 32)
    val jpc       = UInt(INPUT, width = 32)
    val stall     = Bool(INPUT)

    val imem      = UInt(INPUT, width = 32)
    val inst      = UInt(OUTPUT, width = 32)
    val pc        = UInt(OUTPUT, width = 32)
  }

  val next_pc = UInt(width = 32)
  val pc_r = Reg(init = UInt(StartPC))
  val pc_plus_4 = pc_r + UInt(4)

  next_pc := MuxLookup(io.pcsource, pc_plus_4, Array(
    pc_plus4   -> pc_plus_4,
    jump_pc    -> io.jpc,
    branch_pc  -> io.bpc
  ))

  val inst_r = Reg(init = UInt(0))

  when(io.stall) {
    pc_r := pc_r
    inst_r := inst_r
  } . otherwise {
    pc_r := next_pc
    inst_r := io.imem
  }

  io.inst := inst_r
  io.pc   := pc_r
}

class PipeStall extends Module {
  val io = new Bundle{
    val rs_id = UInt(INPUT, 5)
    val rt_id = UInt(INPUT, 5)

    val rd_mem = UInt(INPUT, 5)
    val rd_exe = UInt(INPUT, 5)
    val rd_wb = UInt(INPUT, 5)

    val wreg_mem = Bool(INPUT)
    val wreg_exe = Bool(INPUT)
    val wreg_wb  = Bool(INPUT)

    val stall = Bool(OUTPUT)
  }

  io.stall := (io.wreg_mem & ((io.rs_id === io.rd_mem) | (io.rt_id === io.rd_mem)) & (io.rd_mem != UInt(0))) |
              (io.wreg_exe & ((io.rs_id === io.rd_exe) | (io.rt_id === io.rd_exe)) & (io.rd_exe != UInt(0))) |
              (io.wreg_wb  & ((io.rs_id === io.rd_wb)  | (io.rt_id === io.rd_wb))  & (io.rd_wb  != UInt(0)))
}

class WB2IDSignals extends Bundle {
  val rf_wen   = Bool(OUTPUT)
  val rf_addr  = UInt(OUTPUT, 5)
  val rf_data  = UInt(OUTPUT, 32)
}

class ID2EXESignals extends Bundle {
  val inst    = UInt(OUTPUT, 32)
  val data_a = UInt(OUTPUT, 32)
  val data_b = UInt(OUTPUT, 32)
  val imm = UInt(OUTPUT, 32)
  val shamt = UInt(OUTPUT, 5)
  val pc4 = UInt(OUTPUT, 32)
  val alu_op = UInt(OUTPUT, alu_len)
  val op1_sel = UInt(OUTPUT, op1_len)
  val op2_sel = UInt(OUTPUT, op2_len)
  val wb_sel = UInt(OUTPUT, wb_len)
  val wb_dst = UInt(OUTPUT, 5)
  val br_type = UInt(OUTPUT, br_len)
  val rf_wen = Bool(OUTPUT)
  val mem_ren = Bool(OUTPUT)
  val mem_wen = Bool(OUTPUT)
}

class PipeID extends Module {
  val io = new Bundle {
    // IF input
    val inst = UInt(INPUT, 32)
    val pc4  = UInt(INPUT, 32)
    // IF output
    val pcsource = UInt(OUTPUT, pc_sel_len)
    val bpc      = UInt(OUTPUT, 32)
    val jpc      = UInt(OUTPUT, 32)

    // stall
    val stall = Bool(INPUT)
    val rs    = UInt(OUTPUT, 5)
    val rt    = UInt(OUTPUT, 5)

    // wb input
    val wb = new WB2IDSignals().flip()

    // output
    val ctrl = new ID2EXESignals()

    // output test regfile
    val rf_addr_t = UInt(INPUT, 5)
    val rf_data_t = UInt(OUTPUT, 32)

    // required debug info
    val regs     = Bits(OUTPUT, 32*32)
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

  regfile.wen    := io.wb.rf_wen
  regfile.addr_w := io.wb.rf_addr
  regfile.data_w := io.wb.rf_data

  regfile.addr_t := io.rf_addr_t
  io.rf_data_t   := regfile.data_t

  io.regs := regfile.regs

  val inst = Mux(io.stall, UInt(0), io.inst)
  // stall
  io.rt := io.inst(20, 16)
  io.rs := io.inst(25, 21)


  val id_ctrl_signals =  ListLookup(inst,
  // valid, branch, da, db, ext, op1, op2, ALU_op, wb_sel, reg_wb, rf_w, mem_ren, mem_wen
    List(N, br_n, da_x, db_x, xext, op1_x, op2_x, alu_x, wb_x, reg_x, N, N, N),
    Array(
      NOP_  -> List(Y, br_n,  da_x, db_x, xext, op1_x, op2_x, alu_x  , wb_x,     reg_x,  N, N, N),

      ADD_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_add, wb_alu, reg_rd, Y, N, N),
      SUB_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_sub, wb_alu, reg_rd, Y, N, N),
      AND_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_and, wb_alu, reg_rd, Y, N, N),
      OR_   -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_or , wb_alu, reg_rd, Y, N, N),
      XOR_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_xor, wb_alu, reg_rd, Y, N, N),
      SLT_  -> List(Y, br_n,  da_a, db_b, xext, op1_a, op2_b, alu_slt, wb_alu, reg_rd, Y, N, N),
      SLL_  -> List(Y, br_n,  da_x, db_b, xext, op1_x, op2_b, alu_sll, wb_alu, reg_rd, Y, N, N),
      SRL_  -> List(Y, br_n,  da_x, db_b, xext, op1_x, op2_b, alu_srl, wb_alu, reg_rd, Y, N, N),
      SRA_  -> List(Y, br_n,  da_x, db_b, xext, op1_x, op2_b, alu_sra, wb_alu, reg_rd, Y, N, N),

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
      LUI_  -> List(Y, br_n,  da_a, db_x, xext, op1_x, op2_imm, alu_lui, wb_alu, reg_rt, Y, N, N),

      J_    -> List(Y, br_j,  da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_x,     reg_ra, N, N, N),
      JAL_  -> List(Y, br_j,  da_a, db_x, xext, op1_x, op2_x, alu_x  , wb_pc,    reg_ra, Y, N, N)
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

  // Branch Taken
  val equ = id_data_a === id_data_b

  val brt = MuxLookup(br_type, Bool(false), Array(
    br_n  -> Bool(false),
    br_eq -> equ,
    br_ne -> !equ,
    br_j  -> Bool(true),
    br_jr -> Bool(true)
  ))

  when (brt) {
    io.pcsource := MuxLookup(br_type, default = pc_plus4, Array(
      br_eq -> branch_pc,
      br_ne -> branch_pc,
      br_j  -> jump_pc,
      br_n  -> pc_plus4
    ))
  } .otherwise {
    io.pcsource := pc_plus4
  }

  io.bpc := io.pc4 + (sign_imm << UInt(2))
  io.jpc := Cat(io.pc4(31, 28), addr, Fill(2, UInt(0)))

  val reg_inst    = Reg(init = UInt(0), next = inst)
  val reg_shamt   = Reg(init = UInt(0), next = sa)
  val reg_br_type = Reg(init = br_n, next = br_type)
  val reg_wb_dst  = Reg(init = UInt(0), next = id_wb_addr)
  val reg_data_a  = Reg(init = UInt(0), next = id_data_a)
  val reg_data_b  = Reg(init = UInt(0), next = id_data_b)
  val reg_imm     = Reg(init = UInt(0), next = id_ext_imm)
  val reg_pc4     = Reg(init = UInt(0), next = io.pc4)
  val reg_alu_op  = Reg(init = alu_x, next = alu_op)
  val reg_op1_sel = Reg(init = op1_x, next = op1_sel)
  val reg_op2_sel = Reg(init = op2_x, next = op2_sel)
  val reg_wb_sel  = Reg(init = wb_x,  next = wb_sel)
  val reg_rf_wen  = Reg(init = N, next = rf_wen) // Mux(io.stall, Bool(false), rf_wen))
  val reg_mem_ren = Reg(init = N, next = mem_ren)
  val reg_mem_wen = Reg(init = N, next = mem_wen)// Mux(io.stall, Bool(false), mem_wen))

  io.ctrl.inst    := reg_inst
  io.ctrl.data_a  := reg_data_a
  io.ctrl.data_b  := reg_data_b
  io.ctrl.imm     := reg_imm
  io.ctrl.shamt   := reg_shamt
  io.ctrl.pc4     := reg_pc4
  io.ctrl.alu_op  := reg_alu_op
  io.ctrl.op1_sel := reg_op1_sel
  io.ctrl.op2_sel := reg_op2_sel
  io.ctrl.wb_sel  := reg_wb_sel
  io.ctrl.wb_dst  := reg_wb_dst
  io.ctrl.rf_wen  := reg_rf_wen
  io.ctrl.mem_ren := reg_mem_ren
  io.ctrl.mem_wen := reg_mem_wen
  io.ctrl.br_type := reg_br_type
}

class EXE2MEMSignals extends Bundle {
  val inst    = UInt(OUTPUT, 32)
  val alu_out = UInt(OUTPUT, 32)
  val data_b  = UInt(OUTPUT, 32)
  val wb_dst  = UInt(OUTPUT, 5)
  val wb_sel  = UInt(OUTPUT, wb_len)
  val rf_wen  = Bool(OUTPUT)
  val mem_ren = Bool(OUTPUT)
  val mem_wen = Bool(OUTPUT)
}

class PipeEXE extends Module {
  val io = new Bundle {
    val id = new ID2EXESignals().flip()
    val ctrl = new EXE2MEMSignals()

    // stall
    val rd = UInt(OUTPUT, width = 5)
    val wreg = Bool(OUTPUT)
  }

  // Stall
  io.wreg := io.id.rf_wen
  io.rd := io.id.wb_dst

  val op1 = MuxLookup(io.id.op1_sel, UInt(0), Array(
    op1_a -> io.id.data_a
  ))

  val op2 = MuxLookup(io.id.op2_sel, UInt(0), Array(
    op2_b -> io.id.data_b,
    op2_imm -> io.id.imm
  ))

  val exec_alu_out = MuxLookup(io.id.alu_op, UInt(0), Array(
    alu_add -> (op1 + op2)(31, 0),
    alu_sub -> (op1 - op2),
    alu_and -> (op1 & op2),
    alu_or  -> (op1 | op2),
    alu_xor -> (op1 ^ op2),
    alu_slt -> (op1 < op2).toUInt(),
    alu_sll -> (op2 << io.id.shamt)(31, 0).toUInt(),
    alu_srl -> (op2 >> io.id.shamt)(31, 0).toUInt(),
    alu_sra -> (op2.toSInt() >> io.id.shamt).toUInt(),
    alu_lui -> Cat(op2(15, 0), Fill(16, UInt(0)))
  ))

  // TODO JAL support

  val reg_exec_out = Reg(init = UInt(0),     next = exec_alu_out)
  val reg_data_b   = Reg(init = UInt(0),     next = io.id.data_b)
  val reg_rf_wen   = Reg(init = UInt(0),     next = io.id.rf_wen)
  val reg_mem_ren  = Reg(init = UInt(0),     next = io.id.mem_ren)
  val reg_mem_wen  = Reg(init = UInt(0),     next = io.id.mem_wen)
  val reg_wb_sel   = Reg(init = UInt(0),     next = io.id.wb_sel)
  val reg_wb_dst   = Reg(init = UInt(0),     next = io.id.wb_dst)
  val reg_inst     = Reg(init = UInt(0),     next = io.id.inst)

  io.ctrl.inst    := reg_inst
  io.ctrl.alu_out := reg_exec_out
  io.ctrl.data_b  := reg_data_b
  io.ctrl.rf_wen  := reg_rf_wen
  io.ctrl.mem_ren := reg_mem_ren
  io.ctrl.mem_wen := reg_mem_wen
  io.ctrl.wb_sel  := reg_wb_sel
  io.ctrl.wb_dst  := reg_wb_dst
}

class MEMSignals extends Bundle {
  val wen = Bool(INPUT)
  val addr = UInt(INPUT, 32)
  val data_a = UInt(INPUT, 32)

  val data_b = UInt(OUTPUT, 32)
}

class MEM2WBSignals extends Bundle {
  val inst = UInt(OUTPUT, 32)
  val alu_out  = UInt(OUTPUT, 32)
  val mem_data = UInt(OUTPUT, 32)
  val mem_ren  = Bool(OUTPUT)
  val wb_dst  = UInt(OUTPUT, 5)
  val wb_sel  = UInt(OUTPUT, wb_len)
  val rf_wen  = Bool(OUTPUT)
}

class Memory extends Module {
  val io = new MEMSignals()

  val memory = Mem(UInt(width = 32), 32, true)

  when (io.wen) {
    memory(io.addr) := io.data_a
    io.data_b := UInt(0)
  } .otherwise {
    io.data_b := memory(io.addr)
  }
}

class PipeMEM extends Module {
  val io = new Bundle {
    val exe = new EXE2MEMSignals().flip()
    val mem = new MEMSignals().flip() // output
    val ctrl = new MEM2WBSignals()
    // stall
    val rd       = UInt(OUTPUT, width = 5)
    val wreg     = Bool(OUTPUT)

  }

  io.wreg := io.exe.rf_wen
  io.rd := io.exe.wb_dst

  // Mem operation
  io.mem.wen    := io.exe.mem_wen
  io.mem.addr   := io.exe.alu_out
  io.mem.data_a := io.exe.data_b

  val mem_rdata = io.mem.data_b

  // reg buffer
  val reg_mem_ren = Reg(init = UInt(0), next = io.exe.mem_ren)
  val reg_rf_wen  = Reg(init = UInt(0), next = io.exe.rf_wen)
  val reg_mem_rd  = Reg(init = UInt(0), next = mem_rdata)
  val reg_alu_out = Reg(init = UInt(0), next = io.exe.alu_out)
  val reg_wb_sel  = Reg(init = UInt(0), next = io.exe.wb_sel)
  val reg_wb_dst  = Reg(init = UInt(0), next = io.exe.wb_dst)
  val reg_inst    = Reg(init = UInt(0), next = io.exe.inst)

  // output

  io.ctrl.inst  := reg_inst
  io.ctrl.alu_out := reg_alu_out
  io.ctrl.mem_data := reg_mem_rd
  io.ctrl.mem_ren := reg_mem_ren
  io.ctrl.wb_dst := reg_wb_dst
  io.ctrl.wb_sel := reg_wb_sel
  io.ctrl.rf_wen := reg_rf_wen
}

class PipeWB extends Module {
  val io = new Bundle {
    val mem = new MEM2WBSignals().flip()
    val ctrl = new WB2IDSignals()

    val inst = UInt(OUTPUT, 32)
    // stall
    val rd  = UInt(OUTPUT, width = 5)
    val wreg = Bool(OUTPUT)
  }

  io.wreg := io.mem.rf_wen

  val reg_inst    = Reg(init = UInt(0), next = io.mem.inst)
  io.inst := reg_inst

  io.rd := io.mem.wb_dst// io.mem.inst(15, 11)

  io.ctrl.rf_wen := io.mem.rf_wen
  io.ctrl.rf_addr := io.mem.wb_dst
  io.ctrl.rf_data := MuxLookup(io.mem.wb_sel, UInt(0), Array(
    wb_alu -> io.mem.alu_out,
    wb_mem -> io.mem.mem_data
  ))
}

class DebugInfo extends Bundle {
  val regs = Bits(OUTPUT, 32*32)
  val if_inst = UInt(OUTPUT, 32)
  val id_inst = UInt(OUTPUT, 32)
  val exe_inst = UInt(OUTPUT, 32)
  val mem_inst = UInt(OUTPUT, 32)
  val wb_inst = UInt(OUTPUT, 32)
}

class CoreCPU extends Module {
  val io = new Bundle {
    val mem = new MEMSignals().flip()
    val pc = UInt(OUTPUT, 32)
    val inst = UInt(INPUT, 32)

    // required debug info
    val debug = new DebugInfo()
  }

  val IF  = Module(new PipeIF ).io
  val ID  = Module(new PipeID ).io
  val EXE = Module(new PipeEXE).io
  val MEM = Module(new PipeMEM).io
  val WB  = Module(new PipeWB ).io
  val Stall = Module(new PipeStall).io

  io.debug.if_inst := IF.inst
  io.debug.id_inst := ID.ctrl.inst
  io.debug.exe_inst := EXE.ctrl.inst
  io.debug.mem_inst := MEM.ctrl.inst
  io.debug.wb_inst := WB.inst
  io.debug.regs := ID.regs

  IF.pcsource := ID.pcsource
  IF.bpc      := ID.bpc
  IF.jpc      := ID.jpc

  io.pc := IF.pc
  IF.imem := io.inst

  ID.pc4 := IF.pc
  ID.inst := IF.inst

  io.mem <> MEM.mem

  ID.ctrl <> EXE.id
  EXE.ctrl <> MEM.exe
  MEM.ctrl <> WB.mem
  ID.wb <> WB.ctrl

  // stall
  Stall.rt_id := ID.rt
  Stall.rs_id := ID.rs
  Stall.rd_exe := EXE.rd
  Stall.rd_mem := MEM.rd
  Stall.rd_wb  := WB.rd
  Stall.wreg_exe := EXE.wreg
  Stall.wreg_mem := MEM.wreg
  Stall.wreg_wb := WB.wreg

  IF.stall := Stall.stall
  ID.stall := Stall.stall
}

class PipeEXETests(c : IDandEXE) extends Tester(c) {
  // init
  poke(c.io.inst, 0)
  poke(c.io.pc4, 0)
  poke(c.io.wb_rf_wen , 0)
  poke(c.io.wb_rf_addr, 0)
  poke(c.io.wb_rf_data, 0)

  for( i <- 0 to 31) {
    poke(c.io.wb_rf_wen , 1)
    poke(c.io.wb_rf_addr, i)
    poke(c.io.wb_rf_data, i * 100)

    step(1)
  }

  for((inst, pc) <- test_instructions.zipWithIndex) {

    // split inst
    poke(c.io.inst, inst)
    poke(c.io.pc4, (pc + 1) * 4)

    // do not test regfile
    poke(c.io.wb_rf_wen , 0)
    poke(c.io.wb_rf_addr, 0)
    poke(c.io.wb_rf_data, 0)

    step(1)

  }
  step(10)
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

class PipeIDTests(c : PipeID) extends Tester(c) {
  // init
  poke(c.io.inst, 0)
  poke(c.io.pc4, 0)
  poke(c.io.wb.rf_wen , 0)
  poke(c.io.wb.rf_addr, 0)
  poke(c.io.wb.rf_data, 0)
  poke(c.io.rf_addr_t, 0)

  // test regfile first

  for( i <- 0 to 31) {
    poke(c.io.wb.rf_wen , 1)
    poke(c.io.wb.rf_addr, i)
    poke(c.io.wb.rf_data, i * 100)
    poke(c.io.rf_addr_t, i)

    step(1)

    expect(c.io.rf_data_t, i*100)
  }

  // test instruction signals
  for((inst, pc) <- test_instructions.zipWithIndex) {

    // split inst
    poke(c.io.inst, inst)
    poke(c.io.pc4, (pc + 1) * 4)

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
    poke(c.io.wb.rf_wen , 0)
    poke(c.io.wb.rf_addr, 0)
    poke(c.io.wb.rf_data, 0)

    step(1)

    expect(c.io.inst, inst)
    expect(c.io.pc4, (pc + 1) * 4)
  }

  step(2)
}

class IDandEXE extends Module {
  val io = new Bundle {
    // IF input
    val inst = UInt(INPUT, 32)
    val pc4  = UInt(INPUT, 32)

    // wb input
    val wb_rf_wen   = Bool(INPUT)
    val wb_rf_addr  = UInt(INPUT, 5)
    val wb_rf_data  = UInt(INPUT, 32)

    // output
    val exe_out = new EXE2MEMSignals()
  }

  val id = Module(new PipeID())
  val exe = Module(new PipeEXE())

  id.io.inst := io.inst
  id.io.pc4  := io.pc4
  id.io.wb.rf_wen   := io.wb_rf_wen
  id.io.wb.rf_addr  := io.wb_rf_addr
  id.io.wb.rf_data  := io.wb_rf_data
  exe.io.id <> id.io.ctrl

  io.exe_out := exe.io.ctrl
}

