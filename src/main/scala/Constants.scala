/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */

package arclab.pipeline
package common

import Chisel._

object log2{
  def apply(x:Int) : Int = if (x <= 1) 1 else scala.math.ceil(scala.math.log(x) / scala.math.log(2)).toInt
}

object MIPSInstructions {
  def ADD_                = Bits("b000000????????????????????100000")
  def SUB_                = Bits("b000000????????????????????100010")
  def AND_                = Bits("b000000????????????????????100100")
  def OR_                 = Bits("b000000????????????????????100101")
  def XOR_                = Bits("b000000????????????????????100110")
  def SLT_                = Bits("b000000????????????????????101010")
  def SLL_                = Bits("b000000????????????????????000000")
  def SRL_                = Bits("b000000????????????????????000010")
  def SRA_                = Bits("b000000????????????????????000011")

  def JR_                 = Bits("b000000????????????????????001000")
  def JALR_               = Bits("b000000????????????????????001001")

  def ADDI_               = Bits("b001000??????????????????????????")
  def ANDI_               = Bits("b001100??????????????????????????")
  def ORI_                = Bits("b001101??????????????????????????")
  def XORI_               = Bits("b001110??????????????????????????")

  def LW_                 = Bits("b100011??????????????????????????")
  def SW_                 = Bits("b101011??????????????????????????")

  def BEQ_                = Bits("b000100??????????????????????????")
  def BNE_                = Bits("b000101??????????????????????????")
  def LUI_                = Bits("b001111??????????????????????????")

  def J_                  = Bits("b000010??????????????????????????")
  def JAL_                = Bits("b000011??????????????????????????")

  def NOP_                = Bits("b00000000000000000000000000000000")
}

trait AddressConstants {
  val StartPC = UInt(0, 32)
}

trait PCSourceConstants {
  val pc_sel_size = 4
  val pc_sel_len = log2(pc_sel_size)
  val pc_plus4 :: branch_pc :: jump_pc :: jr_pc :: Nil = Enum(UInt(), pc_sel_size)
}

trait ALUOpConstants {
  val alu_size = 10
  val alu_len = log2(alu_size)
  val alu_add :: alu_sub :: alu_or :: alu_and :: alu_xor :: alu_slt :: alu_sll :: alu_srl :: alu_sra :: alu_lui :: Nil= Enum(UInt(), alu_size)
  val alu_x = alu_add
}

trait ControlSignal {
  val Y   = Bool(true)
  val N   = Bool(false)

  // rf data port A selection
  val da_size = 2
  val da_len = log2(da_size)
  val da_a  = UInt(0, da_size)
  val da_x  = UInt(0, da_size)

  // rf data port B selection
  val db_size = 2
  val db_len = log2(db_size)
  val db_b  = UInt(0, db_size)
  val db_x  = UInt(0, db_size)

  // write back register selection
  val reg_size = 3
  val reg_len = log2(reg_size)
  val reg_rt = UInt(0, reg_size)
  val reg_rd = UInt(1, reg_size)
  val reg_ra = UInt(2, reg_size)
  val reg_x  = UInt(0, reg_size)

  // operand 1 selection
  val op1_size = 1
  val op1_len = log2(op1_size)
  val op1_a = UInt(0, op1_size)
  val op1_x = UInt(0, op1_size)

  // operand 2 selection
  val op2_size = 1
  val op2_len = log2(op2_size)
  val op2_b   = UInt(0, op2_size)
  val op2_imm = UInt(1, op2_size)
  val op2_x   = UInt(0, op2_size)

  // sign/zero extend
  val sext  = Bool(true)
  val zext  = Bool(false)
  val xext  = Bool(false)

  // write back selection
  val wb_size = 3
  val wb_len  = log2(wb_size)
  val wb_alu  = UInt(0, wb_size)
  val wb_pc   = UInt(1, wb_size)
  val wb_mem  = UInt(2, wb_size)
  val wb_x    = UInt(0, wb_size)

  // branch
  val br_size = 5
  val br_len = log2(br_size)
  val br_n  = UInt(0, br_size)
  val br_eq = UInt(1, br_size)
  val br_ne = UInt(2, br_size)
  val br_jr = UInt(3, br_size)
  val br_j  = UInt(4, br_size)

}

object Constants extends AddressConstants
with PCSourceConstants
with ALUOpConstants
with ControlSignal
{
  val test_instructions = List(
    0x20100005,
    0x30110000,
    0x36310003,
    0x02119020,
    0x02119822,
    0x0211a024,
    0x0211a825,
    0x00108082,
    0x001087c0,
    0x001087c3,
    0xac120000,
    0x8c130000,
    0x2252ffff,
    0x12530002,
    0x22520001,
    0x0800000d,
    0x16530002,
    0x2272ffff,
    0x08000010,
    0x08000013

  )

}

