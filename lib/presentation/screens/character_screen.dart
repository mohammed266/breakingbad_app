import 'package:breakingbad_app/business_logic/character_cubit.dart';
import 'package:breakingbad_app/constants/my_colors.dart';
import 'package:breakingbad_app/data/model/characters.dart';
import 'package:breakingbad_app/presentation/widgets/characters_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  @override
  void initState() {
    super.initState();
     BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: allCharacters.length,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return  CharactersItem(character: allCharacters[index],);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: const Text(
          'characters',
          style: TextStyle(color: MyColors.myGray),
        ),
      ),
      body: buildBlocWidget(),
    );
  }
}
