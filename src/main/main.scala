/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */

package arclab_pipeline

import Chisel._

class Top extends Module {
  val io = new Bundle();

}

class TopTests(c : Top) extends Tester(c) {

}

object Top {
  def main(args: Array[String]): Unit = {
    args.foreach(arg => println(arg))
    chiselMainTest(args, () => Module(new Top())) {
      c => new TopTests(c) }
  }
}
