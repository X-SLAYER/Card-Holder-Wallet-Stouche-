import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/cardViewer.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/helper/formatters.dart';
import 'package:digital_wallet/models/creditcard_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' as cr;

import '../homepage.dart';

class CreditCC extends StatefulWidget {
  static String name = "Credit Card";
  @override
  _CreditCCState createState() => _CreditCCState();
}

class _CreditCCState extends State<CreditCC> {
  FocusNode ccvFocused = new FocusNode();
  bool ccv = false;
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController _ccv = TextEditingController();
  TextEditingController expiredate = TextEditingController();

  String name, number, expir, cc;

  @override
  void initState() {
    super.initState();

    ccvFocused.addListener(() {
      setState(() {
        ccv = ccvFocused.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    cardHolderName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          cardModel(),
          SizedBox(
            height: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskedTextInputFormatter(
                    mask: 'xxxx xxxx xxxx xxxx',
                    separator: ' ',
                  ),
                ],
                controller: cardNumber,
                onChanged: (nb) {
                  setState(() {
                    number = nb;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  labelText: "Card Number",
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                ),
              ),
            ),
          ),
          //---------------------------------------
          Row(
            children: <Widget>[
              Container(
                width: 200.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        MaskedTextInputFormatter(
                          mask: 'xx/xxxx',
                          separator: '/',
                        ),
                      ],
                      controller: expiredate,
                      onChanged: (input) {
                        setState(
                          () {
                            expir = input;
                          },
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        labelText: "Expiration date",
                        hintStyle:
                            TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        inputFormatters: [
                          MaskedTextInputFormatter(
                            mask: 'xxx',
                            separator: '',
                          ),
                        ],
                        keyboardType: TextInputType.number,
                        focusNode: ccvFocused,
                        controller: _ccv,
                        onChanged: (ccv) {
                          setState(() {
                            cc = ccv;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          labelText: "CCV",
                          hintStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: cardHolderName,
                onChanged: (input) {
                  setState(
                    () {
                      name = input;
                    },
                  );
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  labelText: "Card Holder Name",
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                ),
              ),
            ),
          ),
          //---------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: MaterialButton(
              onPressed: () {
                CreditCard cCard = CreditCard(HomePage.user.usrename,
                    cardHolderName: cardHolderName.text,
                    cardNumber: cardNumber.text,
                    cvvCode: _ccv.text,
                    expiryDate: expiredate.text,
                    colorIndex: 0);
                DBHlper().insertCC(cCard);
                DBHlper().insertSTAT(
                  new Stats(
                      HomePage.user.usrename,
                      "New Credit Card has been added",
                      CategoryItems.returnDate(),
                      1),
                );
                setState(() {
                  CategoryItems.cardsList.add(cCard);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CardViewer(),
                  ),
                );
              },
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Add Card",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardModel() {
    return Container(
      child: cr.CreditCardWidget(
        cardbgColor: CategoryItems.colorsList[0],
        height: 200.0,
        cardHolderName: name == null ? "John Doe" : name,
        cardNumber:
            cardNumber == null ? "1111 1111 1111 1111" : cardNumber.text,
        cvvCode: _ccv == null ? "111" : _ccv.text,
        expiryDate: expiredate == null ? "11/1999" : expiredate.text,
        showBackView: ccvFocused.hasFocus,
      ),
    );
  }
}
