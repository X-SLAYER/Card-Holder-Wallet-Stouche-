import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/helper/DBHelper.dart';

import '../homepage.dart';

class ViewStats extends StatefulWidget {
  ViewStats({Key key}) : super(key: key);

  @override
  _ViewStatsState createState() => _ViewStatsState();
}

class _ViewStatsState extends State<ViewStats> {
  List<Stats> stats = [];

  Widget _getLeading(int code) {
    switch (code) {
      case 1:
        return Icon(
          Icons.done,
          color: Colors.greenAccent,
          size: 35.0,
        );
        break;
      case 2:
        return Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 35.0,
        );
        break;
      default:
        return null;
    }
  }

  _getStats() async {
    try {
      stats.clear();
      List<Stats> statis = await DBHlper().getStats(HomePage.user.usrename);
      if (statis.length == 0) return;
      setState(() {
        stats = statis;
      });
    } catch (ex) {}
  }

  _clearStats() async {
    try {
      setState(() {
        DBHlper().deleteStats(HomePage.user.usrename);
        stats.clear();
      });
    } catch (ex) {}
  }

  @override
  void initState() {
    super.initState();
    _getStats();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "My Statistics",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              color: Colors.redAccent,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: new Text("Are You Sure !",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        content: new Text("This will delete all your stats !"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("continue"),
                            onPressed: () {
                              _clearStats();
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.clear_all,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: stats.length != 0
          ? listStats(theme)
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "You Have No Data To Display",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: theme.accentColor,
                      fontSize: 30.0,
                      fontFamily: "Google"),
                ),
              ),
            ),
    );
  }

  Widget listStats(ThemeData theme) {
    return Container(
      child: ListView.builder(
        itemCount: stats.length == 0 ? 0 : stats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: _getLeading(stats[index].code),
                  title: Text(
                    stats[index].description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: theme.accentColor),
                  ),
                  subtitle: Text(
                    stats[index].date,
                    style: TextStyle(color: theme.accentColor.withOpacity(0.8)),
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
