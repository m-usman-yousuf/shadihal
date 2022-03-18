class Venue
{
  //INITIALIZATIONS
    int _venue_id;
    String _venue_name;
    int _pricelb;
    int _priceub;
    String _area;
    int _contact_no;
    String _type;
    String _office_hrs;
    String _address;
    int _capacity;
    double _rating;
    String _description;
    int _owner_id;

  //CONSTRUCTORS
    Venue(this._venue_name,this._pricelb, this._priceub ,this._area, this._contact_no, this._type, this._office_hrs, this._address, this._capacity, this._description, this._owner_id, [this._rating]);

    Venue.withId( this._venue_id, this._venue_name,this._pricelb, this._priceub ,this._area, this._contact_no, this._type, this._office_hrs, this._address, this._capacity, this._description, this._owner_id, [this._rating]);


    //GETTERS
    int get venue_id => _venue_id;
    String get venue_name => _venue_name;
    int get pricelb =>_pricelb;
    int get priceub =>_priceub;
    String get area => _area;
    int get contact_no => _contact_no;
    String get type => _type;
    String get office_hrs => _office_hrs;
    String get address =>_address;
    int get capacity =>_capacity;
    double get rating => _rating;
    String get description => _description;
    int get owner_id => _owner_id;

    //SETTERS
    set venue_name (String newVenueName)
    {
      this._venue_name = newVenueName;
    }

    set pricelb (int newPrice)
    {
      this._pricelb = newPrice;
    }

    set priceub (int newPrice)
    {
      this._priceub = newPrice;
    }

    set area (String newArea)
    {
      this._area = newArea;
    }

    set contact_no (int newContact_no)
    {
      this._contact_no = newContact_no;
    }

    set type (String newType)
    {
      this._type = newType;
    }

    set office_hrs (String newOffHrs)
    {
      this._office_hrs = newOffHrs;
    }

    set address (String newAddress)
    {
      this._address = newAddress;
    }

    set capacity (int newCapacity)
    {
      this._capacity = newCapacity;
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
      if(venue_id != null)
      {
        map['venue_id'] = _venue_id;
      }
      map['venue_name'] = _venue_name;
      map['price_lb'] = _pricelb;
      map['price_ub'] = _priceub;
      map['area'] = _area;
      map['contact_no'] = _contact_no;
      map['type'] = _type;
      map['office_hrs'] = _office_hrs;
      map['address'] = _address;
      map['capacity'] = _capacity;
      map['rating'] = _rating;
      map['description'] = _description;
      map['owner_id'] = _owner_id;

      return map;
    }

    //Extract a venue object from a Map object
    Venue.fromMapObject(Map<String,dynamic> map)
    {
      this._venue_id = map['venue_id'];
      this._venue_name = map['venue_name'];
      this._pricelb = map['price_lb'];
      this._priceub = map['price_ub'];
      this._area = map['area'];
      this._contact_no = map['contact_no'];
      this._type = map['type'];
      this._office_hrs = map['office_hrs'];
      this._address = map['address'];
      this._capacity = map['capacity'];
      this._rating = map['rating'];
      this._description = map['description'];
      this._owner_id = map['owner_id'];
    }
}


