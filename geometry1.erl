-module(geometry1).
-export([test/0, area/1]).


test() ->
    12 = area({rectangle, 4, 3}),
    144 = area({square, 12}),
    "tests worked".

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side;
area({triangle, Base, Height})   -> (Base * Height)/2;  % 1. right triangle area
area({circle, Radius})           -> math:pi() * math:pow(Radius, 2).  % 1. circle area
