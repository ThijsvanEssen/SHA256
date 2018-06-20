module SHA256PIPED where

import SHA256 hiding (compressBlock, processBlock, hash, digest, digest', topEntity)
import CLaSH.Prelude
import CLaSH.Sized.Internal.BitVector
import Numeric
import Data.Char
import qualified Data.List as L

-- Auxillary --
-- | Initla value for register.
initReg :: Vec 8 (BitVector 32)
initReg = repeat 8

-- | This function compresses an entire block. This is based on the schedule and the round
--   constants. These are combined using the zip function. Using the Applicative style the
--   compress function is raised to work on the signal types.
compressBlock :: Schedule -> RoundConstant -> Signal HashState -> Signal HashState
compressBlock w k h = compressed'
  where
    (f, l)      = splitAt d2 $ zip k w
    compressed  = foldl compress <$> h   <*> pure f
    compressed' = foldl compress <$> reg <*> pure l
    reg         = register initReg compressed

-- | This function processes an entire block. It creates the schedule using the generate function.
--   The Hash Values are added components wise to the previous iteration using zipWith. Using the
--   Applicative style the compress function is raised to work on the signal types.
processBlock :: Signal HashState -> Schedule -> Signal HashState
processBlock h block = zipWith (+) <$> h <*> h'
  where
    h' = compressBlock w k h
    w  = last $ generate d48 constructSchedule block

-- | This function processes an entire block. It creates the schedule using the generate function.
--   The Hash Values are added components wise to the previous iteration using zipWith.
hash :: Signal HashState -> Block -> Signal HashState
hash hashState block = hashState'
  where
    hashState' = processBlock hashState $ toSchedVec block

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
