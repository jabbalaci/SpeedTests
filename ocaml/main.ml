let rec pow a b =
  if a = 0 && b = 0 then 0
  else if b = 0 then 1
  else
    let c = pow a (b / 2) in
    if b mod 2 == 0 then c * c
    else a * c * c;;

let is_munchausen cache number =
  let rec go n t =
    if n = 0 then t
    else
      let t' = t + cache.(n mod 10) in
      if t' > number then -1
      else go (n / 10) t' in
  go number 0 == number;;

let cache = Array.init 10 (fun i -> pow i i);;

let max = 440_000_000 in
for i = 0 to max do
  if is_munchausen cache i then
    Printf.printf "%d\n%!" i
done;;
