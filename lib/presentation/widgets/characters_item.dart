import 'package:breakingbad_app/constants/my_colors.dart';
import 'package:breakingbad_app/data/model/characters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharactersItem extends StatelessWidget {
  final Character character;
  const CharactersItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(8),
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        child: Container(
          color: MyColors.myGray,
          child: character.image.isNotEmpty
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: 'assets/images/loading.gif',
                  image: character.image,
                )
              : Image.asset('assets/images/placeholder.png'),
        ),
        footer: Container(
          width: double.infinity,
          color: Colors.black45,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            character.name,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              height: 1,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
