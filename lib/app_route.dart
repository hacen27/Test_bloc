import 'package:bloc_test/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_test/constant/strings.dart';
import 'package:bloc_test/data/repository/characters_repository.dart';
import 'package:bloc_test/data/web_services/characters_web_services.dart';
import 'package:bloc_test/presentation/screen/characters_screen.dart';
import 'package:bloc_test/presentation/screen/charcters_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/model/characters.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: CharactersScreen(),
                ));

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(
            character: character,
          ),
        );
    }
  }
}
