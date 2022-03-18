import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:shadihal/Models/car.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/AddImage.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shadihal/screens/CarForm.dart';
import 'package:shadihal/screens/RentaCarForm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnRentDetail extends StatefulWidget{
  rent_a_Car _rent_a_car;
  Owner owner;
  OwnRentDetail(this._rent_a_car,this.owner);

  @override
  State<StatefulWidget> createState() {
    return OwnRentDetailState(this._rent_a_car,this.owner);
  }

}
class OwnRentDetailState extends State<OwnRentDetail>{
  DateTime selectedDate;
  int count =0;
  //car c1;
  rent_a_Car _rent_a_car;
  AddImage img;
  List <car> vlist;
  dbHelper sdbhelper = dbHelper();
  Owner owner;
  OwnRentDetailState(this._rent_a_car,this.owner);
  @override
  Widget build(BuildContext context) {
    //if (vlist == null)
     //{
      // vlist = List<car>();
       updateListView();
    // }

    var description= Container(
      child: Text(this._rent_a_car.description,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var phone= Container(
      child: Text("0"+this._rent_a_car.contact_no.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var offhrs= Container(
      child: Text(this._rent_a_car.office_hrs,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var area= Container(
      child: Text(this._rent_a_car.area,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var address= Container(
      child: Text(this._rent_a_car.address,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(this._rent_a_car.service_name),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Row(
                    children: <Widget>[
                      Text("EDIT"),
                      Icon(Icons.launch),
                    ]),
                onTap: ()
                {
                  this.owner=null;

                  Get.to(RentaCarForm(this.owner,this._rent_a_car));
                },
              )
          ),

        ],

      ),
      body: ListView(
        children: <Widget>[
          ImageCarousel(),
          Container(
            margin:EdgeInsets.only(top:20.0),
            height: 30.0,
            child:Text("Description",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          description,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Area",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          area,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Address",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          address,
          Container(
            margin: EdgeInsets.only(top:50.0,),
            height: 30.0,
            child:Text("Contact Number",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          phone,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Office Hours",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          offhrs,
          SizedBox(
            height: 300.0,

            child:  carList(),
          ),
          Container(
              margin: EdgeInsets.only(bottom:30.0,top:30.0,left:50.0,right: 50.0),
              height: 50.0,

              child: RaisedButton(

                  color: Colors.deepPurple,
                  child: Text("ADD Cars",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),

                  onPressed:() {
                    Get.to(CarForm(this._rent_a_car.service_id, this.owner));
                  }
              ))

        ],
      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, car c1 ) async {

    int result = await sdbhelper.deleteCar(c1.car_id);
    if (result != 0) {
      _showSnackBar(context, 'Rent a Car Deleted Successfully');
    }
    updateListView();
  }
  void updateListView() {

    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {

      //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
      Future<List<car>> l1 = sdbhelper.getCarList(this._rent_a_car.service_id);
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }
  ListView carList(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
              leading: Image(image: AssetImage("assets/RENT1.jpg")),


            title: Text(this.vlist[position].car_name),

            subtitle: Text(this.vlist[position].color),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, this.vlist[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
            },

          ),
        );
      },
    );

  }

  


  SizedBox ImageCarousel() {
    return SizedBox(
        height: 300.0,
        child:Carousel(

          images: carouselimages,
          borderRadius: true,
          boxFit: BoxFit.cover,

        ));}
  // void updateListView() {
  //
  //   final Future<Database> dbFuture = sdbhelper.initDb();
  //   dbFuture.then((database) {
  //
  //     //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
  //     Future<List<Image>> l1 =
  //     l1.then((vList) {
  //       setState(() {
  //         this.vlist = vList;
  //         this.count = vList.length;
  //       });
  //     });
  //   });
  // }
  final List<AssetImage> carouselimages = [
    AssetImage("assets/RENT1.jpg"),
    AssetImage("assets/RENT2.jpg"),
    AssetImage("assets/MRent.jpg"),
    AssetImage("assets/Rent.jpg"),
    //AssetImage("assets/BeachLuxury.jpg"),
  ];

}
