import 'package:flutter/material.dart';

import 'create_event.dart';

class _ExitConfirmationState extends State<ExitConfirmation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Är du säker på att du vill avbryta? \nInga ändringar sparas. \n',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[],
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('/home'),
                            );
                          },
                          child: Text("Ja, avbryt"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateEvent(),
                              ),
                            );
                          },
                          child: Text("Nej, fortsätt skapa"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /*Container(
        child: Column(
          children: <Widget>[
            const Text(
              'Är du säker på att du vill avbryta?\n Inga ändringar sparas.',
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: Text("Ja, avbryt"),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateEvent(),
                        ),
                      );
                    },
                    child: Text("Nej, fortsätt skapa"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      */
    );
  }
}

class ExitConfirmation extends StatefulWidget {
  const ExitConfirmation({super.key});

  @override
  State<ExitConfirmation> createState() => _ExitConfirmationState();
}
