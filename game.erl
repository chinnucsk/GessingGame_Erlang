%% Author: Amir Almasi
%%
%% A module to implement the guessing game and let the user play the game.
%% The game is flixebale to get all kind of data from the console entered by
%% user. Then, the data would be checked to print out the proper message 
%% releavant to entered data.
%%
%% Created on July 12, 2011
%% Implemented time in the game.
%% Edit on July 14, 2011
%% Added game counter to count how many times the user tries to quess.
%% Edit on July 15, 2011 
%% Implemented new method, check validate, to check if the entered data
%% is a valid integer or not, The counsole data can be mixture of integer
%% and characters.

-module(game).
-export([start/0]).

%% The main method to be called from out of the module to start playing the game.
start() ->
	play(makeRandom (100),1,element(2,now())).
	
%% Play method is the one to start the game.
%% The method with the guard would be called when user has guessted more
%% than 15 times. Then, ask user if he/she wants to continue or not. 
play(RandomNumber,PlayCounter,Time) when PlayCounter > 15 ->
	case string:to_lower(hd(element(2,io:fread("You were not able to guess the secret number by 15 time guess, would you like to play the game again(YES/No)? " ,"~s")))) of
		"yes" -> play(makeRandom (100),1,element(2,now()));
		"no" -> "have a good time!!";
		_ -> play(RandomNumber,PlayCounter,Time)
	end;
%% The method to play the game.
play(RandomNumber,PlayCounter,Time) ->
	%%io:format("The random number is: ~w ~n" , [checkValidate(string:to_integer(checkInput(getInput())))]).
	case compareValue(checkValidate(string:to_integer(checkInput(getInput()))),RandomNumber) of
		false -> play(RandomNumber,PlayCounter+1,Time);
		exit -> "Hope you have anjoyed playing this game. Hope to see you again";
		_ -> string:concat(string:concat(string:concat("The entered guess is the secret number!! congradulations you have guested the secret number by ", integer_to_list(PlayCounter))," times quessing!! in time of "), string:concat(integer_to_list(element(2,now()) - Time), " seconds"))
	end.
	
%% A method to read a string entered by user in the console and return it.
getInput() ->
	io:fread("Please enter a integer input: ", "~s").

%% A method to check if the user preferes to exit the game or not.
checkInput({ok,["exit"]}) -> 
	io:fwrite("You have chosen to exit the the software ~n"),
	exit;
checkInput({ok,[H|_]}) -> 
	string:strip(H, both, $.);
checkInput({_,_}) -> 
	io:fwrite ("Wrong input, please try to input a number between 1 to 10"),
	error.
	
%% A method to check if the data contains any string or only integer.
checkValidate({error,not_a_list}) ->
	exit;
checkValidate({Value,[]}) ->
	Value;
checkValidate(_) ->
		{error,no_integer}.

%% A method to compare the entered value to random nummber and print
%% proper message relevant to the value and secret number.
compareValue(exit,_) ->
	exit;
compareValue({error,no_integer},_) -> 
	io:format ("plase enter a correct number between 1 to 100!! ~n",[]),
	false;
compareValue(Value,Value)-> 
	io:format("The entered quess is the secret number!! ~n",[]),
	true;
compareValue(Value,RandomNumber) when Value < RandomNumber -> 
	io:format ("The entered value is smaller than secret Number!! ~n",[]),
	false;
compareValue(Value,RandomNumber) when Value > RandomNumber -> 
	io:format ("The entered value is greater than secret Number!! ~n",[]),
	false;
compareValue(_,_) -> 
	io:format ("some unknown thing is wrong!! ~n",[]),
	false.

%% A method to make a random number.
%% MaxValue Integer number to make a random number between 1 to Maxvalue.	
makeRandom(MaxValue) ->
	random:uniform(MaxValue).
