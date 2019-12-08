import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/services/signup.dart';
import 'package:toast/toast.dart';

import '../homepage.dart';

class Login extends StatefulWidget {
  static final id = "Login_screen";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String username, password;
  bool isLoading = false;

  _revealCC(String userName) async {
    setState(() {
      CategoryItems.cardsList.clear();
    });
    var o = await DBHlper().getCC(userName);
    if (o.length == 0) return;
    o.forEach((card) {
      setState(() {
        CategoryItems.cardsList.add(card);
      });
    });
    print(o[0].cardHolderName);
  }

  _revealPC(String userName) async {
    setState(() {
      CategoryItems.publicCardsList.clear();
    });
    var o = await DBHlper().getPC(userName);
    if (o.length == 0) return;
    o.forEach((card) {
      setState(() {
        CategoryItems.publicCardsList.add(card);
      });
    });
  }

  _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        setState(() {
          isLoading = true;
        });
        var users = await DBHlper().getUser(username, password);
        setState(() {
          isLoading = false;
        });
        if (users.length == 0) {
          Toast.show("Inccorect Credentials", context,
              duration: 3, gravity: Toast.BOTTOM);
        } else {
          HomePage.user = users[0];
          _revealCC(users[0].usrename);
          _revealPC(users[0].usrename);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
          );
        }
      } catch (ex) {
        print(ex.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Stouche",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 50.0,
                    fontFamily: "Billabong"),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                        ),
                        validator: (String inpute) =>
                            inpute.isEmpty ? "fill the username !" : null,
                        onSaved: (input) => username = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                        ),
                        validator: (String inpute) =>
                            inpute.isEmpty ? "fill the Password !" : null,
                        onSaved: (input) => password = input,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: _submit,
                        color: Colors.blue,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: () =>
                            Navigator.pushNamed(context, SignUp.id),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
