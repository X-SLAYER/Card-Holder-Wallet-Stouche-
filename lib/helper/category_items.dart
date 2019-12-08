import 'dart:ui';

import 'package:digital_wallet/cardViewer.dart';
import 'package:digital_wallet/models/creditcard_model.dart';
import 'package:digital_wallet/screens/publicCardsViewer.dart';
import 'package:digital_wallet/ui/card_create.dart';
import 'package:digital_wallet/ui/createcard.dart';
import 'package:digital_wallet/ui/publicCards.dart';
import 'package:intl/intl.dart';

class CategoryItems {
  static List<Map<String, dynamic>> category = [
    {
      'name': 'Wallets',
      'img': 'assets/images/category/cc.png',
      "screen": CardViewer()
    },
    {
      'name': 'Identifications',
      'img': 'assets/images/category/id.png',
      "screen": MyCardsViewer(type: TYPE.identifiactions)
    },
    {
      'name': 'Shopping',
      'img': 'assets/images/category/loyality.png',
      "screen": MyCardsViewer(type: TYPE.shopping)
    },
    {
      'name': 'Students',
      'img': 'assets/images/category/student.jpg',
      "screen": MyCardsViewer(type: TYPE.students)
    },
    {
      'name': 'Transport',
      'img': 'assets/images/category/transport.png',
      "screen": MyCardsViewer(type: TYPE.transport)
    },
    {
      'name': 'Other Docs',
      'img': 'assets/images/category/other.png',
      "screen": MyCardsViewer(type: TYPE.other)
    },
  ];

  static List<Map<String, dynamic>> cards = [
    {
      'name': 'Identity Card',
      'img': 'assets/images/cards/identitycard.png',
      'screen': Createcard(type: CardType.id, secondeType: TYPE.identifiactions)
    },
    {
      'name': 'Driving Licnce',
      'img': 'assets/images/cards/driveCC.png',
      'screen':
          Createcard(type: CardType.driver, secondeType: TYPE.identifiactions)
    },
    {
      'name': 'Student Card',
      'img': 'assets/images/cards/studentCC.png',
      'screen': Createcard(type: CardType.student, secondeType: TYPE.students)
    },
    {
      'name': 'Debit Card',
      'img': 'assets/images/cards/CreditCC.png',
      'screen': CardCreate(type: "DC")
    },
    {
      'name': 'Transport Card',
      'img': 'assets/images/cards/transportCC.png',
      'screen':
          Createcard(type: CardType.transport, secondeType: TYPE.transport)
    },
    {
      'name': 'Employee  Card',
      'img': 'assets/images/cards/employeeCC.png',
      'screen': Createcard(type: CardType.student, secondeType: TYPE.students)
    },
    {
      'name': 'Loyality Card',
      'img': 'assets/images/cards/loyalityCC.png',
      'screen': Createcard(type: CardType.loyality, secondeType: TYPE.shopping)
    },
    {
      'name': 'GYM Card',
      'img': 'assets/images/cards/gymCC.png',
      'screen': Createcard(type: CardType.gym, secondeType: TYPE.other)
    },
    {
      'name': 'Health Card',
      'img': 'assets/images/cards/HealthCC.png',
      'screen': Createcard(type: CardType.health, secondeType: TYPE.other)
    },
    {
      'name': 'AirLine Card',
      'img': 'assets/images/cards/airlineCC.png',
      'screen':
          Createcard(type: CardType.transport, secondeType: TYPE.transport)
    },
    {
      'name': 'Gift Card',
      'img': 'assets/images/cards/giftCC.png',
      'screen': CardCreate(type: "GC")
    },
  ];
  //?-----------------------------------------------
  static List<CreditCard> cardsList = [
    // new CreditCard(
    //     cardHolderName: "Iheb Briki",
    //     cardNumber: "5118 1574 5711 3526",
    //     cvvCode: "532",
    //     expiryDate: "20/2019",
    //     colorIndex: 0),
    // new CreditCard(
    //     cardHolderName: "Moncer CHtioui",
    //     cardNumber: "4618 1574 5711 3526",
    //     cvvCode: "401",
    //     expiryDate: "20/2019",
    //     colorIndex: 0),
    // new CreditCard(
    //     cardHolderName: "Firas Boukadida ",
    //     cardNumber: "3718 1574 5711 7546",
    //     cvvCode: "125",
    //     expiryDate: "20/2019",
    //     colorIndex: 0),
    // new CreditCard(
    //     cardHolderName: "Weld Gzeuez",
    //     cardNumber: "5118 1574 8975 7826",
    //     cvvCode: "332",
    //     expiryDate: "20/2021",
    //     colorIndex: 0),
    // new CreditCard(
    //     cardHolderName: "Amira Dgham",
    //     cardNumber: "1111 1111 1111 1111",
    //     cvvCode: "111",
    //     expiryDate: "Google Gift Card",
    //     colorIndex: 3),
  ];
  //--------------------------------------------
  static List<Color> colorsList = <Color>[
    Color.fromRGBO(61, 132, 223, 1.0), //LightBlue credit card
    Color.fromRGBO(114, 71, 200, 1.0), //Purple debit card
    Color.fromRGBO(106, 188, 121, 1.0), //Green check
    Color.fromRGBO(229, 92, 131, 1.0), //Pink gift card
    Color.fromRGBO(96, 200, 227, 1.0), //Cyan
    Color.fromRGBO(219, 157, 80, 1.0), //Orange
    Color.fromRGBO(60, 61, 63, 1.0), //Black
    Color.fromRGBO(222, 88, 116, 1.0), //Salmon check
    Color.fromRGBO(128, 182, 234, 1.0), //LightCyan
  ];
  //?----------------------------------------------
  static List<Cards> publicCardsList = [
    // new Cards(
    //   name: "Iheb",
    //   prenom: "Briki",
    //   nationality: "Tunisian",
    //   type: CardType.id,
    //   userName: HomePage.user.usrename,
    // ),
    // new Cards(
    //   name: "Iheb",
    //   prenom: "Briki",
    //   birthDate: "15/01/1999",
    //   nationality: "Tunisian",
    //   type: CardType.passport,
    //   userName: HomePage.user.usrename,
    // ),
    // new Cards(
    //   name: "Iheb",
    //   prenom: "Briki",
    //   birthDate: "15/01/1999",
    //   nationality: "Tunisian",
    //   type: CardType.gym,
    //   userName: HomePage.user.usrename,
    // ),
    // new Cards(
    //   name: "Iheb",
    //   prenom: "Briki",
    //   birthDate: "15/01/1999",
    //   nationality: "Tunisian",
    //   type: CardType.health,
    //   userName: HomePage.user.usrename,
    // ),
    // new Cards(
    //   name: "Iheb",
    //   prenom: "Briki",
    //   birthDate: "15/01/1999",
    //   nationality: "Tunisian",
    //   type: CardType.student,
    //   userName: HomePage.user.usrename,
    // ),
  ];

  static returnDate()
  {
    return DateFormat('EEE d MMM,kk:mm:ss').format(DateTime.now());
  }
}
