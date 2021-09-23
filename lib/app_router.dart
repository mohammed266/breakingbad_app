import 'package:breakingbad_app/business_logic/character_cubit.dart';
import 'package:breakingbad_app/data/repository/characters_repository.dart';
import 'package:breakingbad_app/data/web_services/characters_web_services.dart';
import 'package:breakingbad_app/presentation/screens/character_screen.dart';
import 'package:breakingbad_app/presentation/screens/characters_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterCubit,
            child: const CharacterScreen(),
          ),
        );

      case charactersDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const CharacterDetailsScreen());
    }
  }
}
