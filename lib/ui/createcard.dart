import 'dart:convert';
import 'dart:io';

import 'package:digital_wallet/helper/DBHelper.dart';
import 'package:digital_wallet/homepage.dart';
import 'package:digital_wallet/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/helper/category_items.dart';
import 'package:digital_wallet/helper/formatters.dart';
import 'package:digital_wallet/screens/publicCardsViewer.dart';
import 'package:digital_wallet/ui/publicCards.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class Createcard extends StatefulWidget {
  final CardType type;
  final TYPE secondeType;

  Createcard({@required this.type, @required this.secondeType});

  @override
  _CreatecardState createState() => _CreatecardState();
}

class _CreatecardState extends State<Createcard> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController nationality = TextEditingController();
  File _image;
  String imageToBase64;

  _showdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Add Photo"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("From Gallery"),
                onPressed: () => _handleImage(ImageSource.gallery),
              ),
              SimpleDialogOption(
                  child: Text("From Camera"),
                  onPressed: () => _handleImage(ImageSource.camera)),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
      });
      imageToBase64 = _imageTo64(_image);
    }
  }

  _imageTo64(File imageData) {
    if (imageData == null) return "";
    List<int> imageBytes = imageData.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  bool validator() {
    return (nom.text.isEmpty || prenom.text.isEmpty) ||
        (dob.text.isEmpty || nationality.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).accentColor,
            size: 30.0,
          ),
        ),
        centerTitle: true,
        title: Text("Add New Card"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Cards(
                  height: MediaQuery.of(context).size.height * 0.36,
                  name: "Iheb",
                  prenom: "Briki",
                  birthDate: "15/01/1999",
                  type: this.widget.type,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelText: "Name",
                      hintStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: prenom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelText: "Last Name",
                      hintStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskedTextInputFormatter(
                        mask: 'xx/xx/xxxx',
                        separator: '/',
                      ),
                    ],
                    controller: dob,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelText: "Birth Date",
                      hintStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nationality,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelText: "Nationality",
                      hintStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MaterialButton(
                  onPressed: () {
                    _showdialog();
                  }, //here image
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Original Copy",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.camera_alt,
                          size: 25.0,
                          color: Theme.of(context).accentColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              _image == null
                  ? SizedBox.shrink()
                  : Container(
                      height: 185,
                      width: 185,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(
                height: 15.0,
              ),
              addButton(context, 2, "Add Card", Colors.white, Colors.blue)
            ],
          ),
        ),
      ),
    );
  }

  Widget addButton(
    BuildContext context,
    int indice,
    String text,
    Color textcolor,
    Color buttonColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: MaterialButton(
        onPressed: () {
          if (!validator()) {
            Cards crd = new Cards(
              userName: HomePage.user.usrename,
              name: nom.text,
              prenom: prenom.text,
              birthDate: dob.text,
              nationality: nationality.text,
              type: this.widget.type,
              imgBase64: _imageTo64(_image),
            );
            DBHlper().insertPC(crd);
            DBHlper().insertSTAT(
              new Stats(
                  HomePage.user.usrename,
                  "New ${this.widget.type.toString().split('.')[1]} card has been added",
                  DateFormat('EEE d MMM,kk:mm:ss').format(DateTime.now()),
                  1),
            );
            setState(() {
              CategoryItems.publicCardsList.add(crd);
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCardsViewer(
                  type: widget.secondeType,
                ),
              ),
            );
          } else {
            Toast.show("Fill all Fields", context,
                duration: 3, gravity: Toast.BOTTOM);
          }
        },
        color: buttonColor,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textcolor),
          ),
        ),
      ),
    );
  }
}
