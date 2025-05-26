import 'package:flutter/material.dart';

import 'create_event.dart';
import 'home_page.dart';

class _PublishedConfirmationState extends State<PublishedConfirmation> {
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Ditt event har publicerats och är synligt för andra \n',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <InlineSpan>[],
              ),
            ),

            Column(
              children: <Widget>[
                /*Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // registerParticipation(currentUserId, widget.eventId);
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: Text("Se skapat event"),
                  ),
                ),
                */
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // registerParticipation(currentUserId, widget.eventId);
                      Navigator.popUntil(context, ModalRoute.withName('/home'));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateEvent(),
                        ),
                      );
                    },
                    child: Text("Skapa ett till event"),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // registerParticipation(currentUserId, widget.eventId);
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: Text("Hem"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PublishedConfirmation extends StatefulWidget {
  const PublishedConfirmation({super.key});

  @override
  State<PublishedConfirmation> createState() => _PublishedConfirmationState();
}
