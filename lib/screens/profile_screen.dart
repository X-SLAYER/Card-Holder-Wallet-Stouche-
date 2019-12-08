import 'package:digital_wallet/ui/viewStats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/provider_models/theme_provider.dart';
import 'package:digital_wallet/services/Login.dart';

import '../homepage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String totalCards;

  @override
  void initState() {
    super.initState();
    setState(() {
      totalCards = (CategoryItems.cardsList.length +
              CategoryItems.publicCardsList.length)
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Switch(
          value: themeProvider.isLightTheme,
          onChanged: (val) {
            themeProvider.setThemeData = val;
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              height: 8.0,
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: "Google",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.7),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  firstPart(context),
                  SizedBox(
                    height: 25.0,
                  ),
                  secondePart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstPart(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 155.0,
                width: 155.0,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.4),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/default.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                HomePage.user.usrename,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6.0,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Free Member",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).primaryColor),
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  totalCards == null
                      ? "Total Cards : 0"
                      : "Total Cards : $totalCards",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondePart() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () async {
                // DBHlper().drop();
              },
              leading:
                  Icon(Icons.update, size: 35.0, color: Colors.orangeAccent),
              title: Text(
                "Bcome a pro Member",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: "Google",
                    fontSize: 16.0),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).accentColor),
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewStats())),
              leading: Icon(
                Icons.assessment,
                size: 35.0,
                color: Colors.orange[900],
              ),
              title: Text(
                "My Statistic",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: "Google",
                    fontSize: 16.0),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).accentColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.help_outline, size: 35.0, color: Colors.grey),
              title: Text(
                "Help",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: "Google",
                    fontSize: 16.0),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).accentColor),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, Login.id),
              leading: Icon(Icons.assignment_return,
                  size: 35.0, color: Colors.redAccent),
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: "Google",
                    fontSize: 16.0),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
