program Munchausen;
uses math;

procedure CalcCache(var cache: array of UInt32);
var
  i: UInt32;
begin
  cache[0] := 0;
  for i := 1 to 9 do
  begin
    cache[i] := i**i;
  end;

end;

function IsMunchausen(constref cache: array of UInt32;  num: UInt32): Boolean;
var
  n, total, digit: UInt32;
  tn: UInt32;
begin
  n := num;
  total := 0;
  while n > 0 do
    begin
      tn:= n DIV 10;
      digit:=n-tn*10;
      n:=tn;
      total += cache[digit];
      if total > num then
        break;
    end;
  IsMunchausen := num = total;
end;

var
  cache: array[0..9] of UInt32;
  i: UInt32;
const
  MAX = 440000000;
begin
  CalcCache(cache);
  for i in TRange do //:= 0 to MAX do
    if IsMunchausen(cache, i) then
      WriteLn(i);
end.

