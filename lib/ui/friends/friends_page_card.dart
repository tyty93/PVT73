import 'package:flutter/material.dart';
import 'dart:math';

import 'dart:developer' as developer;

import 'package:google_fonts/google_fonts.dart';

class FriendsPageCard extends StatelessWidget{
  final String username;
  final String userEmail;
  final bool favourite;

  const FriendsPageCard({
    super.key,
    this.username="Name",
    this.userEmail="Email",
    this.favourite=false,
  });

  @override
  Widget build(BuildContext){
    return Padding(
      padding: EdgeInsets.only(top: 16),
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: buildOptionsButton(BuildContext)
                )
              ]
            )
          )
        )
      ),
    );
  }
  Widget buildOptionsButton(Context) => MaterialButton(
    minWidth: 2,
    onPressed: () {
      developer.log('Hello from $username');
    },
    child: Column( 
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
    )
  );
}
