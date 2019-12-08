import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  String userName;
  String name;
  String prenom;
  String birthDate;
  String nationality;
  double height;
  CardType type;
  String imgBase64;

  Cards(
      {this.userName,
      this.name,
      this.prenom,
      this.birthDate,
      this.nationality,
      this.height,
      this.type,
      this.imgBase64});

  CardType getType(String str) {
    switch (str) {
      case "CardType.id":
        return CardType.id;
        break;
      case "CardType.driver":
        return CardType.driver;
        break;
      case "CardType.gym":
        return CardType.gym;
        break;
      case "CardType.health":
        return CardType.health;
        break;
      case "CardType.loyality":
        return CardType.loyality;
        break;
      case "CardType.passport":
        return CardType.passport;
        break;
      case "CardType.transport":
        return CardType.transport;
        break;
      case "CardType.student":
        return CardType.student;
        break;
      default:
        return CardType.driver;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': this.userName,
      'name': this.name,
      'prenom': this.prenom,
      'birthDate': this.birthDate,
      'nationality': this.nationality,
      'type': this.type.toString(),
      'img': this.imgBase64,
    };
    return map;
  }

  Cards.fromMap(Map<String, dynamic> map) {
    userName = map['username'];
    name = map['name'];
    prenom = map['prenom'];
    birthDate = map['birthDate'];
    nationality = map['nationality'];
    type = getType(map['type'].toString());
    imgBase64 = map['img'];
  }

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    super.initState();
  }

  String revealMockup() {
    switch (this.widget.type) {
      case CardType.id:
        return "assets/images/mockups/id.PNG";
        break;
      case CardType.driver:
        return "assets/images/mockups/driving.PNG";
        break;
      case CardType.gym:
        return "assets/images/mockups/gym.PNG";
        break;
      case CardType.health:
        return "assets/images/mockups/health.PNG";
        break;
      case CardType.loyality:
        return "assets/images/mockups/loyality.PNG";
        break;
      case CardType.passport:
        return "assets/images/mockups/passport.PNG";
        break;
      case CardType.transport:
        return "assets/images/mockups/transport.PNG";
        break;
      case CardType.student:
        return "assets/images/mockups/student.PNG";
        break;
      default:
        return "Idle";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              revealMockup(),
            ),
            fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 15.0,
            spreadRadius: 1.0,
            offset: Offset(
              3.0,
              3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}

enum CardType {
  id,
  passport,
  driver,
  health,
  gym,
  transport,
  loyality,
  student
}
