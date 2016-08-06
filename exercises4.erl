-module(exercises4).
-export([test/0,
         area/1,
         my_tuple_to_list/1,
         my_time_func/1,
         my_date_string/0]).
test() ->
    12 = area({rectangle, 4, 3}),
    144 = area({square, 12}),
    314.1592653589793 = area({circle, 10}),
    50.0 = area({triangle, 10, 10}),
    [my1, tuple2, to3, list4] = my_tuple_to_list({my1, tuple2, to3, list4}),
    1 = my_time_func(fun() -> timer:sleep(1000) end),
    "tests worked".



% 1. Extend geometry.erl. Add clauses to compute the areas of circles and right-angled triangles. Add clauses for computing the perimeters of different geometric objects.% 1.
area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side;
area({triangle, Base, Height})   -> (Base * Height)/2;  % 1. right triangle area
area({circle, Radius})           -> math:pi() * math:pow(Radius, 2).  % 1. circle area

% 2. The BIF tuple_to_list(T) converts the elements of the tuple T to a list. Write a function called my_tuple_to_list(T) that does the same thing only not using the BIF that does this.% 1.
my_tuple_to_list({}) -> [];
my_tuple_to_list(Tuple) ->
  El = element(1, Tuple),
  [El | my_tuple_to_list(erlang:delete_element(1, Tuple))].
% 3. Look up the definitions of
%   erlang:now/0,
%   erlang:date/0, and
%   erlang:time/0.
%   -- from what I've read, erlang:now/0 is deprecated in favor of
%   -- erlang:monotonic_time/0
% Write a function called my_time_func(F),
%    which evaluates the fun F and times how long it takes.
my_time_func(F) ->
  % gives time in whole seconds (rounded down)
  StartTime = erlang:monotonic_time(),
  _ = F(),
  EndTime = erlang:monotonic_time(),
  TimeSpent = (EndTime - StartTime)/1000000000,
  trunc(TimeSpent).
% Write a function called my_date_string()
%    that neatly formats the current date and time of day.
day_to_str(Date) ->
  DayOfTheWeek = calendar:day_of_the_week(Date),
  case DayOfTheWeek of
    1 -> "monday";
    2 -> "tuesday";
    3 -> "wednesday";
    4 -> "thursday";
    5 -> "friday";
    6 -> "saturday";
    7 -> "sunday"
  end.

my_date_string() ->
  Date = date(),
  {Year, Month, Day} = Date,
  [DateStr, ok] = io:format("~s, ~w/~w/~w", [day_to_str(Date), Year, Month, Day]),
  DateStr.
% 4. Advanced: Look up the manual pages for the
%    Python datetime module. Find out how many of methods in the
%    Python datetime class can be implemented using the time-related
%    BIFs in the erlang module. Search the erlang manual pages for
%    equivalent routines. Implement any glaring omissions.% 1.

% 5. Write a module called math_functions.erl, exporting the functions even/1 and odd/1. The function even(X) should return true if X is an even integer and otherwise false. odd(X) should return true if X is an odd integer.% 1.

% 6. Add a higher-order function to math_functions.erl called filter(F, L), which returns all the elements X in L for which F(X) is true.% 1.

% 7. Add a function split(L) to math_functions.erl, which returns {Even, Odd} where Even is a list of all the even numbers in L and Odd is a list of all the odd numbers in L. Write this function in two different ways using accumulators and using the function filter you wrote in the previous exercise.
