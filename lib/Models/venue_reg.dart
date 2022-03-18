class ven_reg
{
  //INITIALIZATIONS
    int _id;
    String _sel_date;
    int _user_id;
    int _service_id;

  //CONSTRUCTORS
    ven_reg(this._sel_date, this._user_id, this._service_id);

    ven_reg.withId(this._id, this._sel_date, this._user_id, this._service_id);

  //GETTERS
    int get id => _id;
    String get sel_date => _sel_date;
    int get user_id => _user_id;
    int get service_id => _service_id;

  //SETTERS
    set sel_date (String newsel)
    {
      this._sel_date = newsel;
    }

    set user_id (int newuid)
    {
      this._user_id = newuid;
    }

    set service_id (int newsid)
    {
      this._service_id = newsid;
    }

  //Convert ven_reg object into a map object
    Map<String,dynamic> toMap()
    {
      var map = Map<String,dynamic>();
      if(id != null)
      {
        map['id'] = _id;
      }
      map['date'] = _sel_date;
      map['user_id'] = _user_id;
      map['service_id'] = _service_id;

      return map;
    }

    //Extract a ven_reg object from a Map object
    ven_reg.fromMapObject(Map<String,dynamic> map)
    {
      this._id = map['id'];
      this._sel_date = map['date'];
      this._user_id = map['user_id'];
      this._service_id = map['service_id'];
    }

}