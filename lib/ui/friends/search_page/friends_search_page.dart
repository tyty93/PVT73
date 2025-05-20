import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/friends/Widgets/search_list_view.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsSearchPage extends StatelessWidget{
  FriendsSearchPage({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFEFEF),
      extendBodyBehindAppBar: false,

      appBar: AppBar(    
        toolbarHeight: 100,
        backgroundColor: Color(0xFFFFEFEF),
        scrolledUnderElevation: 0,
        centerTitle: true, 

        title: Text(
          "Sök användare",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 45,
          )
        ),
        
      ),

      body: SizedBox(
        height: MediaQuery.sizeOf(context).height - 100 -58,
        child: SearchListView()
      ),

    );
  }

}