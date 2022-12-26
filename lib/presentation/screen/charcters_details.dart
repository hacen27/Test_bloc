import 'package:flutter/material.dart';

import '../../constant/mycolors.dart';
import '../../data/model/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 14,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ))
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Jobs :', character.jobs.join('/')),
                      buildDivider(315),
                      characterInfo('Appeared in :', character.catagory),
                      buildDivider(250),
                      
                      characterInfo(
                          'Seasons :', character.appearance.join('/')),
                      buildDivider(280),
                      characterInfo('Status :', character.statusIfDeadOrAlive),
                      character.betterCallSaulAppereance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Saul Seasons :',
                              character.betterCallSaulAppereance.join('/')),
                      character.betterCallSaulAppereance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo('Actor/Actresse :', character.actorName),
                      buildDivider(235),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


//  {cinData: 
//{"cin_id":"3366443589","nationality_code":"MRT","nationality":"MAURITANIE",
//"validity_date":"25.03.2023","birth_date":"10.12.1995","document_number":"O01803781",
//"sex":"Male","issuing_country":"MAURITANIE","issuing_country_code":"MRT",
//"first_name":"EL HACEN","last_name":"SOUEILEM"}, 
//
//cinFiles: 
//{"DocumentBackSideFile":"/data/user/0/com.example.flutter_screen/SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812684__DocumentBackSideFile.jpg",
//"DocumentFrontSideFile":"/data/user/0/com.example.flutter_screen/SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812629__DocumentFrontSideFile.jpg",
//"FaceFile":"/data/user/0/com.example.flutter_screen
///SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812663__FaceFile.jpg"}}

// {cinData: 
//{"cin_id":"3366443589","nationality_code":"MRT","nationality":"MAURITANIE",
//"validity_date":"25.03.2023","birth_date":"10.12.1995","document_number":"O01803781","sex":"Male","issuing_country":"MAURITANIE",
//"issuing_country_code":"MRT","first_name":"EL HACEN","last_name":"SOUEILEM"}, 
//
//cinFiles: {"DocumentBackSideFile":"/data/user/0/com.example.flutter_screen/SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812684__DocumentBackSideFile.jpg","DocumentFrontSideFile":"/data/user/0/com.example.flutter_screen/SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812629__DocumentFrontSideFile.jpg","FaceFile":"/data/user/0/com.example.flutter_screen/SkyID@InDataCore/tempFiles/166151051034659210731045508318__1661510812663__FaceFile.jpg"}}