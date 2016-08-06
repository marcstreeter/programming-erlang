-module(attrs).
-vsn(1234).
-author("Marc Streeter").
-purpose("Example of Attributes, and hey, why not?").
-export([fac/1]).

fac(1) -> 1;
fac(N) -> N * fac(N-1).
