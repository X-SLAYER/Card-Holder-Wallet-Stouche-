import 'package:flutter/material.dart';
import 'package:digital_wallet/creations/cheque.dart';
import 'package:digital_wallet/creations/creditCC.dart';
import 'package:digital_wallet/creations/debitCard.dart';
import 'package:digital_wallet/creations/giftCard.dart';
import 'package:digital_wallet/creations/other.dart';

class CardCreate extends StatefulWidget {
  final String type;

  CardCreate({@required this.type});

  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  Widget what = CreditCC();

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case "DC":
        what = DebitCard();
        break;
      case "CC":
        what = CreditCC();
        break;
      case "CH":
        what = Check();
        break;
      case "GC":
        what = GiftCard();
        break;
      case "OC":
        what = OtherCard();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.clear),
        ),
      ),
      body: SingleChildScrollView(
        child: what,
      ),
    );
  }
}
