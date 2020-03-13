%%%-------------------------------------------------------------------
%%% @author Mithrian812
%%% @copyright (C) 2020, <Me>
%%% @doc
%%%
%%% @end
%%% Created : 12. mar 2020 21:37
%%%-------------------------------------------------------------------
-module(rpnCalc).
-author("Mithrian812").

%% API
-export([calculateRPN/1]).


calculateRPN(S) -> calculateRPN(string:tokens(S, " "), []).

calculateRPN([], [Stack]) -> Stack;
calculateRPN([H | T], Stack) ->
  case lists:member(H, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]) of
    true -> calculateRPN(T, [list_to_integer(H) | Stack]);
    false -> calculateRPN2([H | T], Stack)
  end.

calculateRPN2([H | T], [S1, S2 | Stack]) ->
  if H == "+" ->
    calculateRPN(T, [S1 + S2 | Stack])
  ; H == "-" ->
    calculateRPN(T, [S1 - S2 | Stack])
  ; H == "*" ->
    calculateRPN(T, [S1 * S2 | Stack])
  ; H == "/" ->
    calculateRPN(T, [S1 / S2 | Stack])
  end.


