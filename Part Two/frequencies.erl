-module(frequencies).
 - export([return_wordlist/1, word_tuples/2, return_hashed/1, output/1]).

%takes in a filename and returns a list of the strings in the file.
return_wordlist(FILENAME) ->
  {ok, FILE} = file:open(FILENAME,[read]),
  LINE = io:get_line(FILE, ''),
  string:tokens(LINE, " ").

%takes in a string and a list of tuples. updates frequency of string 
%if it is repeated or updates the list if the string isn't included.
word_tuples(STRING, TUPLESLIST) ->
  CHECK = lists:keyfind(STRING, 1, TUPLESLIST),
  if 
    CHECK == false ->
      lists:append(TUPLESLIST, [{STRING, 1}]);
    true ->
      {_, FREQ} = CHECK,
      lists:keyreplace(STRING, 1, TUPLESLIST, {STRING, FREQ + 1})
  end.

%takes in a list of strings and goes through it, calling the word_tuples function. returns the hashed list.
return_hashed(WORDLIST) ->
  lists:foldl(fun(WORD, FREQ) -> word_tuples(WORD, FREQ) end, [], WORDLIST).

%takes in the filename and outputs the hashed list sorted from most frequent word to least.
output(FILENAME) ->
  WORDLIST = return_wordlist(FILENAME),
  HASHLIST = return_hashed(WORDLIST),
  lists:sort(fun({KEYA,VALA}, {KEYB,VALB}) -> {VALA,KEYA} >= {VALB,KEYB} end, HASHLIST).


