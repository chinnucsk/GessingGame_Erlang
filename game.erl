%% Author: Amir Almasi
%% A module to implement the guessing game and let the user play the game.
%% Created on July 12, 2011

-module(game).
-export([start/0]).

%% The main method to be called from out of the module to start playing the game.
start() ->
	play(makeRandom (5),1).
	
%% A method to start the game.
play(RandomNumber,PlayCounter) when PlayCounter > 5 ->
	case string:to_lower(hd(element(2,io:fread("You were not able to guess the secret number by 15 time guess, would you like to play the game again(YES/No)? " ,"~s")))) of
		"yes" -> play(makeRandom (5),1);
		"no" -> "have a good time!!";
		_ -> play(RandomNumber,PlayCounter)
	end;
play(RandomNumber,PlayCounter) ->
	io:format("The random number is: ~b ~n" , [RandomNumber]),
	case compareValue(checkInput(getInput()),integer_to_list(RandomNumber)) of
		false -> play(RandomNumber,PlayCounter+1);
		exit -> PlayCounter;%%"Hope you have anjoyed playing this game. Hope to see you again";
		_ -> string:concat(string:concat("The entered guess is the secret number!! congradulations you have guested the secret number by ", integer_to_list(PlayCounter))," times quessing!!")
	end.
	
%% A method to read an integer number entered by user and return it.
getInput() ->
	io:fread("Please enter a integer input: ", "~s").

%% A method to check if the entered value is a valid integer number or not.
checkInput({ok,["exit"]}) -> 
	io:fwrite("You have chosen to exit the the software ~n"),
	exit;
checkInput({ok,[H|_]}) -> 
	H;
checkInput({_,_}) -> 
	io:fwrite ("Wrong input, please try to input a number between 1 to 10").

%% A method to compare the entered value to random nummber
compareValue(exit,_) ->
	exit;
compareValue(Value,Value)-> 
	io:format("The entered quess is the secret number!! ~n",[]),
	true;
compareValue(Value,RandomNumber) when Value < RandomNumber -> 
	io:format ("The entered value is smaller than secret Number!! ~n",[]),
	false;
compareValue(Value,RandomNumber) when Value > RandomNumber -> 
	io:format ("The entered value is greater than secret Number!! ~n",[]),
	false.

	
%% A method to make a random number.
%% MaxValue Integer number to make a random number between 1 to Maxvalue.	
makeRandom(MaxValue) ->
	random:uniform(MaxValue).
