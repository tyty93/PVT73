import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/ui/home/exit_confirmation.dart';
import 'package:intl/intl.dart';
import 'preview.dart';

class _CreateEventState extends State<CreateEvent> {
  int _activeCurrentStep = 0;

  String name = '';
  String description = '';
  String streetAddress = '';
  int zipCode = 0;

  DateTime? selectedDate = DateTime.now();

  int selectedRadio = 0;
  String hasLimitedSpots = 'false';
  String doCostMoney = 'false';
  bool _validateName = false;
  bool _validateDateTime = false;
  bool _validateSpots = false;
  bool _validateMoney = false;
  bool _validateStreetAddress = false;
  bool _validateZipCode = false;

  int _maxAttendees = 0;
  DateTime _selectedDate = DateTime.now();
  String formattedDate = '';
  int costMoney = 0;
  String paymentInfo = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController limitedSpotsController = TextEditingController();
  final TextEditingController costMoneyController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController paymentInfoController = TextEditingController();

  List<Step> stepList() => [
    Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Allmänt'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
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
                      name = value;
                    },
                  ),

                  DateTimeFormField(
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
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
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
                        _maxAttendees = 0;
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
                        _maxAttendees = int.parse(limitedSpotsController.text);
                      });
                    },
                  ),

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
                        costMoney = 0;
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
                        costMoney = int.parse(costMoneyController.text);
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
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(125, 30),
                      ),
                      child: Text("Nästa"),
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
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: streetController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text('Gatuadress:'),
                      errorText:
                          _validateStreetAddress ? 'Skriv en adress' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        streetAddress = value;
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
                        zipCode = int.parse(value);
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

                          if (!_validateStreetAddress && !_validateZipCode) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Preview(
                                      name: name,
                                      dateTime: _selectedDate,
                                      description: description,
                                      maxAttendees: _maxAttendees,
                                      cost: costMoney,
                                      paymentInfo: paymentInfo,
                                      location: streetAddress,
                                      zipCode: zipCode,
                                    ),
                              ),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(125, 30),
                      ),
                      child: Text("Nästa"),
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

      /* Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 25,
                decoration: const InputDecoration(
                  label: Text('Titel'),
                ),
              ), DateTimeFormField(
          decoration: const InputDecoration(
            labelText: 'Datum & tid:',
          ),
        firstDate: DateTime.now().add(const Duration(days: 0)),
        //lastDate: DateTime.now().add(const Duration(days: 40)),
        initialPickerDateTime: DateTime.now().add(const Duration(days: 0)),
        onChanged: (DateTime? value) {
            selectedDate = value;
        },

              ),
              TextFormField(
                maxLength: 200,
                decoration: const InputDecoration(
                  label: Text('Beskrivning'),
                ),
              ),
            ],
          )
      ), */
      //  bottomNavigationBar: BottomNavigationBar(items: bottomNavigationBarList),
    );
  }
}

/*
class _RadioListTileState extends State<RadioListTile>{
  @override
  void initState() {
    super.initState();
  }
}

 */

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  @override
  State<CreateEvent> createState() => _CreateEventState();

  /*
  @override
  State<_RadioListTileState1> createState() => _RadioListTileState1();

  @override
  void initState() {
    super.initState();
  }

   */
}
