part of 'characters_cubit.dart';


abstract class CharactersState  {}

class CharactersInitial extends CharactersState {}
class CharactersLoaded extends CharactersState{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}
class CharQuotLoaded extends CharactersState{
  final List<CharQuote> quote;

  CharQuotLoaded(this.quote);
}