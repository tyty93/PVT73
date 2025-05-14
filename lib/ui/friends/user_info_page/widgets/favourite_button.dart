import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget{
  final bool isFriend;
  final bool favourite;
  final void Function() onTap;
  const FavouriteButton({super.key, required this.isFriend, required this.favourite, required this.onTap});

  @override
  State<StatefulWidget> createState() => FavouriteButtonState();
}

class FavouriteButtonState extends State<FavouriteButton>{
  late bool isFriend;
  late bool favourite;

  @override
  void initState(){
    super.initState();
    isFriend = widget.isFriend;
    favourite = widget.favourite;
  }

  @override
  Widget build(BuildContext context) {
    if(!isFriend){
      return buildButtonIcon(BorderStyle.none, Color(0xFFD4D4D4), Color(0xFFB1B1B1));
    } 
    return GestureDetector(
      onTap: (){
        widget.onTap();
        setState((){favourite=!favourite;});
      },
      child: buildButtonIcon(
        BorderStyle.solid,
        Color(0xFFFBDCDC), 
        (favourite)?Color(0xFFD26666):Color(0xFFB1B1B1),
      )
    );
  }

  Widget buildButtonIcon(BorderStyle borderStyle, Color iconColor, Color starColor){
    return SizedBox(
      height: 51,
      width: 51,
      child: Card.filled(
        color: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
          side: BorderSide(
            width: 2,
            style: borderStyle,
            color: Color(0xFF371515)
          )
        ),
        child: Icon(
          Icons.star,
          size: 35,
          color: starColor,
        ),
      )
    );
  }
}