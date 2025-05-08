import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/search_repository.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_card.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:provider/provider.dart';

class FriendPageScreen extends StatefulWidget {
  const FriendPageScreen({super.key});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FriendPageScreen>{
  @override
  Widget build(BuildContext context){
    log(context.toString());
    return Scaffold(
        appBar: AppBar( 
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(210, 102, 102, 1),
          foregroundColor: Colors.black,
          toolbarHeight: 115,
          title: Text(
            "Vänner",
            textAlign: TextAlign.center,
            style: GoogleFonts.itim(
              textStyle: TextStyle(color: Colors.white, letterSpacing: 2),
              fontSize: 70,
            ),
          ),
        ),
        body: Consumer<FriendsPageViewmodel>(
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
                      userEmail: users[index].email,
                      favourite: users[index].favourite,
                    ),
                );
              } 
            );
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFFBDCDC),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Color(0xFF371515), strokeAlign: 1),
            borderRadius: BorderRadius.circular(90),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MultiProvider(
                providers: [
                  Provider<SearchRepository>(
                  create: (context) => SearchRepositoryImpl()
                  ),
                  ChangeNotifierProvider(
                  create: (context) => FriendsSearchPageViewmodel(searchRepository: context.read<SearchRepository>()),
                  )
                ],
                child: FriendsSearchPage(),
              )
            ));
          },
          label: Text(
            "     Lägg till ny vän    ",
            style: GoogleFonts.itim(
              textStyle: TextStyle(color: Colors.black),
              fontSize: 32,
            ),
          ),
        ),
        
        backgroundColor: Color.fromRGBO(153, 88, 88, 1)

    );
  }
}