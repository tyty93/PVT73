import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_page.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_viewmodel.dart';

import 'dart:developer' as developer;

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsPageCard extends StatelessWidget{
  final String username;
  final String userEmail;
  final bool favourite;
  final bool isFriend;
  final bool isPending;
  final int id;
  final void Function()? removeFriendFunction;
  final void Function()? addFriendFunction;
  final void Function()? toggleFavoriteFunction;

  const FriendsPageCard({
    super.key,
    required this.id,
    this.username="Name",
    this.userEmail="Email",
    this.favourite=false,
    required this.isFriend,
    required this.isPending,
    this.removeFriendFunction,
    this.addFriendFunction,
    this.toggleFavoriteFunction,
  });

  @override
  Widget build(context){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  Provider<FriendRepository>(
                    create: (context) => FriendRepositoryImpl()
                  ),
                  ChangeNotifierProvider(
                    create: (context) => UserInfoViewmodel(friendRepository: context.read<FriendRepository>(), userId: id),
                  ),
                ],
                child: UserInfoPage(id: id),
              ),
            ),
          );
        },
        child: SizedBox(
          height: 88,
          width: 396,
          child: Card.filled(
            margin: EdgeInsets.all(0),
            color: const Color.fromRGBO(217, 217, 217, 1),
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                  height:88,
                  width:330,
                  child: Row(
                    children: [
                      //Profile picture widget
                      SizedBox(
                        height: 77,
                        width: 77,
                        child: Card.filled(
                          margin: EdgeInsets.all(0),
                          color: const Color.fromRGBO(100,100,100,1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(9,7,0,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 0,
                          children: [
                            Row(
                              children: [
                                Text(
                                  username,
                                  style: GoogleFonts.itim(
                                    fontSize: 28,
                                  ),
                                ),
                                Builder(
                                  builder: (context){
                                    if(favourite){
                                      return Icon(
                                        Icons.star,
                                        color: Color(0xFFD26666),
                                        size: 32,
                                      );
                                    }
                                    else{
                                      return SizedBox(width: 36);
                                    }
                                  }
                                )
                              ],
                            ),
                            Text(
                              userEmail,
                              style: GoogleFonts.itim(
                                fontSize: 24,
                                color: const Color.fromARGB(255, 139, 139, 139)
                              )
                            )
                          ],
                        ),
                      ),
                    ],)
                  ),
                  Builder(
                    builder: (context){
                      if(isFriend){
                        return Align(
                          alignment: Alignment.center,
                          child: PopupMenuButton(
                            position: PopupMenuPosition.over,
                            color: Color.fromRGBO(217, 217, 217, 1),
                            elevation: 2,
                            icon: buildOptionsButton(context),
                            onSelected: handleOptions,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Colors.black,
                              )
                            ),
                            itemBuilder:  (BuildContext context) {
                              return {'Favourite','Remove friend'}.map((String choice){
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice), 
                                );
                              }).toList();
                            }
                          )
                        );
                      }
                      else if(isPending){
                        return Text('');
                      }
                      else{
                        return Text('');
                      }
                    },
                  )
                  
                ]
              )
            )
          )
        ),
      )
    );
  }

  void handleOptions(String value){
    switch(value){
      case 'Favourite':
        if(toggleFavoriteFunction != null) {
          toggleFavoriteFunction!();
        } else{ developer.log('Hello 2'); }
      break;
      case 'Remove friend':
        if(removeFriendFunction != null) {
          removeFriendFunction!();
        } else{ developer.log('Hello'); } {}
      break;
    }
  }

  Widget buildOptionsButton(context) => Column( 
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon( 
        Icons.circle,
        size: 6,
      ),
      SizedBox(height:2),
      Icon( 
        Icons.circle,
        size: 6,
      ),
      SizedBox(height:2),
      Icon( 
        Icons.circle,
        size: 6,
      ),
    ]
  );
}
