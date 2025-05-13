import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'home_page_viewmodel.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  int _maxAttendees = 50; // Default value
  DateTime _selectedDate = DateTime.now(); // Default date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name TextField
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              const SizedBox(height: 8),
              // Description TextField
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              // Theme TextField
              TextField(
                controller: _themeController,
                decoration: const InputDecoration(labelText: 'Theme'),
              ),
              const SizedBox(height: 8),
              // Location TextField
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 16),
              // Slider for maxAttendees (1-200)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Max Attendees'),
                  Text('$_maxAttendees'),
                ],
              ),
              Slider(
                value: _maxAttendees.toDouble(),
                min: 1,
                max: 200,
                divisions: 199,
                label: '$_maxAttendees',
                onChanged: (value) {
                  setState(() {
                    _maxAttendees = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 16),
              // Date Picker (for dateTime)
              TextButton(
                onPressed: _selectDate,
                child: Text('Select Event Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // Show the confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Event Creation'),
                        content: const Text('Are you sure you want to create this event?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Close the dialog (do not create event)
                              context.pop(); // Close the dialog (since we're using GoRouter)
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Call the createEvent function from HomeViewModel
                              context.read<HomeViewmodel>().createEvent(
                                name: _nameController.text,
                                description: _descriptionController.text,
                                theme: _themeController.text,
                                location: _locationController.text,
                                maxAttendees: _maxAttendees,
                                dateTime: _selectedDate,
                              );

                              // Close the dialog and go back to the Home page (pop twice)
                              context.pop(); // Close the dialog
                              context.pop(); // Go back to the home page (pop the event creation page)
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // DatePicker for selecting event date
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}

