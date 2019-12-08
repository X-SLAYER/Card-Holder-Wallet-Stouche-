import 'package:flutter/material.dart';

class NotifcationsScreen extends StatefulWidget {
  NotifcationsScreen({Key key}) : super(key: key);

  @override
  _NotifcationsScreenState createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 162.0,
              height: 162.0,
              image: AssetImage("assets/images/notification.jpg"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "No Notifications Right Now !",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: "Google",
                  fontSize: 25.0),
            )
          ],
        ),
      )),
    );
  }
}
