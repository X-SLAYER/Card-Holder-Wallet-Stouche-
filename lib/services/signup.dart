import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/models/User.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  static final id = "Signup_screen";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String username, password, email;
  bool isLoading = false;

  _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        setState(() {
          isLoading = true;
        });
        User user = await DBHlper().insert(new User(username, password, 1));
        print(user.usrename);
        setState(() {
          isLoading = false;
        });
        Toast.show("Inscription Completed", context,
            duration: 2, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      } catch (ex) {
        setState(() {
          isLoading = false;
        });
        Toast.show("Username already in use", context, duration: 3, gravity: Toast.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "email",
                          labelStyle: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                        ),
                        validator: (String inpute) =>
                            inpute.isEmpty ? "fill the email !" : null,
                        onSaved: (input) => email = input,
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
                        onPressed: () {
                          isLoading ? print("Nothing") : _submit();
                        },
                        color: Colors.blue,
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    isLoading
                        ? SizedBox.shrink()
                        : Container(
                            width: 250.0,
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              onPressed: () => Navigator.pop(context),
                              color: Theme.of(context).accentColor,
                              child: Text(
                                "Go back To Login",
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
