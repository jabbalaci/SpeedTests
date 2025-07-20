namespace fs
open System


module Program =

    let inline getCache() =
        Array.init(10) (fun i -> (Math.Pow(i, i) |> int) )

    let inline isMunchausen(number:int, cache:array<int>)= //Span<int>) =
        let mutable n:int = number
        let mutable total:int = 0
        while (n>0) do 
            total <- total + cache[n % 10]
            n <- if (total > number) then 0 else n / 10
        total = number

    let inline munchausen() =
        let mutable result = 0
        let cache = getCache()
        cache[0] <- 0
        for i = 0 to (440_000_000-1) do
            if isMunchausen(i,cache) then
                Console.WriteLine(i)
                result <- result + 1
        result

    [<EntryPoint>]
    let main(args: string[]) =
        munchausen() |> ignore
        0