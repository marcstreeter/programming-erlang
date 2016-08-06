-module(mailbox).
-export([priority_receive/0, area/2, start/0]).

area(Pid, What) ->
  rpc(Pid, What).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid, Response} ->
      Response;
    Any ->
      Any
  end.

start() -> spawn(mailbox, priority_receive, []).

priority_receive() ->
  receive
    {From, {alarm, X}} ->
      From ! {alarm, X, X},
      priority_receive()
  after 10000 ->
    receive
      {From, Any} ->
        From ! {"received this in second location", Any},
        priority_receive()
    end
  end.
