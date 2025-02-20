440000000 constant N

: selfpow ( n -- n^n )  1 over 0 do over * loop nip ;

create cache 0 , 9 cells allot

: cache@ ( i -- n )  cells cache + @ ;
: initcache ( -- )  10 1 do i selfpow i cells cache + ! loop ;

initcache

: munchausen? ( n -- f )
  >r 0 r@
  begin ( total n r:number )
       tuck 10 mod cache@ + swap ( total n )
       over r@ > if 2drop rdrop false exit then
       10 / ?dup 0=
  until r> = ;

: main
  N 0 do
    i munchausen? if i . cr then
  loop ;

main bye