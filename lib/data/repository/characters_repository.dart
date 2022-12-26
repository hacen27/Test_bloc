import 'package:bloc_test/data/web_services/characters_web_services.dart';

import '../model/characters.dart';

class CharactersRepository {
  // ignore: non_constant_identifier_names
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllcharaters() async {
    final characters = await charactersWebServices.getAllcharaters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
