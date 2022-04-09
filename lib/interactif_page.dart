import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InteractifPage extends StatefulWidget {

  @override
 InteractifPageState createState() => InteractifPageState();
}

class InteractifPageState extends State<InteractifPage> {

  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  backgroundColor,
      appBar: AppBar(title: Text("Interactifs"),),
      body: Center(child: Text("Interactif learn"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            backgroundColor = (backgroundColor == Colors.white) ? Colors.black : Colors.white;
            textColor = (textColor == Colors.black)? Colors.white: Colors.black;
          });
        },
        child: Icon(Icons.build),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  updateColors() {}
}