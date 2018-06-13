  module SHA256 where

import CLaSH.Prelude
import CLaSH.Sized.Internal.BitVector
import Numeric
import Data.Char
import qualified Data.List as L

-- Types --

-- | One block of 512 bits.
type Block          = BitVector 512
-- | A message restricted to only one block.
type Message        = Vec 1 (Block)
-- | The vector containing all round constants as specified in SHA256.
type RoundConstant  = Vec 64 (BitVector 32)
-- | The current state of the HashValue. Used to indicate intermediate Hash Values.
type HashState      = Vec 8 (BitVector 32)
-- | Hash Values as specified in SHA256.
type HashValue      = Vec 8 (BitVector 32)
-- | Vector used in the genration of the Schedule. The vector represents a sliding
--   window.
type ScheduleWindow = Vec 64 (BitVector 32)
-- | The vector containing all the values in the schedule. The schedule is constructed
--   in accordance with the specification in SHA256.
type Schedule       = Vec 64 (BitVector 32)
-- | Construct which allows the corresponding schedule and round constant value to be
--   combined.
type RoundPair      = (BitVector 32, BitVector 32)

-- Predetermined Values --

-- | Round constants used in the compression of the message.
--   First 32 bits of the fractional parts of the cube roots of the first 64 primes (2..311).
k :: RoundConstant
k = (0x428a2f98:> 0x71374491:> 0xb5c0fbcf:> 0xe9b5dba5:> 0x3956c25b:> 0x59f111f1:> 0x923f82a4:> 0xab1c5ed5:>
     0xd807aa98:> 0x12835b01:> 0x243185be:> 0x550c7dc3:> 0x72be5d74:> 0x80deb1fe:> 0x9bdc06a7:> 0xc19bf174:>
     0xe49b69c1:> 0xefbe4786:> 0x0fc19dc6:> 0x240ca1cc:> 0x2de92c6f:> 0x4a7484aa:> 0x5cb0a9dc:> 0x76f988da:>
     0x983e5152:> 0xa831c66d:> 0xb00327c8:> 0xbf597fc7:> 0xc6e00bf3:> 0xd5a79147:> 0x06ca6351:> 0x14292967:>
     0x27b70a85:> 0x2e1b2138:> 0x4d2c6dfc:> 0x53380d13:> 0x650a7354:> 0x766a0abb:> 0x81c2c92e:> 0x92722c85:>
     0xa2bfe8a1:> 0xa81a664b:> 0xc24b8b70:> 0xc76c51a3:> 0xd192e819:> 0xd6990624:> 0xf40e3585:> 0x106aa070:>
     0x19a4c116:> 0x1e376c08:> 0x2748774c:> 0x34b0bcb5:> 0x391c0cb3:> 0x4ed8aa4a:> 0x5b9cca4f:> 0x682e6ff3:>
     0x748f82ee:> 0x78a5636f:> 0x84c87814:> 0x8cc70208:> 0x90befffa:> 0xa4506ceb:> 0xbef9a3f7:> 0xc67178f2:>Nil)

-- | Hash values, this vector is the base of the 256-bit result.
--   First 32 bits of the fractional parts of the square roots of the 8 primes (2..19).
hs :: HashValue
hs = (0x6a09e667 :> 0xbb67ae85 :> 0x3c6ef372 :> 0xa54ff53a :> 0x510e527f :> 0x9b05688c :> 0x1f83d9ab :> 0x5be0cd19 :> Nil)

-- Auxillary and prettify functions --

-- | Unicode wrapper for `xor`
(⊕) :: Bits a => a -> a -> a
x ⊕ y = xor x y
-- | Unicode wrapper for `rotateR`
(>>>) :: Bits a => a -> Int -> a
x >>> y = rotateR x y
-- | Unicode wrapper for `shiftR`
(>>|) :: Bits a => a -> Int -> a
x >>| y = shiftR x y
-- | Unicode wrapper for `complement`
(¬) :: Bits a => a -> a
(¬) x = complement x
-- | Auxillary function to easily transform a block to a schedule. Used to start of
--   schedule generation.
toSchedVec :: Block -> ScheduleWindow
toSchedVec bitVec = repeat 0 ++ unpack bitVec
-- | Creates a human readable string based on HashValue.
postprocess :: HashValue -> String
postprocess i = foldl1 (L.++) $ map (\x -> showIntAtBase 16 intToDigit (fromEnum x) "") i
-- | Creates a human readable string based on BitVector representation of HashValue.
postprocess' :: BitVector 256 -> String
postprocess' i = foldl1 (L.++) $ map (\x -> showIntAtBase 16 intToDigit (fromEnum x) "") i'
  where
    i' = unpack i :: HashState

