-module(students).
 -export([check_odd_num/1, blow_Whistle/4, output/4, get_even_number/0, init/0]).

%Checks if number is odd, if it is increment by 1(Teacher gives 1 candy).
check_odd_num(X) when X rem 2 =:= 1 ->
  Y = X + 1;
check_odd_num(X) when X rem 2 =:= 0 ->
  Y = X.

%Generate a random even number from 2 to 2 times whatever is after uniform.
get_even_number() -> rand:uniform(10000) * 2.

%Output the turn number and the amount of candy each student has.
output(S1, S2, S3, TURNS) -> 
  io:format("turn: ~B ~n student1: ~B, student2: ~B, student3: ~B ~n", [TURNS, S1, S2, S3]).

%Outputs the turn info, checks if students have odd amount of candy, passes half of each students candy to student on right.
%Increments turn by 1 then calls itself again. Will keep calling itself until each student has the same amount of candy.
blow_Whistle(STUDENT1, STUDENT2, STUDENT3, TURN) when STUDENT1 =/= STUDENT2; STUDENT1 =/= STUDENT3; STUDENT2 =/= STUDENT3 -> 
  output(STUDENT1, STUDENT2, STUDENT3, TURN),
  S1HALF = check_odd_num(STUDENT1) div 2,
  S2HALF = check_odd_num(STUDENT2) div 2,
  S3HALF = check_odd_num(STUDENT3) div 2,
  _S1 = S1HALF + S3HALF,
  _S2 = S2HALF + S1HALF,
  _S3 = S3HALF + S2HALF,
  TURNS = TURN + 1,  
  blow_Whistle(_S1, _S2, _S3, TURNS);
blow_Whistle(STUDENT1, STUDENT2, STUDENT3, TURN) when STUDENT1 =:= STUDENT2, STUDENT2 =:= STUDENT3 ->
  output(STUDENT1, STUDENT2, STUDENT3, TURN),
  io:format("EVERYONE HAS THE SAME AMOUNT OF CANDY!").

%Initializes each student's amount of candy and starts turn at 0, then blows whistle.
init() ->
  TURNS = 0,
  S1 = get_even_number(),
  S2 = get_even_number(),
  S3 = get_even_number(),
  blow_Whistle(S1, S2, S3, TURNS).