import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/data/api/characters_api.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/repositries/characters_repositary.dart';
import 'package:breakingbad/presentation/screens/charact_details_screen.dart';
import 'package:breakingbad/presentation/screens/charcters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/string.dart';

class AppRouter {
  late CharactersRepositary charactersRepositary;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepositary = CharactersRepositary(
      CharactersApi(),
    );
    charactersCubit = CharactersCubit(charactersRepositary);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepositary),
            child: CharacterDetailsScreen(
              character: selectedCharacter,
            ),
          ),
        );
    }
  }
}
