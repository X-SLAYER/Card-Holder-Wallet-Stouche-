class CreditCard {
  String username;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  int colorIndex;

  CreditCard(this.username,{this.cardNumber, this.expiryDate, this.cardHolderName, this.cvvCode , this.colorIndex});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': this.username,
      'cardNumber': this.cardNumber,
      'expiryDate': this.expiryDate,
      'cardHolderName': this.cardHolderName,
      'cvvCode': this.cvvCode,
      'colorIndex': this.colorIndex,
    };
    return map;
  }

  CreditCard.fromMap(Map<String, dynamic> map){
    username = map['username'];
    cardNumber = map['cardNumber'];
    expiryDate = map['expiryDate'];
    cardHolderName = map['cardHolderName'];
    cvvCode = map['cvvCode'];
    colorIndex = map['colorIndex'];
  }

}