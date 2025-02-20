#!/usr/bin/env lua

local floor = math.floor

local N = 440000000 -- 440 million

local cache = { [0] = 0 }
for i = 1, 9 do
   cache[i] = i ^ i
end

for i = 0, N - 1 do
   local n = i
   local total = 0
   while n > 0 do
      local digit = n % 10
      total = total + cache[digit]
      if total > i then
	 goto continue
      end
      n = floor(n * 0.1)
   end
   if total < i then
      goto continue
   end
   print(i)
   ::continue::
end
