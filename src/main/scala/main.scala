/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */
package arclab.pipeline
package top

import Chisel._
import arclab.pipeline.stages._
import arclab.pipeline.common.Constants._

class Main extends Module {
  val io = new Bundle {
    val pc = UInt(OUTPUT, 32)
    val inst = UInt(INPUT, 32)

    val debug = new DebugInfo()
  }

  val cpu = Module(new CoreCPU()).io
  val mem = Module(new Memory()).io

  cpu.mem <> mem
  io.pc := cpu.pc
  cpu.inst := io.inst

  io.debug <> cpu.debug
}

class TopTests(c : Main) extends Tester(c) {
  step(2)
  reset(1)
  for(i <- 0 to 60) {
    val pc = peek(c.io.pc).toInt >> 2
    poke(c.io.inst, if (pc < test_instructions.length) test_instructions(pc) else 0)
    step(1)
  }
}

object Top {
  def main(args: Array[String]): Unit = {
    args.foreach(arg => println(arg))
    // chiselMainTest(args, () => Module(new PipeIF())) { c => new PipeIFTests(c) }
    // chiselMainTest(args, () => Module(new PipeID())) { c => new PipeIDTests(c) }
    // chiselMainTest(args, () => Module(new IDandEXE())) { c => new PipeEXETests(c) }
    chiselMainTest(args, () => Module(new Main())) { c => new TopTests(c) }
  }
}
