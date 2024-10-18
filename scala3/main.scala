import scala.math.pow

@annotation.tailrec
def isMunchausen(number: Int, n: Int, total: Int, cache: Array[Int]): Boolean =
    if total > number then
        false
    else if n > 0 then
        isMunchausen(number, n / 10, total + cache(n % 10), cache)
    else
        number == total

@main def main() =

    val cache: Array[Int] = Array(0).appendedAll(
        (1 to 9)
            .map(_.toFloat)
            .map(i => pow(i, i).toInt)
    )

    (0 until 440000000).foreach(i => (
        if isMunchausen(i, i, 0, cache) then println(i)
    ))
