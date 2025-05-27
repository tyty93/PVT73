import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/event.dart';
import '../event/event_card.dart';
import 'edit_event.dart';
import 'event_info_viewmodel.dart';
import '../../data/repositories/event_info_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Todo: fix colors (either apply theme colors manually or change from basic Container/Column stuff to more material-like widgets with automaticaally applied pr
class EventInfoPage extends StatefulWidget {
  final Event event;

  const EventInfoPage({super.key, required this.event});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  late Event eventCopy;

  @override
  void initState() {
    super.initState();
    eventCopy = widget.event;

    final viewModel = Provider.of<EventInfoViewModel>(context, listen: false);
    viewModel.loadFriendsAttending(widget.event.eventId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EventInfoViewModel>(context, listen: true);
    final friends = viewModel.friendsAttending;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Event ${widget.event.eventId}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Arrangör: ${widget.event.ownerName}'),
                  ],
                ),
              ),
            ),
            if (widget.event.ownerId == FirebaseAuth.instance.currentUser?.uid)
              ElevatedButton.icon(
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text('Redigera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEvent(event: eventCopy),
                    ),
                  );
                  // Navigate to the edit screen
                },
              ),

            if (widget.event.ownerId == FirebaseAuth.instance.currentUser?.uid)
              ElevatedButton.icon(
                icon: Icon(Icons.delete, color: Colors.white),
                label: Text('Ta bort'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text(
                            'Vill ta bort eventet?\nÅtgärden går inte att ångra.',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text('Nej'),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: const Text('Ja'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );
                },
              ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Info om event:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.event.description + '\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Plats:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: widget.event.location + '\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Tid:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              '${DateFormat('yyyy-MM-dd - kk:mm:ss').format(eventCopy.dateTime)}\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Kontakta arrangör på:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '${eventCopy.ownerEmail}\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Max antal anmälda:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              widget.event.maxAttendees > 0
                                  ? '${widget.event.maxAttendees}\n'
                                  : 'Inget maxantal.\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Pris:\n',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              widget.event.cost != 0
                                  ? '${widget.event.cost}\n'
                                  : 'Gratis\n',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),

                  if (eventCopy.cost > 0) ...[
                    RichText(
                      text: TextSpan(
                        text: 'Betalningsinfo:\n',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text:
                                widget.event.paymentInfo.isEmpty
                                    ? 'Saknas info, kontakta arrangör för frågor.\n'
                                    : '${widget.event.paymentInfo}\n',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            /*
            ElevatedButton(
              onPressed: () {
                // registerParticipation(currentUserId, widget.eventId);
              },
              child: const Text('Anmäl dig till eventet'),
            ),
*/
            if (friends.isNotEmpty) ...[
              const SizedBox(height: 16),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vänner som ska dit:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          friends.map((friend) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                friend,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 50),
          ],
        ),
      ),

      floatingActionButton: Align(
  alignment: Alignment.bottomCenter * 0.95,
  child: Consumer<EventInfoViewModel>(
    builder: (context, viewModel, _) {
      final registered = viewModel.isRegistered;
      return Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            if (registered) {
              viewModel.unregisterFromEvent(widget.event.eventId);
            } else {
              viewModel.registerToEvent(widget.event.eventId);
            }
          },
          child: Text(
            registered ? 'Avanmäl dig' : 'Anmäl dig till eventet',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      );
    },
  ),
),
    );
  }
}
