/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */
package arclab.pipeline
package top

import Chisel._
import if_stage._

class Top extends Module {
  val io = new Bundle {
    val pc = UInt(OUTPUT, 32)
    val inst = UInt(INPUT, 32)
  }

  val cpu = Module(new CoreCPU()).io
  val mem = Module(new Memory()).io

  cpu.mem <> mem
  io.pc := cpu.pc
  cpu.inst := io.inst
}

class TopTests(c : Top) extends Tester(c) {

}

object Top {
  def main(args: Array[String]): Unit = {
    args.foreach(arg => println(arg))
    // chiselMainTest(args, () => Module(new PipePC())) { c => new PipePCTests(c) }
    // chiselMainTest(args, () => Module(new PipeID())) { c => new PipeIDTests(c) }
    chiselMainTest(args, () => Module(new IDandEXE())) { c => new PipeEXETests(c) }
  }
}
