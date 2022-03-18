class car
{
  //INITIALIZATIONS
  int _car_id;
  String _car_name;
  String _model;
  String _reg_no;
  int _seats;
  double _mileage;
  String _color;
  int _rent_per_day;
  String _fuel_type;
  String _transmission;
  int _service_id;

  //CONSTRUCTORS
  car(this._car_name, this._model, this._reg_no,this._seats ,this._mileage, this._color, this._rent_per_day, this._fuel_type, this._transmission, this._service_id);

  car.withId(this._car_id, this._car_name, this._reg_no,this._model, this._seats ,this._mileage, this._color, this._rent_per_day, this._fuel_type, this._transmission, this._service_id);

  //GETTERS
  int get car_id => _car_id;
  String get car_name => _car_name;
  String get model =>_model;
  String get reg_no => _reg_no;
  int get seats =>_seats;
  double get mileage => _mileage;
  String get color => _color;
  int get rent_per_day => _rent_per_day;
  String get fuel_type => _fuel_type;
  String get transmission => _transmission;
  int get service_id => _service_id;

  //SETTERS
  set car_name (String newName)
  {
    this._car_name = newName;
  }

  set model (String newModel)
  {
    this._model = newModel;
  }

  set reg_no (String newreg)
  {
    this._reg_no = newreg ;
  }

  set seats (int newSeats)
  {
    this._seats = newSeats;
  }

  set mileage (double newMileage)
  {
    this._mileage = newMileage;
  }

  set color (String newColor)
  {
    this._color = newColor;
  }

  set rent_per_day (int newRent)
  {
    this._rent_per_day = newRent;
  }

  set fuel_type (String newType)
  {
    this._fuel_type = newType;
  }

  set transmission (String trnsmsn)
  {
    this._transmission = trnsmsn;
  }

  set service_id (int sId)
  {
    this._service_id = sId;
  }

  //Convert car object into a map object
  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();
    if(car_id != null)
    {
      map['car_id'] = _car_id;
    }
    map['car_name'] = _car_name;
    map['model'] = _model;
    map['registration_number'] = _reg_no;
    map['seats'] = _seats;
    map['mileage'] = _mileage;
    map['color'] = _color;
    map['rent_per_day'] = _rent_per_day;
    map['fuel_type'] = _fuel_type;
    map['transmission'] = _transmission;
    map['service_id'] = _service_id;

    return map;
  }

  //Extract a car object from a Map object
  car.fromMapObject(Map<String,dynamic> map)
  {
    this._car_id = map['car_id'];
    this._car_name = map['car_name'];
    this._model = map['model'];
    this._reg_no = map['registration_number'];
    this._seats = map['seats'];
    this._mileage = map['mileage'];
    this._color = map['color'];
    this._rent_per_day = map['rent_per_day'];
    this._fuel_type = map['fuel_type'];
    this._transmission = map['transmission'];
    this._service_id = map['service_id'];
  }

}


