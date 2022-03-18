import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:shadihal/Models/car.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/AddImage.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shadihal/screens/CarDetail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RentDetail extends StatefulWidget{
  rent_a_Car _rent_a_car;

  RentDetail(this._rent_a_car);

  @override
  State<StatefulWidget> createState() {
    return RentDetailState(this._rent_a_car);
  }

}
class RentDetailState extends State<RentDetail>{
  DateTime selectedDate;
  int count =0;
  rent_a_Car _rent_a_car;
  AddImage img;
  dbHelper sdbhelper = dbHelper();
  catering cat;
  RentDetailState(this._rent_a_car);
  List <car> vlist;
  @override
  Widget build(BuildContext context) {
    if (vlist == null)
     {
       vlist = List<car>();
       updateListView();
     }
    var rating=Container(
        child: RatingBar(
          initialRating: 3,
          allowHalfRating: true,
          direction: Axis.horizontal,
          itemCount: 5,
          ratingWidget: RatingWidget(
              full: Icon(Icons.star,color: Colors.yellow,),
              half: Icon(Icons.star_half,color: Colors.yellow,),
              empty: Icon(Icons.star_border_outlined,color: Colors.yellow,)
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            print(rating);
            debugPrint(rating.toString());
            //DB Operation here
          },
        )
    );
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

      ),
      body: ListView(
        children: <Widget>[
          ImageCarousel(),
          Container(
            margin:EdgeInsets.only(top:20.0),
            height: 30.0,
            child:Text("Rating",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          rating,
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
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("CARS",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),

          SizedBox(
            height: 300.0,

            child:  carList(),
          ),

          Container(
              margin: EdgeInsets.only(bottom:30.0,top:30.0,left:50.0,right: 50.0),
              height: 50.0,

              child: RaisedButton(

                  color: Colors.deepPurple,
                  child: Text("Call Now",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),

                  onPressed:() {
                    launch("tel:"+"0"+this._rent_a_car.contact_no.toString());
                  }
              ))

        ],
      ),
    );
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
            trailing: Text("Rent: " +this.vlist[position].rent_per_day.toString()),
            onTap: () {
              debugPrint("ListTile Tapped");
              Get.to(CarDetail(_rent_a_car, this.vlist[position]));


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
