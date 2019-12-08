import 'package:flutter/material.dart';
import 'package:digital_wallet/helper/category_items.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          itemCount: CategoryItems.cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CategoryItems.cards[index]['screen']),
                );
              },
              child: buildCard(index),
            );
          },
        ),
      ),
    );
  }

  Column buildCard(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 15.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    3.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                )
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text(
                    CategoryItems.cards[index]['name'],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Google",
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 175.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        CategoryItems.cards[index]['img'],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
