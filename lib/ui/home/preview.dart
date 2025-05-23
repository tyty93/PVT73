import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/published_confirmation.dart';
import 'package:intl/intl.dart';

import 'exit_confirmation.dart';
import 'create_event.dart';

class Preview extends StatelessWidget{

  final String _name;
  final String _description;
  final int _maxAttendees;
  final int _cost;
  final String _paymentInfo;
  final DateTime _dateTime;

  String get name => _name;
  String get description => _description;
  int get maxAttendees => _maxAttendees;
  int get cost => _cost;
  String get paymentInfo => _paymentInfo;
  DateTime get dateTime => _dateTime;

  const Preview({super.key, required name, required dateTime,
    required description, required maxAttendees, required cost, required paymentInfo})
      :
        _name = name,
        _description = description,
        _maxAttendees = maxAttendees,
        _cost = cost,
        _paymentInfo = paymentInfo,
        _dateTime = dateTime;
  
  String textFormatMaxAttendees(int maxAttendees){
    if(maxAttendees == 0){
      return 'Obegränsat antal platser \n';
    }
    return maxAttendees.toString() + ' personer \n';
  }
  
  String textFormatCost(int cost){
    if(cost == 0) {
      return 'Gratis \n';
  }
    return cost.toString() + ' kr \n';
}

  String textFormatPaymentInfo(int cost){
    if(cost == 0) {
      return '';
    }
    return 'Betalningsinfo \n';
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text('Skapa event'), leading: IconButton(
    icon: Icon(Icons.close),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ExitConfirmation()));
    },
    ),
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
                        name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('Arrangör: testmail@gmail.com'),
                    ],
                  ),
                ),
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

                    RichText(text: TextSpan(
                        text: 'Info om event \n',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                            text:  description + '\n',
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ]
                    )
                    ),

                    RichText(text: TextSpan(
                          text: 'Plats/Karta: \n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Grodgatan 2 \n',
                              style: TextStyle(fontSize: 16, color: Colors.black45),
                            )
                          ]
                      )
                      ),


                      RichText(text: TextSpan(
                          text: 'Tid: \n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          children: <InlineSpan>[
                            TextSpan(
                              text: DateFormat('yyyy-MM-dd - kk:mm:ss').format(dateTime) + '\n',
                              style: TextStyle(fontSize: 16, color: Colors.black45),
                            )
                          ]
                      )
                      ),

                    RichText(text: TextSpan(
                        text: 'Kontakta arrangör på: \n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'testmail@gmail.com \n',
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ]
                    )
                    ),

                    RichText(text: TextSpan(
                        text: 'Max antal anmälda: \n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                            text: textFormatMaxAttendees(maxAttendees),
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ]
                    )
                    ),

                    RichText(text: TextSpan(
                        text: 'Kostnad: \n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                            text: textFormatCost(cost),
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ]
                    )
                    ),

                    RichText(text: TextSpan(
                        text: textFormatPaymentInfo(cost),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                            text: paymentInfo + '\n',
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ]
                    )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(alignment: Alignment.bottomCenter,
                      child: ElevatedButton(onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => const CreateEvent()));
                      }, style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 30)
                      ),
                          child: Text("Backa")),
                    ),
                    Align(alignment: Alignment.bottomCenter,
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PublishedConfirmation()));
                      }, style: ElevatedButton.styleFrom(
                          fixedSize: const Size(125, 30)
                      ),
                          child: Text("Publicera")),
                    ),
                  ]

              ),
            ],
          ),
        ),


          );

  }

}

