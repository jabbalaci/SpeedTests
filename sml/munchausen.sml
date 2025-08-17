fun main () =
  let
    (* utilities *)
    fun compound 0 f x = x
      | compound n f x = compound (n-1) f (f x)
    fun expt x y = compound y (fn z => x * z) 1
    fun rangeIter x y r =
      if x = y then
        x::r
      else
        rangeIter x (y - 1) (y::r)
    fun range x y =
      rangeIter x y []
    (* main part *)
    val cache = Vector.fromList (0 :: (map (fn x => expt x x) (range 1 9)))
    fun cacheN x = Vector.sub (cache, x)
    fun munchausenp x =
      let fun iter (n, r) =
        case (n > 0, r > x)
          of (false, _) => r = x
           | (_, true)  => false
           | (_, false) => iter (n div 10, r + cacheN (n mod 10))
      in
        iter(x div 10, cacheN (x mod 10))
      end
    val max = 440000000
    fun loop i =
      case (i < max, munchausenp i)
        of (false, _) => ()
         | (_, false) => loop (1 + i)
         | (_, true)  => (print ((Int.toString i) ^ "\n") ; loop (1 + i))
  in
    loop 0
  end
;; (* end of main *)
