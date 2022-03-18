import 'package:flutter/material.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/Ownrentdetail.dart';
import 'package:shadihal/screens/RentaCarForm.dart';
import 'package:get/get.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:sqflite/sqflite.dart';

class Ownerrentlist extends StatefulWidget
{
  final Owner owner;

  Ownerrentlist(this.owner);

  @override
  State<StatefulWidget> createState() {
    return ownerrentliststate(this.owner);
  }

}
class ownerrentliststate extends State<Ownerrentlist> {
  Owner owner;
  int count =0;
  dbHelper sdbhelper = dbHelper();
  List <rent_a_Car> vlist;

  ownerrentliststate(this.owner);

  @override
  Widget build(BuildContext context) {
    if (vlist == null)
    {
      vlist = List<rent_a_Car>();
      updateListView();
    }
    return   Scaffold(
      appBar: AppBar(
        title: Text(this.owner.firstName+" "+"RENTACAR"),
      ),
      body: rentList(
        //lIST WILL BE RETRIEVED FROM DB
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          debugPrint('FAB clicked');
          Get.to(RentaCarForm(this.owner));

        },

        tooltip: 'Add Rent a Car',
        backgroundColor: Colors.deepPurple,

        child: Icon(Icons.add_box_rounded),

      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, rent_a_Car rent ) async {

    int result = await sdbhelper.deleteRentService(rent.service_id);
    if (result != 0) {
      _showSnackBar(context, 'Rent a Car Deleted Successfully');
    }
  }
  void navigateToDetail(Owner owner,rent_a_Car rent) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OwnRentDetail(rent,owner);
    }));

    if (result == true) {
      updateListView();
    }
  }
  void updateListView() {

    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {

      //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
      Future<List<rent_a_Car>> l1 = sdbhelper.getRentServiceList(this.owner.owner_id);
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }
  ListView rentList(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              child: Image(image: AssetImage("assets/fb.png")),
            ),

            title: Text(this.vlist[position].service_name),

            subtitle: Text(this.vlist[position].area),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, this.vlist[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.owner,this.vlist[position]);
            },

          ),
        );
      },
    );

  }
}