import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/event.dart';

class _SavedEventChangesConfirmationState
    extends State<SavedEventChangesConfirmation> {
  late final Event eventCopy;

  @override
  void initState() {
    super.initState();

    eventCopy = widget._event;
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
                      Navigator.popUntil(context, ModalRoute.withName('/home'));

                      final eventId = eventCopy.eventId;
                      context.push('/home/event/$eventId', extra: eventCopy);
                    },
                    child: Text("Visa eventet"),
                  ),
                ),
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
  final Event _event;

  const SavedEventChangesConfirmation({super.key, required Event event})
    : _event = event;

  @override
  State<SavedEventChangesConfirmation> createState() =>
      _SavedEventChangesConfirmationState();
}
