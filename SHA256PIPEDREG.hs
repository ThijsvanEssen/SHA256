module SHA256PIPEDREG where

import SHA256REG hiding (hash, digest, digest', topEntity)
import CLaSH.Prelude
import CLaSH.Sized.Internal.BitVector
import Numeric
import Data.Char
import qualified Data.List as L

-- Auxillary --
-- | Initla value for register
initRegBlock :: BitVector 512
initRegBlock = 8
initRegSched :: Schedule
initRegSched = repeat 8

-- | This function processes an entire block. It creates the schedule using the generate function.
--   The Hash Values are added components wise to the previous iteration using zipWith.
hash :: Signal HashState -> Block -> Signal HashState
hash hashState block = hashState'
  where
    block' = register initRegBlock $ signal block
    oSched = last . (generate d48 constructSchedule) . toSchedVec <$> block'
    iCompr = register initRegSched oSched
    oCompr = compressBlock <$> iCompr <*> pure k <*> hashState
    hashState' = zipWith (+) <$> hashState <*> oCompr

-- | The digest function creates the hash for a message which is already properly formatted.
--   By folding over every block with the hash function the Hash Values are updated in accordance
--   with the specification and yield the correct result. The initial Hash Values are signalled.
digest :: Message -> Signal HashState
digest blocks = foldl hash (signal hs) blocks

-- | Helper function to counter act pin constraints on an FPGA.
digest' :: BitVector 320 -> Signal HashState
digest' block = digest ((pack ((unpack block :: Vec 10 (BitVector 32)) ++ repeat 0 :: Vec 16 (BitVector 32))):>Nil)

-- | TopEntity declarded for CLaSH Compiler.
topEntity :: BitVector 320 -> Signal HashState
topEntity = digest'


foldl' f v l = (vs', z)
  where
    vs'' = zipWith f (v +>> l) l
    vs'  = init vs''
    z    = head vs''
