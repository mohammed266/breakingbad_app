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
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGray,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'find a character...',
        hintStyle: TextStyle(
          fontSize: 15,
          color: MyColors.myGray,
        ),
      ),
      style: const TextStyle(
        fontSize: 15,
        color: MyColors.myGray,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }
  List<Widget> buildAppBarActions(){
    if(_isSearching){
      return[
        IconButton(
          onPressed: (){
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear,color: MyColors.myGray,),
        ),
      ];
    }else{
      return[
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search,color: MyColors.myGray,),
        ),
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch(){
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }

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
        itemCount: _searchTextController.text.isEmpty ? allCharacters.length : searchedForCharacters.length,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return CharactersItem(
            character: _searchTextController.text.isEmpty ? allCharacters[index] : searchedForCharacters[index],
          );
        });
  }

  Widget _buildAppBarTitle(){
    return const Text(
      'characters',
      style: TextStyle(color: MyColors.myGray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching ? const BackButton(color: MyColors.myGray,): Container(),
        title: _isSearching ? buildSearchField() : _buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
