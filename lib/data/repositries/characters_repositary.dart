import 'package:breakingbad/data/api/characters_api.dart';

import '../models/char_quote.dart';
import '../models/characters.dart';

class CharactersRepositary{
  final CharactersApi charactersApi;
  CharactersRepositary(this.charactersApi);
  Future <List<Character>> getAllCharacters()async{
    final characters=await charactersApi.getAllCharacters();
    return characters.map((characters) => Character.fromJson(characters)).toList();
  }
  Future <List<CharQuote>> getCharacterQuotes(String charName)async{
    final quotes=await charactersApi.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => CharQuote.fromJson(charQuotes)).toList();
  }
}