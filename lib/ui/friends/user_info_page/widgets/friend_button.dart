import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendButton extends StatefulWidget{
  final bool isFriend;
  final bool outgoingRequest;
  final bool incomingRequest;
  final String userId;
  final FriendsPageViewmodel viewmodel;

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
  late FriendsPageViewmodel viewModel;

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
      return BasicButton(
        buttonColor: Color(0xFFDD3437),
        borderColor: Color(0xFF151515),
        onPressed: (){
          widget.viewmodel.removeFriend(widget.userId);
          setState((){isFriend = false; outgoingRequest = false; incomingRequest = false;});
        },
        child: Text(
          "Ta bort vän",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 28,
          )
        )
      );
    }

    else if(outgoingRequest){
      return BasicButton(
        buttonColor: Color(0xFF34DD53),
        borderColor: Color(0xFF151515),
        onPressed: (){},
        child: Text(
          "Skickad",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 28,
          )
        )
      );
    }

    else if(incomingRequest){
      return Row(
        children: [
          SizedBox(width:2),
          BasicButton(
            height:44,
            width: 130,
            buttonColor: Color(0xFF34DD53),
            borderColor: Color(0xFF151515),
            onPressed: (){
              widget.viewmodel.acceptRequest(widget.userId);
              setState((){isFriend = true; outgoingRequest = false; incomingRequest = false;});
            },
            child: Icon(
              Icons.check_rounded,
              color: Color(0xFF000000),
              size:39
            ),
          ),
          SizedBox(width:2),
          BasicButton(
            height: 44,
            width: 80,
            buttonColor: Color(0xFFDD3437),
            borderColor: Color(0xFF371515),
            onPressed: (){
              context.read<FriendRepository>().rejectRequest(widget.userId);
              setState((){isFriend=false; outgoingRequest = false; incomingRequest =false;});
            },
            child: Icon(
              Icons.clear_rounded,
              color: Color(0xFF000000),
              size:30
            )
          )
        ],
      );
    }

    else {
      return BasicButton(
        buttonColor: Color(0xFFFBDCDC),
        borderColor: Color(0xFF151515),
        onPressed: (){
          widget.viewmodel.addFriend(widget.userId);
          setState((){isFriend = false; outgoingRequest = true; incomingRequest = false;});
        },
        child: Text(
          "Lägg till vän",
          style: GoogleFonts.itim(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 28,
          )
        )
      );
    }
  }
}

class BasicButton extends StatelessWidget{
  final double width;
  final double height;
  final Color buttonColor;
  final Color borderColor;
  final Widget child;
  final void Function() onPressed;

  const BasicButton({
    super.key,
    this.width = 230,
    this.height = 44,
    required this.buttonColor,
    required this.borderColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
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
        onPressed: onPressed,
        child: Center(
          child: child,
        )
      )
    );
  }
}