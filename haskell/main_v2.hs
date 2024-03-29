{-# LANGUAGE BangPatterns #-}
import qualified Data.Vector.Unboxed as VU

nMax :: Int
nMax = 440000000

isMunchausen :: Int -> VU.Vector Int -> Bool
isMunchausen number cache = go number 0
  where
    go n total
      | n > 0 =
        let total' = total + VU.unsafeIndex cache (n `rem` 10)
        in if total' > number
          then False
          else go (n `quot` 10) total'
      | otherwise = number == total

main :: IO ()
main = do
  let !cache = VU.fromList $ 0 : [i ^ i | i <- [1 .. 9]]
  VU.mapM_ print $ VU.filter (`isMunchausen` cache) $ VU.generate nMax id
