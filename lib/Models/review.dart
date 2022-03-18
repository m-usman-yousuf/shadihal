class review
{
  //INITIALIZATIONS
  String _content;
  int _service_id;
  int _user_id;

  //CONSTRUCTORS
  review(this._content ,this._service_id, this._user_id );

  //GETTERS
  String get content => _content;
  int get service_id =>_service_id;
  int get user_id =>_user_id;

  //SETTERS
  set content (String newContent)
  {
    this._content = newContent;
  }

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

    map['content'] = _content;
    map['service_id'] = _service_id;
    map['user_id'] = _user_id;

    return map;
  }

  //Extract a venue object from a Map object
  review.fromMapObject(Map<String,dynamic> map)
  {
    this._content = map['content'];
    this._service_id = map['service_id'];
    this._user_id = map['user_id'];
  }
}


