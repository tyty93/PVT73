import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersSearchBar extends StatelessWidget{
  final double height;
  final double width;
  final Color backgroundColor;
  final TextStyle hintStyle;
  final String hintText;
  final TextEditingController controller;
  final void Function(BuildContext) onFinishedTyping;

  
  const UsersSearchBar({super.key, 
  this.height = 44,
  this.width = 380,
  this.backgroundColor = const Color(0xFFD9D9D9),
  this.hintStyle = const TextStyle(),
  this.hintText = "Sök",
  required this.controller,
  required this.onFinishedTyping});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width:width,
            height:height,
            child: TextField(
              controller: controller,
              autofocus: true,
              showCursor: false,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(200))
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(55, 21, 21, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(90))
                ),
                filled: true,
                fillColor: backgroundColor,
                hintStyle: hintStyle,
                hintText:  hintText,
              ),
              style: GoogleFonts.itim(
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                fontSize:  30,
              ),
              onTapOutside: (event) => {
                FocusScope.of(context).unfocus()
              },
              onEditingComplete: ()=> onFinishedTyping(context),
            )
          );
  }
}