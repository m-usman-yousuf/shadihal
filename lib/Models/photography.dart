class photography
{
  //INITIALIZATIONS
  int _service_id;
  String _service_name;
  int _phone_no;
  int _price;
  double _rating;
  String _description;
  int _owner_id;

  //CONSTRUCTORS
  photography(this._service_name ,this._phone_no, this._price, this._description, this._owner_id,  [this._rating]);

  photography.withId(this._service_id, this._service_name ,this._phone_no, this._price ,this._rating, this._description, this._owner_id);


  //GETTERS
  int get service_id => _service_id;
  String get service_name => _service_name;
  int get phone_no =>_phone_no;
  int get price =>_price;
  double get rating => _rating;
  String get description => _description;
  int get owner_id =>_owner_id;

  //SETTERS
  set service_name (String newName)
  {
    this._service_name = newName;
  }

  set phone_no (int newNumber)
  {
    this._phone_no = newNumber;
  }

  set price (int newPrice)
  {
    this._price = newPrice;
  }

  set rating (double newRating)
  {
    this._rating = newRating;
  }

  set description (String newDescription)
  {
    this._description = newDescription;
  }

  set owner_id (int newId)
  {
    this._owner_id = newId;
  }

  //Convert venue object into a map object
  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();
    if(service_id != null)
    {
      map['service_id'] = _service_id;
    }
    map['service_name'] = _service_name;
    map['phone_no'] = _phone_no;
    map['price'] = _price;
    map['rating'] = _rating;
    map['description'] = _description;
    map['owner_id'] = _owner_id;

    return map;
  }

  //Extract a venue object from a Map object
  photography.fromMapObject(Map<String,dynamic> map)
  {
    this._service_id = map['service_id'];
    this._service_name = map['service_name'];
    this._phone_no = map['phone_no'];
    this._price = map['price'];
    this._rating = map['rating'];
    this._description = map['description'];
    this._owner_id = map['owner_id'];
  }
}


