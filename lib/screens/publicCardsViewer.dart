import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/homepage.dart';
import 'package:digital_wallet/ui/publicCards.dart';
import 'package:digital_wallet/ui/createcard.dart';
import '../addPublicCard.dart';
import 'package:toast/toast.dart';

class MyCardsViewer extends StatefulWidget {
  final TYPE type;
  MyCardsViewer({@required this.type});
  @override
  _MyCardsViewerState createState() => _MyCardsViewerState();
}

class _MyCardsViewerState extends State<MyCardsViewer> {
  List<Cards> mylist = [];

  _getCards() {
    try {
      if (CategoryItems.publicCardsList == null ||
          CategoryItems.publicCardsList.length == 0) return;
      mylist.clear();
      if (widget.type == TYPE.other) {
        for (Cards carta in CategoryItems.publicCardsList) {
          if (carta.type == CardType.gym || carta.type == CardType.health) {
            setState(() {
              mylist.add(carta);
            });
          }
        }
      } else if (widget.type == TYPE.identifiactions) {
        for (Cards carta in CategoryItems.publicCardsList) {
          if (carta.type == CardType.id ||
              carta.type == CardType.passport ||
              carta.type == CardType.driver) {
            setState(() {
              mylist.add(carta);
            });
          }
        }
      } else {
        for (Cards carta in CategoryItems.publicCardsList) {
          if (carta.type == whatsFilter()) {
            setState(() {
              mylist.add(carta);
            });
          }
        }
      }
    } catch (ex) {}
  }

  _showOriginal(int index) {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: _b64Toimage(mylist[index].imgBase64),
            ),
          );
        },
      );
    } catch (ee) {}
  }

  _b64Toimage(String base) {
    Uint8List bytes = base64.decode(base);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }

  showToast() {
    return Toast.show("You Have No Original Copy To Display", context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void initState() {
    super.initState();
    _getCards();
  }

  CardType whatsFilter() {
    switch (widget.type) {
      case TYPE.identifiactions:
        return CardType.id;
        break;
      case TYPE.shopping:
        return CardType.loyality;
        break;
      case TYPE.students:
        return CardType.student;
        break;
      case TYPE.transport:
        return CardType.transport;
        break;
      case TYPE.other:
        return CardType.gym;
        break;
      default:
        return null;
    }
  }

  Widget wichPath() {
    switch (widget.type) {
      case TYPE.identifiactions:
        return AddPublicCard(
          children: <Widget>[
            addButton(context, 1, "Identification Card",
                Theme.of(context).accentColor, Theme.of(context).cardColor),
            SizedBox(height: 10.0),
            addButton(context, 2, "Driving Licence",
                Theme.of(context).accentColor, Theme.of(context).cardColor),
            SizedBox(height: 10.0),
            addButton(context, 3, "Passport", Theme.of(context).accentColor,
                Theme.of(context).cardColor),
            SizedBox(height: 10.0),
          ],
        );
        break;
      case TYPE.shopping:
        return Createcard(type: CardType.loyality, secondeType: TYPE.shopping);
        break;
      case TYPE.students:
        return Createcard(type: CardType.student, secondeType: TYPE.students);
        break;
      case TYPE.transport:
        return Createcard(
            type: CardType.transport, secondeType: TYPE.transport);
        break;
      case TYPE.other:
        return AddPublicCard(
          children: <Widget>[
            addButton(context, 1, "Health Card", Theme.of(context).accentColor,
                Theme.of(context).cardColor),
            SizedBox(height: 10.0),
            addButton(context, 2, "GYM Card", Theme.of(context).accentColor,
                Theme.of(context).cardColor),
            SizedBox(height: 10.0),
            addButton(context, 3, "Other Documents",
                Theme.of(context).accentColor, Theme.of(context).cardColor),
            SizedBox(height: 10.0),
          ],
        );
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Cards (${mylist.length})",
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
              _navigate();
            },
            icon: Icon(
              Icons.add,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: (mylist == null || mylist.length == 0)
          ? noCards()
          : Column(
              children: <Widget>[
                SizedBox(
                  height: _screenSize.height * 0.8,
                  child: ListView.builder(
                    itemCount: (mylist == null || mylist.length == 0)
                        ? 0
                        : mylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          (mylist[index].imgBase64 == null ||
                                  mylist[index].imgBase64.length == 0)
                              ? showToast()
                              : _showOriginal(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Stack(
                            children: <Widget>[
                              Cards(
                                userName: HomePage.user.usrename,
                                height: _screenSize.height * 0.35,
                                name: mylist[index].name,
                                prenom: mylist[index].prenom,
                                nationality: CategoryItems
                                    .publicCardsList[index].nationality,
                                type: mylist[index].type,
                                birthDate: mylist[index].birthDate,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        if (mylist.length == 1) {
                                          DBHlper().deletePC(mylist[0]);
                                          CategoryItems.publicCardsList
                                              .removeAt(index);
                                          setState(() {
                                            mylist = [];
                                          });
                                        } else {
                                          DBHlper().deletePC(mylist[index]);
                                          setState(() {
                                            CategoryItems.publicCardsList
                                                .removeAt(index);
                                            _getCards();
                                          });
                                        }
                                        DBHlper().insertSTAT(
                                          new Stats(
                                              HomePage.user.usrename,
                                              "${this.widget.type.toString().split('.')[1]} card has been deleted",
                                              CategoryItems.returnDate(),
                                              2),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 27,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print("Edit Here");
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 27,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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

  MaterialButton addButton(BuildContext context, int indice, String text,
      Color txtColor, Color buttonColor) {
    return MaterialButton(
      onPressed: () {
        if (widget.type == TYPE.identifiactions) {
          switch (indice) {
            case 1:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Createcard(
                          type: CardType.id,
                          secondeType: TYPE.identifiactions)),
                );
                break;
              }
            case 2:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Createcard(
                          type: CardType.driver,
                          secondeType: TYPE.identifiactions)),
                );

                break;
              }
            case 3:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Createcard(
                          type: CardType.passport,
                          secondeType: TYPE.identifiactions)),
                );
                break;
              }

            default:
              {}
          }
        } else {
          switch (indice) {
            case 1:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Createcard(
                        type: CardType.health, secondeType: TYPE.other),
                  ),
                );

                break;
              }
            case 2:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Createcard(type: CardType.gym, secondeType: TYPE.other),
                  ),
                );

                break;
              }
            case 3:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Createcard(
                          type: CardType.gym, secondeType: TYPE.other)),
                );
                break;
              }

            default:
              {}
          }
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

  void _navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => wichPath()),
    );
  }
}

enum TYPE {
  identifiactions,
  shopping,
  students,
  transport,
  other,
}
