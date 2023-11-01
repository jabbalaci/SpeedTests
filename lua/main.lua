#!/usr/bin/env lua

function main()
    local N = 440000000 -- 440 million

    local is_munchausen
    if _VERSION < "Lua 5.3" then
        is_munchausen = require("munchausen-51")
    else
        is_munchausen = require("munchausen-53")
    end

    local cache = { [0] = 0 }
    for i = 1, 9 do
        cache[i] = i ^ i
    end

    for n = 0, N - 1 do
        if is_munchausen(n, cache) then
            print(n)
        end
    end
end

main()
