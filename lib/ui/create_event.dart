import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';

class _CreateEventState extends State<CreateEvent>{
  int _activeCurrentStep = 1;
  /*var bottomNavigationBarList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home),
    label: 'Nästa'
    )
  ];

     */
  DateTime? selectedDate = DateTime.now();
  int selectedRadio = 0;
  String limitedSpots = 'false';
  String costMoney = 'false';

  List<Step> stepList() => [
    Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Allmänt'),
      content: Container(
          child: Column(
            children: [
              TextFormField(
                maxLength: 25,
                decoration: const InputDecoration(
                  label: Text('Titel'),
                ),
              ),

              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Datum & tid:',
                ),
                firstDate: DateTime.now().add(const Duration(days: 0)),
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

              Align(alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(150),
                  width: double.infinity,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _activeCurrentStep = 1;
                    });
                  }, child: Text("Nästa")),
                ),

              ),


              /*
         Scaffold(
            bottomNavigationBar: BottomAppBar(
                child: TextButton(onPressed: (){
                  print('press');
                }, child: const Text('Nästa'
                ),
                )
            )
        )

         */

            ],
          )
      ),
      //  bottomNavigationBar: BottomNavigationBar(items: bottomNavigationBarList),



    ),
    Step(
        state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeCurrentStep >= 1,
        title: const Text('Antal & pris'),
        content: Container(
          child: Column(
              children: [
                Text('Begränsade platser?'),
                RadioListTile(
                  value: 'true', groupValue: limitedSpots,  onChanged: (value) {
                  setState(() {
                    limitedSpots = 'true';

                  });
                }
                    ,
                    toggleable: true,
                    title: Text('Ja'),
                ),
                RadioListTile(
                    value: 'false', groupValue: limitedSpots, onChanged: (value) {
                  setState(() {
                    limitedSpots = 'false';
                  });
                }, toggleable: true,
                    title: Text('Nej')
                ),

                TextFormField(
                 enabled: limitedSpots.contains('true'),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    label: Text('Antal platser:'),
                  ),
                ),

                Text('Pris?'),
                RadioListTile(
                  value: 'true', groupValue: costMoney,  onChanged: (value) {
                  setState(() {
                    costMoney = 'true';

                  });
                }
                  ,
                  toggleable: true,
                  title: Text('Ja'),
                ),
                RadioListTile(
                    value: 'false', groupValue: costMoney, onChanged: (value) {
                  setState(() {
                    costMoney = 'false';
                  });
                }, toggleable: true,
                    title: Text('Nej')
                ),

                TextFormField(
                  enabled: costMoney.contains('true'),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    label: Text('SEK:'),
                  ),
                ),

                TextFormField(
                  enabled: costMoney.contains('true'),
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Betalningslänk/-info:'),
                  ),
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: () {
                          setState(() {
                            _activeCurrentStep = 0;
                          });
                        }, child: Text("Föregående")),
                      ),
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: () {
                          setState(() {
                          _activeCurrentStep = 2;
                          });
                          }, child: Text("Nästa")),
                      ),
                    ]

                ),



              ]
          ),
        )


    ),

    Step(
        state: _activeCurrentStep <= 2 ? StepState.editing : StepState.complete,
        isActive: _activeCurrentStep >= 2,
        title: const Text('Plats'),
        content: Container(
          child: Column(
              children: [


                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: () {
                          setState(() {
                            _activeCurrentStep = 1;
                          });
                        }, child: Text("Föregående")),
                      ),
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: () {
                          setState(() {
                            _activeCurrentStep = 3;
                          });
                        }, child: Text("Nästa")),
                      ),
                    ]

                ),



              ]
          ),
        )


    ),

    Step(
        state: _activeCurrentStep <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeCurrentStep >= 3,
        title: const Text('Sammanfattning'),
        content: Container(
          child: Column(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft,
                    child: RichText(text:
                    TextSpan(
                        text: 'Preview \n',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, backgroundColor: Colors.amber),
                        children: <InlineSpan>[
                          TextSpan(
                          )
                        ]
                    )
                    )
                ),

                Align(alignment: Alignment.centerLeft,
                child: RichText(text:
                  TextSpan(
                      text: 'Översiktlig information om event \n',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, backgroundColor: Colors.amber),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'test \n',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, backgroundColor: Colors.amber),
                        )
                      ]
                  )
                )
                ),


                Align(alignment: Alignment.centerLeft,
                    child: RichText(text:
                    TextSpan(
                        text: 'Beskrivning av event \n',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, backgroundColor: Colors.amber),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'test',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, backgroundColor: Colors.amber),
                          )
                        ]
                    )
                    )
                ),



                //),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: () {
                          setState(() {
                            _activeCurrentStep = 2;
                          });
                        }, child: Text("Backa")),
                      ),
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(onPressed: null, child: Text("Publicera")),
                      ),
                    ]

                ),

              ]
          ),
        )


    ),

  ];

  @override
  void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Skapa event'), leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          null;
        },
      ),
      ),


      body: Stepper(
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              children: <Widget>[
                Container(),
              ],
            );
          },

          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),
          onStepContinue: () {

          }
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