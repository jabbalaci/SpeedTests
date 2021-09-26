isMunchausen :: Int -> Int -> Int -> [Int] -> Bool
isMunchausen number n total cache
  | total > number = False
  | n > 0 = isMunchausen number (n `div` 10) (total + (cache !! (n `mod` 10))) cache
  | otherwise = number == total

main = do
  let cache = 0 : [i ^ i | i <- [1 .. 9]]
  mapM_ print $ filter (\i -> isMunchausen i i 0 cache) [0 .. 440000000]
  return 0
