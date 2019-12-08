import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/ui/publicCards.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SearchScreen extends StatefulWidget {
  

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();
  List<Cards> lookCards = [];

  _searchForCards(String keyword) {
    if (keyword.isEmpty) return;
    for (var pCard in CategoryItems.publicCardsList) {
      if (pCard.type.toString().toLowerCase().contains(keyword.toLowerCase())) {
        setState(() {
          lookCards.add(pCard);
        });
      }
    }
  }

   _showOriginal(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: _b64Toimage(lookCards[index].imgBase64),
          ),
        );
      },
    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Container(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              border: InputBorder.none,
              hintText: "Search For Card ..",
              hintStyle: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 16.0),
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    searchController.clear();
                    lookCards.clear();
                  });
                },
                icon: Icon(
                  Icons.clear,
                ),
              ),
            ),
            onSubmitted: (input) => _searchForCards(input),
          ),
        ),
      ),
      body: lookCards.length != 0
          ? searchList()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 33.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      "assets/images/search.png",
                    ),
                    width: 145,
                    height: 155,
                  ),
                  Text(
                    "Enter a few words to search for on stouche.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Theme.of(context).accentColor,
                      fontFamily: "Google",
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget searchList() {
    return ListView.builder(
      itemCount: lookCards.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            lookCards[index].imgBase64 != null
                ? _showOriginal(index)
                : showToast();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Cards(
              userName: lookCards[index].userName,
              height: MediaQuery.of(context).size.height * 0.35,
              name: lookCards[index].name,
              prenom: lookCards[index].prenom,
              nationality: CategoryItems.publicCardsList[index].nationality,
              type: lookCards[index].type,
              birthDate: lookCards[index].birthDate,
            ),
          ),
        );
      },
    );
  }
}
