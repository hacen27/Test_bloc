import 'package:bloc_test/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_test/constant/mycolors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/characters.dart';
import '../wedget/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchFonCharacters;
  bool _isSearching = false;
  final _searchTextCotrollor = TextEditingController();

  Widget _buildSearchfild() {
    return TextField(
      controller: _searchTextCotrollor,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'find  a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchCharacter) {
        addSearChedForitemsToserchedList(searchCharacter);
      },
    );
  }

  void addSearChedForitemsToserchedList(String searchCharacter) {
    searchFonCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppbarAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _starSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _starSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
  }

  void _clearSearch() {
    setState(() {
      _searchTextCotrollor.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadinIndicator();
        }
      },
    );
  }

  Widget showLoadinIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextCotrollor.text.isEmpty
            ? allCharacters.length
            : searchFonCharacters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
            character: _searchTextCotrollor.text.isEmpty
                ? allCharacters[index]
                : searchFonCharacters[index],
          );
        });
  }

  Widget _builappbarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading:
            _isSearching ? BackButton(color: MyColors.myGrey) : Container(),
        title: _isSearching ? _buildSearchfild() : _builappbarTitle(),
        actions: _buildAppbarAction(),
      ),
      body: buildBlocWidget(),
    );
  }

  //SilverGridDelegatedwithFixedCrossAxisCount() {}
}
