import 'package:flutter/material.dart';
import 'package:digital_wallet/addCard.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:digital_wallet/homepage.dart';
import 'package:digital_wallet/screens/cardManage.dart' as cc;

class CardViewer extends StatefulWidget {
  @override
  _CardViewerState createState() => _CardViewerState();
}

class _CardViewerState extends State<CardViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Cards (${CategoryItems.cardsList.length})",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1.5,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            );
          },
          icon: Icon(
            Icons.clear,
            size: 25.0,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddCards(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: (CategoryItems.cardsList == null ||
              CategoryItems.cardsList.length == 0)
          ? noCards()
          : Column(
              children: <Widget>[
                SizedBox(
                  height: _screenSize.height * 0.8,
                  child: ListView.builder(
                    itemCount: CategoryItems.cardsList.length == 0
                        ? 0
                        : CategoryItems.cardsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  cc.CardManagment(
                                indice: index,
                                card: CategoryItems.cardsList[index],
                              ),
                            ),
                          );
                        },
                        child: CreditCardWidget(
                          height: _screenSize.height * 0.35,
                          cardHolderName:
                              CategoryItems.cardsList[index].cardHolderName,
                          cardNumber: CategoryItems.cardsList[index].cardNumber,
                          cvvCode: CategoryItems.cardsList[index].cvvCode,
                          expiryDate: CategoryItems.cardsList[index].expiryDate,
                          showBackView: false,
                          cardbgColor: CategoryItems.colorsList[
                              CategoryItems.cardsList[index].colorIndex],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget noCards() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/ccsad.png"),
            width: 165.0,
            height: 155.0,
          ),
          SizedBox(
            height: 9.0,
          ),
          Text(
            "You have no cards to display",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
                color: Theme.of(context).accentColor),
          )
        ],
      ),
    );
  }
}
