import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home()
    );
  }
}

class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<String> countries = ["USA", "United Kingdom", "China", "Russia", "Brazil",
    "India", "Pakistan", "Nepal", "Bangladesh", "Sri Lanka",
    "Japan", "South Korea", "Mongolia"];

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Scroll Back to Top Button"),
            backgroundColor: Colors.redAccent
        ),

        body: SingleChildScrollView(
             //set controller
            child:Container(
                child:Column(
                  children: countries.map((country){
                    return Card(
                        child:ListTile(
                            title: Text(country)
                        )
                    );
                  }).toList(),
                )
            )
        )
    );
  }
}