import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/Friend%20Model/User.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
//import 'package:flutter_application_1/ui/friends/user_info_page/user_info_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/widgets/favourite_button.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/widgets/friend_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class UserInfoPage extends StatefulWidget{
  final User user;
  const UserInfoPage({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage>{
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFEF),
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: Color(0xFFFFEFEF),
        scrolledUnderElevation: 0,
        centerTitle: true, 

        title: Text(
          "Information",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 45,
          )
        ),
      ),
      body:Consumer<FriendsPageViewmodel>(
        builder:(context, viewModel, _){
          return Column(
            children: [
              Center(
                child: ProfilePictureBanner(),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 0,
                  children: [
                    Text(
                      widget.user.name,
                      style: GoogleFonts.itim(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 40,
                      )
                    ),
                    Text(
                      widget.user.email,
                      style: GoogleFonts.itim(
                        textStyle: TextStyle(color: Color(0xFF8B8B8B)),
                        fontSize: 24,
                      )
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FavouriteButton(
                            isFriend: widget.user.isFriend,
                            favourite: widget.user.favourite,
                            onTap: () {
                            viewModel.favourite(widget.user.userId);
                            },
                          ),
                          FriendButton(
                            isFriend: widget.user.isFriend,
                            outgoingRequest: widget.user.outgoingRequest,
                            incomingRequest: widget.user.incomingRequest,
                            userId: widget.user.userId,
                            viewmodel: viewModel,
                          )
                        ],
                      )
                    )
                  ],
                )
              )
            ]
          );
        },
      )
    );
  }
}

class ProfilePictureBanner extends StatelessWidget{
  const ProfilePictureBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:190,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 164,
            width: MediaQuery.sizeOf(context).width,
            child: ColoredBox(
              color: Color(0xFF000000),
            )
          ),
          Positioned(
            bottom: -15,
            child: SizedBox(
              height: 130,
              width: 130,
              child: Card.filled(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color(0xFFFFFFFF),
                    width:5
                  )
                ),
                color: Color(0xFF872934),
              )
            )
          )
        ]
      )
    );
  }
}