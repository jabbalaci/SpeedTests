import kotlin.math.pow

val LIMIT = 440_000_000;
val cache = Array(10) { i -> i.toFloat().pow(i.toFloat()).toInt() }

fun isMunchausen(number: Int): Boolean {
    var n = number
    var total = 0

    while (n > 0) {
        val digit = n % 10
        total += cache[digit]
        if (total > number) {
            return false
        }
        n = n / 10
    }
    return total == number
}

fun main(args: Array<String>) {
    for (i in 0 until LIMIT) {
        if (isMunchausen(i)) {
            println(i)
        }
    }
}
