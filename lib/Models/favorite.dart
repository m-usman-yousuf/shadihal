class favorite
{
  //INITIALIZATIONS
  int _service_id;
  int _user_id;

  //CONSTRUCTORS
  favorite(this._service_id, this._user_id );

  //GETTERS
  int get service_id =>_service_id;
  int get user_id =>_user_id;

  //SETTERS
  set service_id (int newServiceId)
  {
    this._service_id = newServiceId;
  }

  set user_id (int newUserId)
  {
    this._user_id = newUserId;
  }

  //Convert venue object into a map object
  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();

    map['service_id'] = _service_id;
    map['user_id'] = _user_id;

    return map;
  }

  //Extract a venue object from a Map object
  favorite.fromMapObject(Map<String,dynamic> map)
  {
    this._service_id = map['service_id'];
    this._user_id = map['user_id'];
  }
}


