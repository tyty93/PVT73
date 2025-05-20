import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/Friend%20Model/User.dart';
import 'package:go_router/go_router.dart';

import 'dart:developer' as developer;

import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatefulWidget{
  final User user;
  final void Function()? removeFriendFunction;
  final void Function()? addFriendFunction;
  final void Function()? toggleFavoriteFunction;

  const UserCard({
    super.key, 
    required this.user, 
    this.removeFriendFunction, 
    this.addFriendFunction, 
    this.toggleFavoriteFunction
  });
  
  @override
  State<StatefulWidget> createState() => UserPageCardState();
}

class UserPageCardState extends State<UserCard> {
  late bool isFavourite;
  late bool isIncomingRequest;
  late bool isOutgoingReuest;
  late bool isFriend;

  @override
  void initState() {
    isFavourite = widget.user.favourite;
    isIncomingRequest = widget.user.incomingRequest;
    isOutgoingReuest = widget.user.outgoingRequest;
    isFriend = widget.user.isFriend;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
      child: GestureDetector(
        onTap: () {
          final userId=widget.user.userId;
          context.push('/friends/user/$userId', extra: widget.user).then((value) => {
              setState(() {
                isFavourite = widget.user.favourite;
              }),
          });
        },
        child: SizedBox(
          height: 90,
          width: MediaQuery.sizeOf(context).width - 16,
          child: Card.filled(
            margin: EdgeInsets.all(0),
            color: const Color.fromRGBO(217, 217, 217, 1),
            child: Row(
              children: [
                SizedBox(width: 5),

                //Profile picture widget
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Card.filled(
                    margin: EdgeInsets.all(0),
                    color: const Color.fromRGBO(100,100,100,1),
                  ),
                ),

                SizedBox(width: 9),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:6),

                    //Name and favourite star
                    Container(
                      width:230,
                      alignment: Alignment.bottomLeft,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child:Row(
                          children: [
                            //Name text
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child:Text(
                                widget.user.name,
                                style: GoogleFonts.itim(
                                  fontSize: 28,
                                ),
                              ),
                            ),

                            //Favourite star
                            Icon(
                              Icons.star,
                              color: (isFavourite)? Color(0xFFD26666) : Colors.transparent,
                              size: 32,
                            )
                          ],
                        ),
                      )
                    ),
                    
                    // Email text
                    Container(
                      width:220,
                      alignment: Alignment.bottomLeft ,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.user.email,
                          style: GoogleFonts.itim(
                            fontSize: 24,
                            color: const Color.fromARGB(255, 139, 139, 139)
                          )
                        )
                      ),
                    )
                  ],
                ),
              
                //Context menu
                Builder(
                  builder: (context){
                    if(widget.user.isFriend){
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
                    else if(widget.user.outgoingRequest){
                      return Text('');
                    }
                    else{
                      return Text('');
                    }
                  },
                )
              ],  
            )
          )
        ),
      )
    );
  }

  void handleOptions(String value){
    switch(value){
      case 'Favourite':
        if(widget.toggleFavoriteFunction != null) {
          widget.toggleFavoriteFunction!();
          setState(() {isFavourite = !isFavourite;});
        } else{ developer.log('Hello 2'); }
      break;
      case 'Remove friend':
        if(widget.removeFriendFunction != null) {
          widget.removeFriendFunction!();
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