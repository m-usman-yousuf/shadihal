class User {
  //INITIALIZATIONS
  int _user_id;
  String _firstName;
  String _lastName;
  String _userName;
  String _pass;
  int _phoneNo;

  //CONSTRUCTORS
  User(this._firstName, this._lastName, this._userName, this._pass,
      this._phoneNo);

  User.withId(this._user_id, this._firstName, this._lastName, this._userName,
      this._pass, this._phoneNo);

  //GETTERS
  int get user_id => _user_id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userName => _userName;
  String get pass => _pass;
  int get phoneNo => _phoneNo;

  //SETTERS
  //SETTERS
  set firstName(String newFirstName) {
    if (newFirstName.length <= 255) {
      this._firstName = newFirstName;
    }
  }

  set lastName(String newLastName) {
    if (newLastName.length <= 255) {
      this._lastName = newLastName;
    }
  }

  set userName(String newUserName) {
    if (newUserName.length >= 8) {
      this._userName = newUserName;
    }
  }

  set pass(String newPass) {
    if (newPass.length >= 8) {
      this._pass = newPass;
    }
  }

  set phoneNo(int newPhoneNo) {
    if (newPhoneNo.toString().length == 10) {
      this._phoneNo = newPhoneNo;
    }
  }

  //Converting Note Object to Map Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (user_id != null) {
      map['user_id'] = _user_id;
    }
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['username'] = _userName;
    map['password'] = _pass;
    map['phone_no'] = _phoneNo;

    return map;
  }

  //Extract note obj from map obj
  User.fromMapObject(Map<String, dynamic> map) {
    this._user_id = map['user_id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._userName = map['username'];
    this._pass = map['password'];
    this._phoneNo = map['phone_no'];
  }

  void fun() {
    print(this._firstName);
    print(this._lastName);
    print(this._userName);
    print(this._pass);
    print(this._phoneNo);
  }
}
