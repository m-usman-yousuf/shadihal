import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'CateringDetails.dart';

class CateringList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CateringListState();
  }

}
class CateringListState extends State<CateringList> {
  int count = 0;
  dbHelper sdbhelper = dbHelper();
  List <catering> vlist;
  bool isfav=false;

  @override
  Widget build(BuildContext context) {
    if (vlist == null) {
      vlist = List<catering>();
      updateListView();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Catering"),

      ),
      body: ListCat(),
    );
  }
  void updateListView() {
    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {
      Future<List<catering>> l1 = sdbhelper.getCateringList1();
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }


  ListView ListCat() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: Image(image: AssetImage("assets/Catering.jpg"),
            ),

            title: Text(this.vlist[position].caterer_name),

            subtitle: Text("Starting from"+" "+this.vlist[position].price.toString()),
            trailing: IconButton(
              icon : isfav ? Icon(Icons.favorite): Icon(Icons.favorite_border_outlined),
              color: Colors.red,
              onPressed: (){
                setState(() {
                  isfav=!isfav;
                  /////////
                  //DB Function here
                  ////////
                });
              },

            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              Get.to(CatDetail(this.vlist[position]));
            },

          ),
        );
      },
    );
  }
}