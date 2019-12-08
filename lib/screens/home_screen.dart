import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/helper/category_items.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: screenHeight.height,
              ),
              buildThumbnail(screenHeight.height),
              floatingContainer(),
              thirdPart(screenHeight.width),
            ],
          ),
        ),
      ),
    );
  }

  Container buildThumbnail(double screenHeight) {
    return Container(
      height: screenHeight / 4,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/thumb.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding floatingContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 110.0, left: 25.0, right: 25.0),
      child: Container(
        height: 110.0,
        width: double.infinity,
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(36, 49, 64, 0.9),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Welcome To Stouche",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontFamily: "Billabong",
                fontWeight: FontWeight.bold,
              ),
            ),
            // child: TextField(
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintText: "Search here ..",
            //     hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.blueGrey,
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  Widget gridView(List whom) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: whom.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => whom[index]['screen'],
              ),
            ),
            child: Card(
              elevation: 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 60.0,
                    height: 54.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(whom[index]['img']),
                          fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Expanded(
                    child: Text(
                      whom[index]['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 14.0,
                          fontFamily: "Google"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget thirdPart(double width) {
    return Positioned(
      top: 220.0,
      child: Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Here Welcome
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Stouche allows you to store all your cards & id's safe in one place without having carrying them all with you every time",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16.0,
                    fontFamily: "Google",
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20.0,
              ),
              gridView(CategoryItems.category),
            ],
          ),
        ),
      ),
    );
  }
}
