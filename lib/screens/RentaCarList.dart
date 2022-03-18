import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

import 'RentaCarDetail.dart';
class RentaCarList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RentaCarListState();
  }

}
class RentaCarListState extends State<RentaCarList> {
  bool isfav=false;

  int count = 0;
  dbHelper sdbhelper = dbHelper();
  List <rent_a_Car> vlist;

  @override
  Widget build(BuildContext context) {
    if (vlist == null) {
      vlist = List<rent_a_Car>();
      updateListView();
    }
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Rent A Car"),

      ),
      body: ListRent(),
    );
  }
  void updateListView() {
    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {
      Future<List<rent_a_Car>> l1 = sdbhelper.getRentServiceList1();
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }

  ListView ListRent() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: Image(image: AssetImage("assets/Rent.jpg"),),

            title: Text(this.vlist[position].service_name),

            subtitle: Text(this.vlist[position].contact_no.toString()),
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
              Get.to(RentDetail(this.vlist[position]));
            },

          ),
        );
      },
    );

  }
}