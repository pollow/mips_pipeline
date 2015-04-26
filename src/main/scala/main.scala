/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */
package arclab.pipeline
package top

import Chisel._
import pc._

class Top extends Module {
  val io = new Bundle();

}

class TopTests(c : Top) extends Tester(c) {

}

object Top {
  def main(args: Array[String]): Unit = {
    args.foreach(arg => println(arg))
    chiselMainTest(args, () => Module(new PipePC())) {
      c => new PipePcTests(c) }
  }
}
