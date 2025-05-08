
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/ui/friends/Widgets/users_search_bar.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_card.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class FriendsSearchPage extends StatelessWidget{
  FriendsSearchPage({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFEF),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text(
          "Sök användare",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 45,
          )
        )
      ),
      body: Column(
        children: [
          UsersSearchBar(
            controller: myController,
            onFinishedTyping: (p0) => {
              log(myController.text)
            },
          ),
          SizedBox(height:40),
          Consumer<FriendsSearchPageViewmodel>(
            builder: (context, viewModel, _){
              if(viewModel.users == null){
                return const Center(child: CircularProgressIndicator());
              }
              if(viewModel.users!.isEmpty){
                return Center(child: Text('No friends'));
              }
              final users = viewModel.users!;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: FriendsPageCard(
                        username: users[index].name,
                        userEmail: "",
                        favourite: false,
                      ),
                  );
                } 
              );
            }
          ),
        ],
    ),
    );
  }

}