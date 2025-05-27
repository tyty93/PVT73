import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/repositories/event_repository.dart';
import 'package:flutter_application_1/ui/event_info/saved_event_changes_confirmation.dart';
import 'package:flutter_application_1/ui/home/exit_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models/event.dart';

class _EditEventState extends State<EditEvent> {
  late final Event eventCopy;

  int _activeCurrentStep = 0;

  late String name;
  late String description;
  late String location;
  late String streetAddress;
  late int zipCode;
  late int maxAttendees;
  late DateTime selectedDate;
  late DateTime _selectedDate;
  late String formattedDate;
  late int cost;
  late String paymentInfo;

  int selectedRadio = 0;
  late String hasLimitedSpots;
  late String doCostMoney;
  bool _validateName = false;
  bool _validateDateTime = false;
  bool _validateSpots = false;
  bool _validateMoney = false;
  bool _validateStreetAddress = false;
  bool _validateZipCode = false;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController limitedSpotsController;
  late final TextEditingController costMoneyController;
  late final TextEditingController streetController;
  late final TextEditingController zipCodeController;
  late final TextEditingController paymentInfoController;

  List<Step> stepList() => [
    Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Allmänt'),
      content: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    maxLength: 25,
                    decoration: InputDecoration(
                      label: Text('Titel'),
                      errorText:
                          _validateName
                              ? 'Skriv ett namn på evenemanget'
                              : null,
                    ),
                    onChanged: (value) {
                      name = nameController.text;
                    },
                  ),

                  DateTimeFormField(
                    initialValue: eventCopy.dateTime,
                    decoration: InputDecoration(
                      labelText: 'Datum & tid:',
                      errorText:
                          _validateDateTime ? 'Välj datum och tid' : null,
                    ),
                    firstDate: DateTime.now().add(const Duration(days: 0)),
                    initialPickerDateTime: DateTime.now().add(
                      const Duration(days: 0),
                    ),
                    onChanged: (selectedDate) {
                      _selectedDate = selectedDate!;
                      formattedDate = DateFormat(
                        'yyyy-MM-dd - kk:mm:ss',
                      ).format(_selectedDate);
                    },
                  ),

                  TextFormField(
                    controller: descriptionController,
                    maxLength: 200,
                    decoration: const InputDecoration(
                      label: Text('Beskrivning'),
                    ),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      nameController.text.isEmpty
                          ? _validateName = true
                          : _validateName = false;
                      formattedDate.isEmpty
                          ? _validateDateTime = true
                          : _validateDateTime = false;

                      if (!_validateName && !_validateDateTime) {
                        _activeCurrentStep = 1;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(125, 30),
                  ),
                  child: const Text('Nästa'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Step(
      state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 1,
      title: const Text('Antal & pris'),
      content: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text('Begränsade platser?'),
                  RadioListTile(
                    value: 'true',
                    groupValue: hasLimitedSpots,
                    onChanged: (value) {
                      setState(() {
                        hasLimitedSpots = 'true';
                      });
                    },
                    toggleable: true,
                    title: Text('Ja'),
                  ),
                  RadioListTile(
                    value: 'false',
                    groupValue: hasLimitedSpots,
                    onChanged: (value) {
                      setState(() {
                        hasLimitedSpots = 'false';
                        maxAttendees = 0;
                      });
                    },
                    toggleable: true,
                    title: Text('Nej'),
                  ),

                  TextFormField(
                    controller: limitedSpotsController,
                    enabled: hasLimitedSpots.contains('true'),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      label: Text('Antal platser:'),
                      errorText: _validateSpots ? 'Skriv ett antal' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        maxAttendees = int.parse(limitedSpotsController.text);
                      });
                    },
                  ),

                  Text(hasLimitedSpots),

                  Text('Pris?'),
                  RadioListTile(
                    value: 'true',
                    groupValue: doCostMoney,
                    onChanged: (value) {
                      setState(() {
                        doCostMoney = 'true';
                      });
                    },
                    toggleable: true,
                    title: Text('Ja'),
                  ),

                  RadioListTile(
                    value: 'false',
                    groupValue: doCostMoney,
                    onChanged: (value) {
                      setState(() {
                        doCostMoney = 'false';
                        cost = 0;
                        paymentInfo = '';
                      });
                    },
                    toggleable: true,
                    title: Text('Nej'),
                  ),

