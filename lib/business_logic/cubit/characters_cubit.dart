import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/models/char_quote.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/repositries/characters_repositary.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepositary charactersRepositary;
  List<Character> characters=[];
  CharactersCubit(this.charactersRepositary) : super(CharactersInitial());
  List<Character>getAllCharacters(){
    charactersRepositary.getAllCharacters().then((character) {
      emit(CharactersLoaded(character));
      this.characters=character;
    });
    return characters;
  }
  void getQuotes(String charName){
    charactersRepositary.getCharacterQuotes(charName).then((quote) {
      emit(CharQuotLoaded(quote));

    });
  }
}
