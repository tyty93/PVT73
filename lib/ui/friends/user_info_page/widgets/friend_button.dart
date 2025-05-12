import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendButton extends StatefulWidget{
  final bool isFriend;
  final bool outgoingRequest;
  final bool incomingRequest;
  final int userId;
  final UserInfoViewmodel viewmodel;

  const FriendButton({
    super.key, 
    required this.isFriend, 
    required this.outgoingRequest, 
    required this.incomingRequest,
    required this.viewmodel,
    required this.userId,
  });
  
  @override
  State<StatefulWidget> createState() => FriendButtonState();
}

class FriendButtonState extends State<FriendButton>{
  late bool isFriend;
  late bool outgoingRequest;
  late bool incomingRequest;
  late UserInfoViewmodel viewModel;

  final Color borderColor = Color(0xFF151515);
  final Color removeFriendButtonColor = Color(0xFFDD3437);
  final Color outgoingRequestButtonColor = Color(0xFF34DD53);
  final Color addFriendButtonColor = Color(0xFFFBDCDC);

  @override
  void initState(){
    super.initState();
    isFriend = widget.isFriend;
    outgoingRequest = widget.outgoingRequest;
    incomingRequest = widget.incomingRequest;
    viewModel = widget.viewmodel;
  }

  @override
  Widget build(BuildContext context) {
    if(isFriend){
      return buildButton("Ta bort vän" ,  borderColor, removeFriendButtonColor, 
        (){
          widget.viewmodel.removeFriend(widget.userId);
          setState((){isFriend = false; outgoingRequest = false; incomingRequest = false;});
        }
      );
    }
    else if(outgoingRequest){
      return buildButton("Skickad", borderColor, outgoingRequestButtonColor,(){});
    }
    else if(incomingRequest){

    }
    else {
      return buildButton("Lägg till vän", borderColor, addFriendButtonColor,
        (){
          widget.viewmodel.addFriend(widget.userId);
          setState((){isFriend = false; outgoingRequest = true; incomingRequest = false;});
        }
      );
    }
    return Text("Hello");
  }

  Widget buildButton(String text, Color borderColor, Color buttonColor, void Function() onTap){
    return SizedBox(
      height:43,
      width:230,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(buttonColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
              side: BorderSide(
              width: 2,
              color: borderColor,
              strokeAlign: -1
              )
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 28,
          ),
        )
      )
    );
  }
}

/*
ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Color(0xFFDD3437),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
            side: const BorderSide(
              width: 2,
              color: Color(0xFF371515),
              strokeAlign: -1,
            )
          )
          )*/