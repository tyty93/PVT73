import 'package:flutter/material.dart';

class _SavedEventChangesConfirmationState
    extends State<SavedEventChangesConfirmation> {
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
                text:
                    'Ditt event har sparats och ändringarna är synliga för andra \n',
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // registerParticipation(currentUserId, widget.eventId);
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: Text("Okej"),
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

class SavedEventChangesConfirmation extends StatefulWidget {
  const SavedEventChangesConfirmation({super.key});

  @override
  State<SavedEventChangesConfirmation> createState() =>
      _SavedEventChangesConfirmationState();
}
