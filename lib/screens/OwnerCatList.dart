import 'package:flutter/material.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/CateringForm.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class OwnerCatlist extends StatefulWidget
{
  final Owner owner;

  OwnerCatlist(this.owner);

  @override
  State<StatefulWidget> createState() {
    return ownercatliststate(this.owner);
  }

}
class ownercatliststate extends State<OwnerCatlist> {
  Owner owner;
  int count =0;
  dbHelper sdbhelper = dbHelper();
  List <catering> vlist;



  ownercatliststate(this.owner);

  @override
  Widget build(BuildContext context) {
    if (vlist == null)
    {
      vlist = List<catering>();
      updateListView();
    }
    return   Scaffold(
      appBar: AppBar(
        title: Text('CATERING'),
      ),
      body: CatListView(
        //lIST WILL BE RETRIEVED FROM DB
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          Get.to(CateringForm(this.owner));

        },

        tooltip: 'Add Catering',
        backgroundColor: Colors.deepPurple,

        child: Icon(Icons.add_box_rounded),

      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, catering cat) async {

    int result = await sdbhelper.deleteCateringService(cat.caterer_id);
    if (result != 0) {
      _showSnackBar(context, 'venue Deleted Successfully');
      updateListView();
    }
  }
  void navigateToDetail(Owner owner,catering cat) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CateringForm(owner,cat);
    }));

    if (result == true) {
      updateListView();
    }
  }
  void updateListView() {

    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {

      //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
      Future<List<catering>> l1 = sdbhelper.getCateringList(this.owner.owner_id);
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }
  ListView CatListView(){
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

            title: Text(this.vlist[position].caterer_name),

            subtitle: Text(this.vlist[position].price.toString()),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, this.vlist[position]);
                updateListView();
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