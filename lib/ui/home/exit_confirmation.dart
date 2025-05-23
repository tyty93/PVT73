import 'package:flutter/material.dart';

import 'create_event.dart';
import 'home_page.dart';

class _ExitConfirmationState extends State<ExitConfirmation>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Container(
        child: Column(
            children: <Widget> [
            const Text('Är du säker på att du vill avbryta?\n Inga ändringar sparas.'),

              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                        Align(alignment: Alignment.bottomCenter,
                          child: TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                          },
                          child: Text("Ja, avbryt")),
                        ),

                    Align(alignment: Alignment.bottomCenter,
                      child: TextButton(onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => const CreateEvent()));
                      },
                          child: Text("Nej, fortsätt skapa")),
                    ),
                  ]

              ),
          ]
      )
      )
    );
  }


}





class ExitConfirmation extends StatefulWidget {
  const ExitConfirmation({super.key});

  @override
  State<ExitConfirmation> createState() => _ExitConfirmationState();
}