                  TextFormField(
                    controller: costMoneyController,
                    enabled: doCostMoney.contains('true'),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      label: Text('SEK:'),
                      errorText: _validateMoney ? 'Skriv ett pris' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        cost = int.parse(costMoneyController.text);
                      });
                    },
                  ),

                  TextFormField(
                    controller: paymentInfoController,
                    enabled: doCostMoney.contains('true'),
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Betalningslänk/-info:'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        paymentInfo = paymentInfoController.text;
                      });
                    },
                  ),
                ],
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _activeCurrentStep = 0;
                        });
                      },
                      child: Text("Föregående"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (hasLimitedSpots == 'true') {
                            limitedSpotsController.text.isEmpty
                                ? _validateSpots = true
                                : _validateSpots = false;
                          }
                          if (doCostMoney == 'true') {
                            costMoneyController.text.isEmpty
                                ? _validateMoney = true
                                : _validateMoney = false;
                          }

                          if (hasLimitedSpots == 'false') {
                            _validateSpots = false;
                          }

                          if (doCostMoney == 'false') {
                            _validateMoney = false;
                          }

                          if (!_validateSpots && !_validateMoney) {
                            _activeCurrentStep = 2;
                          }
                        });
                      },
                      child: Text("Nästa"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(125, 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),

    Step(
      state: _activeCurrentStep <= 2 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 2,
      title: const Text('Plats'),
      content: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: streetController,
                    maxLength: 50,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      label: Text('Gatuadress:'),
                      errorText:
                          _validateStreetAddress ? 'Skriv en adress' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        streetAddress = streetController.text;
                      });
                    },
                  ),

                  TextFormField(
                    controller: zipCodeController,
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      label: Text('Postnummer:'),
                      errorText:
                          _validateZipCode ? 'Skriv ett postnummer' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        zipCode = int.parse(zipCodeController.text);
                      });
                    },
                  ),
                ],
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _activeCurrentStep = 1;
                        });
                      },
                      child: Text("Föregående"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          streetAddress.isEmpty
                              ? _validateStreetAddress = true
                              : _validateStreetAddress = false;

                          zipCode.toString().length < 5
                              ? _validateZipCode = true
                              : _validateZipCode = false;

                          if (!_validateZipCode && !_validateStreetAddress) {
                            eventCopy.name = name;
                            eventCopy.description = description;
                            eventCopy.dateTime = _selectedDate;
                            eventCopy.maxAttendees = maxAttendees;
                            eventCopy.cost = cost;
                            eventCopy.paymentInfo = paymentInfo;
                            eventCopy.location =
                                streetAddress + ', ' + zipCode.toString();

                            context.read<EventRepository>().editEvent(eventCopy);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => SavedEventChangesConfirmation(
                                      event: eventCopy,
                                    ),
                              ),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(125, 30),
                      ),
                      child: Text("Spara"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    eventCopy = widget.event;
    hasLimitedSpots = eventCopy.maxAttendees > 0 ? 'true' : 'false';
    doCostMoney = eventCopy.cost > 0 ? 'true' : 'false';

    name = eventCopy.name;
    description = eventCopy.description;
    location = eventCopy.location;
    streetAddress = location.substring(0, location.length - 7);
    zipCode = int.parse(
      location.substring(location.length - 6, location.length),
    );
    maxAttendees = eventCopy.maxAttendees;
    _selectedDate = eventCopy.dateTime;
    selectedDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd - kk:mm:ss').format(_selectedDate);
    ;
    cost = eventCopy.cost;
    paymentInfo = eventCopy.paymentInfo;

    nameController = TextEditingController(text: eventCopy.name);
    descriptionController = TextEditingController(text: eventCopy.description);
    costMoneyController = TextEditingController(
      text: doCostMoney.contains('true') ? eventCopy.cost.toString() : null,
    );
    streetController = TextEditingController(text: streetAddress);
    zipCodeController = TextEditingController(text: zipCode.toString());
    paymentInfoController = TextEditingController(
      text: doCostMoney.contains('true') ? eventCopy.paymentInfo : null,
    );
    limitedSpotsController = TextEditingController(
      text:
          hasLimitedSpots.contains('true')
              ? eventCopy.maxAttendees.toString()
              : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skapa event'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExitConfirmation()),
            );
          },
        ),
      ),

      body: Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Row(children: <Widget>[Container()]);
        },

        type: StepperType.horizontal,
        currentStep: _activeCurrentStep,
        steps: stepList(),
        onStepContinue: () {},
      ),
    );
  }
}

class EditEvent extends StatefulWidget {
  final Event _event;

  Event get event => _event;

  const EditEvent({super.key, required event}) : _event = event;

  @override
  State<EditEvent> createState() => _EditEventState();
}