-- SHA256 Functions --

-- | This function creates the Message Schedule for processing one block in the SHA256
--   algorithm. It utilises a sliding window principal to determine the next value which
--   should be added to the Schedule. This function only determines and adds one schedule.
--   value. The structure of sliding is specific to ensure that the schedule can be zipped
--   with round constants.
constructSchedule :: ScheduleWindow -> Schedule
constructSchedule w = w <<+ (s0 + w16 + s1 + w7)
    where
      w2  = w !! 62
      w7  = w !! 57
      w15 = w !! 49
      w16 = w !! 48
      s0  = (w15 >>> 7) ⊕ (w15 >>> 18) ⊕ (w15 >>| 3)
      s1  = (w2 >>> 17) ⊕ (w2  >>> 19) ⊕ (w2  >>| 10)

-- | This function compresses one single set of hash values using the correct roundpair.
--   Since it is an intermediate step the hash values are indicated with the state signifier.
compress :: HashState -> RoundPair -> HashState
compress (a:>b:>c:>d:>e:>f:>g:>h:>Nil) (k, w)  = (temp1 + temp2) +>> (a:>b:>c:>d+temp1:>e:>f:>g:>h:>Nil)
    where
      s1 = (e >>> 6) ⊕ (e >>> 11) ⊕ (e >>> 25)
      ch = (e .&. f) ⊕ ((¬) e .&. g)
      s0 = (a >>> 2) ⊕ (a >>> 13) ⊕ (a >>> 22)
      ma = (a .&. b) ⊕ (a .&. c) ⊕ (b .&. c)
      temp1 = h + s1 + ch + k + w
      temp2 = s0 + ma

-- | This function compresses an entire block. This is based on the schedule and the round
--   constants. These are combined using the zip function.
compressBlock :: Schedule -> RoundConstant -> HashState -> HashState
compressBlock w k h = foldl compress h $ zip k w

-- | This function processes an entire block. It creates the schedule using the generate function.
--   The Hash Values are added components wise to the previous iteration using zipWith.
processBlock :: HashState -> ScheduleWindow -> HashState
processBlock h block = zipWith (+) h $ compressBlock w k h
  where
    w = last $ generate d48 constructSchedule block

-- | This function processes an entire block. It creates the schedule using the generate function.
--   The Hash Values are added components wise to the previous iteration using zipWith.
hash :: HashState -> Block -> HashState
hash hashState block = hashState'
  where
    hashState' = processBlock hashState $ toSchedVec block

-- | The digest function creates the hash for a message which is already properly formatted.
--   By folding over every block with the hash function the Hash Values are updated in accordance
--   with the specification and yield the correct result.
digest :: Message -> HashState
digest blocks = foldl hash hs blocks

-- | Helper function to counter act pin constraints on an FPGA.
digest' :: BitVector 480 -> HashState
digest' block = digest ((pack ((unpack block :: Vec 15 (BitVector 32)) ++ repeat 0 :: Vec 16 (BitVector 32))):>Nil)

-- | TopEntity declarded for CLaSH Compiler.
topEntity :: BitVector 480 -> HashState
topEntity = digest'

-- Examples Blocks --

emptyString :: Block
emptyString  = pack ((2^31 :: BitVector 32) :> replicate d15 (0 :: BitVector 32) :: Vec 16 (BitVector 32))

emptyString' :: BitVector 480
emptyString'  = pack ((2^31 :: BitVector 32) :> replicate d14 (0 :: BitVector 32) :: Vec 15 (BitVector 32))
