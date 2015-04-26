package arclab.pipeline
package pc

import Chisel._
import common.Constants._

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
