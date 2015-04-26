/**
 * Created by Deus@ZJU on 4/26/15.
 *
 */

package arclab.pipeline
package common

import Chisel._

trait AddressConstants {
  val StartPC = UInt(0, 32)
}

trait PCSourceConstants {
  val pc_plus4 :: branch_pc :: jump_pc :: Nil = Enum(UInt(), 3)
}

object Constants extends AddressConstants
with PCSourceConstants
{

}

