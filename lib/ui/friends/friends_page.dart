import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/friends/friends_page_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatelessWidget{
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context){
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
            if(viewModel.friends == null){
              return const Center(child: CircularProgressIndicator());
            }
            if(viewModel.friends!.isEmpty){
              return Center(child: Text('No friends'));
            }
            final users = viewModel.friends!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  color: Colors.green,
                  child: Center(child: Text('Entry ${users[index]})'))
                );
              } 
            );
          }
        ),
        backgroundColor: Color.fromRGBO(153, 88, 88, 1)

    );
  }


}