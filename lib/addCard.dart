import 'package:flutter/material.dart';
import 'package:digital_wallet/ui/card_create.dart';

class AddCards extends StatelessWidget {
  const AddCards({Key key}) : super(key: key);

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
              children: <Widget>[
                addButton(
                    context, 1, "Credit Card", Colors.white70, Colors.blue),
                SizedBox(
                  height: 20.0,
                ),
                addButton(
                    context, 2, "Debit Card", Colors.black54, Colors.white),
                SizedBox(
                  height: 20.0,
                ),
                addButton(context, 3, "Check", Colors.black54, Colors.white),
                SizedBox(
                  height: 20.0,
                ),
                addButton(
                    context, 4, "Gift Card", Colors.black54, Colors.white),
                SizedBox(height: 28.0),
                addButton(
                    context, 5, "Other Card", Colors.black54, Colors.white),
                SizedBox(height: 28.0),
                Text(
                  "You Can now add credit cards with specific balance into wallet." +
                      " when the cards hits \$0.00 it will auomatically disappear.want to know if your gift card will link ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Google",
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton addButton(BuildContext context, int indice, String text,
      Color txtColor, Color buttonColor) {
    return MaterialButton(
      onPressed: () {
        switch (indice) {
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CardCreate(type: "CC"),
                ),
              );
              break;
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CardCreate(type: "DC"),
                ),
              );
              break;
            }
          case 3:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CardCreate(type: "CH"),
                ),
              );
              break;
            }
          case 4:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CardCreate(type: "GC"),
                ),
              );
              break;
            }
          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CardCreate(type: "OC"),
                ),
              );
              break;
            }
          default:
            {}
        }
      },
      color: buttonColor,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ),
      ),
    );
  }
}
