-module(lib_misc).
-export([qsort/1,
         pythag/1,
         perms/1,
         odds_and_evens/1,
         odds_and_evens_better/1,
         keep_alive/2]).

qsort([])         -> [];
qsort([Pivot| T]) ->
  qsort([X || X <- T, X < Pivot])
  ++ [Pivot] ++
  qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
  [ {A,B,C} ||
     A <- lists:seq(1,N),
     B <- lists:seq(1,N),
     C <- lists:seq(1,N),
     A+B+C =< N,
     A*A+B*B =:= C*C
  ].

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L -- [H])].


odds_and_evens(L) ->
  Odds  = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

odds_and_evens_better(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;

odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}.

on_exit(Pid, Fun) ->
  spawn(fun() ->
                Ref = monitor(process, Pid),
                receive
                  {'DOWN', Ref, process, Pid, Why} ->
                    Fun(Why)
                end
        end).

keep_alive(Name, Fun) ->
  register(Name, Pid=spawn(Fun)),
  on_exit(Pid, fun(_Why) -> keep_alive(Name, Fun)
end).
