class Photo
{
  String photo_name;
  int owner_id;
  int service_id;
  int c_id;

  Photo( this.photo_name, this.service_id, this.owner_id, [this.c_id]);

  Map<String, dynamic> toMap()
  {
    var map = <String, dynamic>
    {
      'image': photo_name,
      'service_id' : service_id,
      'owner_id' : owner_id,
      'c_id' : c_id,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map)
  {
    photo_name = map['image'];
    service_id = map['service_id'];
    owner_id = map['owner_id'];
    c_id = map['c_id'];
  }
}