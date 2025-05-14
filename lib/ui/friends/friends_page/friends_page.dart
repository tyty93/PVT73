import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';
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
            if(!viewModel.hasLoadedFriends){
              viewModel.refresh();
            }
            if(viewModel.users == null){
              return const Center(child: CircularProgressIndicator());
            }
            if(viewModel.users!.isEmpty && viewModel.pendingRequests.isEmpty){
              return Center(child: Text('No friends'));
            }
            final pendingRequests = viewModel.pendingRequests;
            final users = viewModel.users!;
            return RefreshIndicator(
              onRefresh: (){
                return Future.delayed(Duration(milliseconds: 500),(){
                  viewModel.refresh();
                  setState((){});
                });
              },
              child: ListView.builder(
                itemCount: (pendingRequests.isNotEmpty)? users.length + pendingRequests.length + 2: users.length + 1,
                itemBuilder: (context, index) {
                  if(pendingRequests.isNotEmpty && index < pendingRequests.length+1){
                    if(index == 0){
                      return Text(
                        " Vänförfrågningar",
                        style: GoogleFonts.itim(
                          textStyle: TextStyle(color: Colors.white, letterSpacing: 2),
                          fontSize: 25,
                        ),
                      );
                    }
                    index-=1;
                    return Center(
                      child: FriendsPageCard(
                        id: pendingRequests[index].userId,
                        username: pendingRequests[index].name,
                        userEmail: pendingRequests[index].email,
                        favourite: pendingRequests[index].favourite,
                        isFriend: pendingRequests[index].isFriend,
                        isPending: pendingRequests[index].incomingRequest,
                      ),
                    );
                    
                  }
                  int value = (pendingRequests.isNotEmpty)? pendingRequests.length+1 : 0;
                  index-= value;
                  if(index == 0){
                      return Text(
                        " Mina vänner",
                        style: GoogleFonts.itim(
                          textStyle: TextStyle(color: Colors.white, letterSpacing: 2),
                          fontSize: 25,
                        ),
                      );
                  }
                  index-=1;
                  return Center(
                    child: FriendsPageCard(
                      id:         users[index].userId,
                      username:   users[index].name,
                      userEmail:  users[index].email,
                      favourite:  users[index].favourite,
                      isFriend:   users[index].isFriend,
                      isPending:  users[index].incomingRequest,
                      toggleFavoriteFunction: (){
                        viewModel.favourite(users[index].userId);
                      },
                      removeFriendFunction: (){
                        viewModel.removeFriend(users[index].userId);
                      },
                    ),
                  );
                } 
              )
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
                  Provider<FriendRepository>(
                  create: (context) => FriendRepositoryImpl()
                  ),
                  ChangeNotifierProvider(
                  create: (context) => FriendsSearchPageViewmodel(userRepository: context.read<FriendRepository>()),
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