import 'package:flutter/material.dart';

class AddPublicCard extends StatelessWidget {
  final List<Widget> children;
  AddPublicCard({@required this.children});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.clear,
              color: Theme.of(context).accentColor, size: 18.0),
        ),
        title: Text(
          "Select Type",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: Container(
        color: Colors.white30,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
          child: Container(
            child: Column(
              children: this.children
            ),
          ),
        ),
      ),
    );
  }
}
