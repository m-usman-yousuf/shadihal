class rent_a_Car
{
  //INITIALIZATIONS
  int _service_id;
  String _service_name;
  int _contact_no;
  String _area;
  String _address;
  String _office_hrs;
  double _rating;
  String _description;
  int _owner_id;

  //CONSTRUCTORS
  rent_a_Car(this._service_name, this._contact_no, this._area, this._address, this._office_hrs, this._description, this._owner_id, [this._rating]);

  rent_a_Car.withId( this._service_id, this._service_name, this._contact_no, this._area, this._address, this._office_hrs, this._description, this._owner_id, [this._rating]);


  //GETTERS
  int get service_id => _service_id;
  String get service_name => _service_name;
  int get contact_no => _contact_no;
  String get area => _area;
  String get address =>_address;
  String get office_hrs => _office_hrs;
  String get description => _description;
  double get rating => _rating;
  int get owner_id => _owner_id;

  //SETTERS
  set service_name (String newVenueName)
  {
    this._service_name = newVenueName;
  }

  set contact_no (int newContact_no)
  {
    this._contact_no = newContact_no;
  }

  set area (String newArea)
  {
    this._area = newArea;
  }

  set address (String newAddress)
  {
    this._address = newAddress;
  }

  set office_hrs (String newOffHrs)
  {
    this._office_hrs = newOffHrs;
  }

  set rating (double newRating)
  {
    this._rating = newRating;
  }

  set description (String newDescription)
  {
    this._description = newDescription;
  }

  set owner_id (int newOwner_id)
  {
    this._owner_id = newOwner_id;
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
    map['phone_no'] = _contact_no;
    map['area'] = _area;
    map['address'] = _address;
    map['office_hrs'] = _office_hrs;
    map['rating'] = _rating;
    map['description'] = _description;
    map['owner_id'] = _owner_id;

    return map;
  }

  //Extract a venue object from a Map object
  rent_a_Car.fromMapObject(Map<String,dynamic> map)
  {
    this._service_id = map['service_id'];
    this._service_name = map['service_name'];
    this._contact_no = map['phone_no'];
    this._area = map['area'];
    this._address = map['address'];
    this._office_hrs = map['office_hrs'];
    this._rating = map['rating'];
    this._description = map['description'];
    this._owner_id = map['owner_id'];
  }
}


