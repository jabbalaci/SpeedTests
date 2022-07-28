program Munchausen;
uses math;

procedure CalcCache(var cache: array of LongInt);
var
  i: Integer;
begin
  cache[0] := 0;
  for i := 1 to 9 do
    cache[i] := i**i;
end;

function IsMunchausen(constref cache: array of LongInt; constref num: LongInt): Boolean;
var
  n, total, digit: LongInt;
begin
  n := num;
  total := 0;
  while n > 0 do
    begin
      DivMod(n, 10, n, digit);
      total += cache[digit];
      if total > num then
        break;
    end;
  IsMunchausen := num = total;
end;

var
  cache: array[0..9] of LongInt;
  i: LongInt;
const
  MAX = 440000000;
begin
  CalcCache(cache);
  for i := 0 to MAX do
    if IsMunchausen(cache, i) then
      WriteLn(i);
end.
