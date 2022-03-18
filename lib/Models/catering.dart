class catering
{
  //INITIALIZATIONS
  int _caterer_id;
  String _caterer_name;
  int _phone_no;
  String _area;
  String _address;
  int _price;
  String _description;
  double _rating;
  int _owner_id;

  //CONSTRUCTORS
  catering(this._caterer_name, this._phone_no, this._area ,this._address, this._price, this._description, this._owner_id, [this._rating]);

  catering.withId(this._caterer_id, this._caterer_name, this._phone_no, this._area ,this._address, this._price, this._description, this._owner_id, [this._rating]);


  //GETTERS
  int get caterer_id => _caterer_id;
  String get caterer_name => _caterer_name;
  int get phone_no =>_phone_no;
  String get area =>_area;
  String get address => _address;
  int get price => _price;
  String get description => _description;
  int get owner_id => _owner_id;
  double get rating => _rating;

  //SETTERS
  set caterer_name (String newName)
  {
    this._caterer_name = newName;
  }

  set phone_no (int newNumber)
  {
    this._phone_no = newNumber;
  }

  set area (String newArea)
  {
    this._area = newArea;
  }

  set address (String newAddress)
  {
    this._address = newAddress;
  }

  set price (int newPrice)
  {
    this._price = newPrice;
  }

  set description (String newDescription)
  {
    this._description = newDescription;
  }

  set owner_id (int newId)
  {
    this._owner_id = newId;
  }

  set rating (double newRating)
  {
    this._rating = newRating;
  }

  //Convert venue object into a map object
  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();

    if(caterer_id != null)
    {
      map['caterer_id'] = _caterer_id;
    }
    map['caterer_name'] = _caterer_name;
    map['phone_no'] = _phone_no;
    map['area'] = _area;
    map['address'] = _address;
    map['price'] = _price;
    map['description'] = _description;
    map['rating'] = _rating;
    map['owner_id'] = _owner_id;

    return map;
  }

  //Extract a venue object from a Map object
  catering.fromMapObject(Map<String,dynamic> map)
  {
    this._caterer_id = map['caterer_id'];
    this._caterer_name = map['caterer_name'];
    this._phone_no = map['phone_no'];
    this._area = map['area'];
    this._address = map['address'];
    this._price = map['price'];
    this._description = map['description'];
    this._rating = map['rating'];
    this._owner_id = map['owner_id'];
  }

}


