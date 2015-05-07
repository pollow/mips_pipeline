/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */

package arclab.pipeline
package common

import Chisel._

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
  val pc_plus4 :: branch_pc :: jump_pc :: jr_pc :: Nil = Enum(UInt(), 3)
}

trait ALUOpConstants {
  val alu_add :: alu_sub :: alu_or :: alu_and :: alu_xor :: alu_slt :: alu_sll :: alu_srl :: alu_sra :: alu_lui :: Nil= Enum(UInt(), 4)
  val alu_x = UInt(0, 4)
}

trait ControlSignal {
  val Y   = Bool(true)
  val N   = Bool(false)

  // rf data port A selection
  val da_a  = UInt(0, 3)
  val da_x  = UInt(0, 3)

  // rf data port B selection
  val db_b  = UInt(0, 3)
  val db_x  = UInt(0, 3)

  // write back register selection
  val reg_rt = UInt(0, 2)
  val reg_rd = UInt(1, 2)
  val reg_ra = UInt(3, 2)
  val reg_x  = UInt(0, 2)

  // operand 1 selection
  val op1_a = UInt(0)
  val op1_x = UInt(0)

  // operand 2 selection
  val op2_b = UInt(0, 1)
  val op2_imm = UInt(1, 1)
  val op2_x = UInt(0, 1)

  // sign/zero extend
  val sext  = Bool(true)
  val zext  = Bool(false)
  val xext  = Bool(false)

  // write back selection
  val wb_alu  = UInt(0, 2)
  val wb_pc   = UInt(1, 2)
  val wb_mem  = UInt(2, 2)
  val wb_x    = UInt(2, 0)

  // branch
  val br_n  = UInt(0, 3)
  val br_eq = UInt(1, 3)
  val br_ne = UInt(2, 3)
  val br_jr = UInt(3, 3)
  val br_j  = UInt(4, 3)

}

object Constants extends AddressConstants
with PCSourceConstants
with ALUOpConstants
with ControlSignal
{

  class MIPSInstructions

}

