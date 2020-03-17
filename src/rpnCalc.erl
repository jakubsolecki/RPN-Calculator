%%%-------------------------------------------------------------------
%%% @author Jakub
%%% @copyright (C) 2020, <Me>
%%% @doc
%%%
%%% @end
%%% Created : 12. mar 2020 21:37
%%%-------------------------------------------------------------------
-module(rpnCalc).
-author("Jakub").

%% API
-export([calculateRPN/1]).


calculateRPN(S) -> calculateRPN(string:tokens(S, " "), []).

calculateRPN([], [Stack]) -> Stack;
calculateRPN([H | T], Stack) ->
  case re:run(H, "^[0-9]*$") /= nomatch of
    true -> calculateRPN(T, [list_to_integer(H) | Stack]);
    false -> case re:run(H, "^[0-9]+.[0-9]+$") /= nomatch of
               true -> calculateRPN(T, [list_to_float(H) | Stack]);
               false -> calculateRPN2([H | T], Stack)
             end
  end.

calculateRPN2([H | T], [S1, S2 | Stack]) ->
  if H == "+" ->
    calculateRPN(T, [S1 + S2 | Stack])
  ; H == "-" ->
    calculateRPN(T, [S2 - S1 | Stack])
  ; H == "*" ->
    calculateRPN(T, [S1 * S2 | Stack])
  ; H == "/" ->
    calculateRPN(T, [S2 / S1 | Stack])
  ; H == "pow" ->
    calculateRPN(T, [math:pow(S2, S1) | Stack])
  end;

calculateRPN2([H | T], [S | Stack]) ->
  if H == "sqrt" ->
    calculateRPN(T, [math:sqrt(S) | Stack])
  ; H == "sin" ->
    calculateRPN(T, [math:sin(math:pi() * S / 180) | Stack])
  ; H == "cos" ->
    calculateRPN(T, [math:cos(math:pi() * S / 180) | Stack])
  ; H == "tan" ->
    calculateRPN(T, [math:tan(math:pi() * S / 180) | Stack])
  end.


