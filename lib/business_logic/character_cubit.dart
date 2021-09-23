import 'package:bloc/bloc.dart';
import 'package:breakingbad_app/data/model/characters.dart';
import 'package:breakingbad_app/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  List<Character> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharacterLoaded(characters!));
      this.characters = characters;
    });
    return characters;
  }
}
