import 'dart:ui' as theme;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/user.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_card.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class FriendPageScreen extends StatefulWidget {
  const FriendPageScreen({super.key});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FriendPageScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      context.read<FriendsPageViewmodel>().refresh();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        builder: (context, viewModel, _) {
          if (viewModel.users == null) {
            viewModel.refresh();
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.users!.isEmpty && viewModel.pendingRequests.isEmpty) {
            return Center(child: Text('No friends'));
          }
          final pendingRequests = viewModel.pendingRequests;
          List<User> users = viewModel.users!;
          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(milliseconds: 500), () {
                viewModel.refresh();
                setState(() {});
              });
            },
            child: ListView.builder(
              itemCount:
                  (pendingRequests.isNotEmpty)
                      ? users.length + pendingRequests.length + 2
                      : users.length + 1,
              itemBuilder: (context, index) {
                if (pendingRequests.isNotEmpty &&
                    index < pendingRequests.length + 1) {
                  if (index == 0) {
                    return Text(
                      " Vänförfrågningar",
                      style: GoogleFonts.itim(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        fontSize: 25,
                      ),
                    );
                  }
                  index -= 1;
                  return Center(child: UserCard(user: pendingRequests[index]));
                }
                int value =
                    (pendingRequests.isNotEmpty)
                        ? pendingRequests.length + 1
                        : 0;
                index -= value;
                if (index == 0) {
                  return Text(
                    " Mina vänner",
                    style: GoogleFonts.itim(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                      fontSize: 25,
                    ),
                  );
                }
                index -= 1;
                return Center(
                  child: UserCard(
                    user: users[index],
                    toggleFavoriteFunction: () {
                      viewModel.favourite(users[index].id);
                    },
                    removeFriendFunction: () {
                      viewModel.removeFriend(users[index].id);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFFBDCDC),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFF371515), strokeAlign: 1),
          borderRadius: BorderRadius.circular(90),
        ),
        onPressed: () {
          context.push('/friends/search-users');
        },
        label: Text(
          "     Lägg till ny vän    ",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 32,
          ),
        ),
      ),

      backgroundColor: theme.Color(0xfffff8f7),
      //Color.fromRGBO(153, 88, 88, 1),
    );
  }
}
