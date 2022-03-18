import 'package:flutter/material.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/PhotoGraphyForm.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shadihal/Models/photography.dart';
class Ownerphotolist extends StatefulWidget
{
  final Owner owner;

  Ownerphotolist(this.owner);

  @override
  State<StatefulWidget> createState() {
    return ownerphotoliststate(this.owner);
  }

}
class ownerphotoliststate extends State<Ownerphotolist> {
  Owner owner;
  int count =0;
  dbHelper sdbhelper = dbHelper();
  List<photography> vlist;


  ownerphotoliststate(this.owner);

  @override
  Widget build(BuildContext context) {
    if (vlist == null)
    {
      vlist = List<photography>();
      updateListView();
    }
    return   Scaffold(
      appBar: AppBar(
        title: Text('PHOTOGRAPHY'),
      ),
      body: photographyListView(
        //lIST WILL BE RETRIEVED FROM DB
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          Get.to(PhotographyForm(this.owner));

        },

        tooltip: 'Add Service',
        backgroundColor: Colors.deepPurple,

        child: Icon(Icons.add_box_rounded),

      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, photography photo ) async {

    int result = await sdbhelper.deletePhotographyService(photo.service_id);
    if (result != 0) {
      _showSnackBar(context, 'venue Deleted Successfully');
    }
  }
  void navigateToDetail(Owner owner, photography photo) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return PhotographyForm(owner, photo);
    }));

    if (result == true) {
      updateListView();
    }
  }
  void updateListView() {

    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {

      //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
      Future<List<photography>> l1 = sdbhelper.getPhotographyList(this.owner.owner_id);
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }
  ListView photographyListView(){
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