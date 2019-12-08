import 'dart:async';

import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/cardViewer.dart';
import 'package:digital_wallet/models/creditcard_model.dart';
import 'package:snappable/snappable.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' as credit;
import 'package:toast/toast.dart';

import '../cardViewer.dart';
import '../homepage.dart';

class CardManagment extends StatefulWidget {
  final CreditCard card;
  final int indice;
  CardManagment({@required this.indice, this.card});

  @override
  _CardManagmentState createState() => _CardManagmentState();
}

class _CardManagmentState extends State<CardManagment> {
  final key = GlobalKey<SnappableState>();
  bool isLoading = false;

  _snap() async {
    setState(() {
      isLoading = true;
    });
    await key.currentState.snap();
    Timer(Duration(milliseconds: 1000), () {
      DBHlper().deleteCC(CategoryItems.cardsList[widget.indice]);
      DBHlper().insertSTAT(
        new Stats(HomePage.user.usrename, "Card has been deleted",
            CategoryItems.returnDate(), 2),
      );
      setState(
        () {
          isLoading = false;
          CategoryItems.cardsList.removeAt(widget.indice);
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CardViewer(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              isLoading
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue[200],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    )
                  : SizedBox.shrink(),
              Snappable(
                duration: Duration(milliseconds: 1000),
                key: key,
                child: Container(
                  height: MediaQuery.of(context).size.height * .36,
                  child: credit.CreditCardWidget(
                    height: MediaQuery.of(context).size.height * .36,
                    cardHolderName: widget.card.cardHolderName,
                    cardNumber: widget.card.cardNumber,
                    cvvCode: widget.card.cvvCode,
                    expiryDate: widget.card.expiryDate,
                    showBackView: false,
                    cardbgColor:
                        CategoryItems.colorsList[widget.card.colorIndex],
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MaterialButton(
                  onPressed: () {
                    Toast.show(
                        "This feature is only for premium Member", context,
                        duration: 3, gravity: Toast.BOTTOM);
                  },
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Text(
                      "Set Reminder",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: "Google",
                          fontSize: 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MaterialButton(
                  onPressed: () {},
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Text(
                      "Edit Card",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: "Google",
                          fontSize: 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Are You Sure"),
                          content: new Text("Complete Deleting ?"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                _snap();
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Text(
                      "Delete Card",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: "Google",
                          fontSize: 15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
