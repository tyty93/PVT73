import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/Friend%20Model/User.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/widgets/favourite_button.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/widgets/friend_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class UserInfoPage extends StatefulWidget{
  final int id;
  const UserInfoPage({super.key, required this.id});

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
      body:Consumer<UserInfoViewmodel>(
        builder:(context, viewModel, _){
          if(viewModel.user == null){
            return const Center(child: CircularProgressIndicator());
          }
          User user = viewModel.user!;
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
                      user.name,
                      style: GoogleFonts.itim(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 40,
                      )
                    ),
                    Text(
                      user.email,
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
                            isFriend: user.isFriend,
                            favourite: user.favourite,
                            onTap: () {
                            viewModel.favourite(user.userId);
                            },
                          ),
                          FriendButton(
                            
                            isFriend: user.isFriend,
                            outgoingRequest: user.outgoingRequest,
                            incomingRequest: user.incomingRequest,
                            userId: user.userId,
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