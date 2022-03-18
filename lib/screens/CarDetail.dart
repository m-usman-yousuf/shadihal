import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:shadihal/Models/car.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/AddImage.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetail extends StatefulWidget{
  rent_a_Car _rent_a_car;
  car c1;

  CarDetail(this._rent_a_car,this.c1);

  @override
  State<StatefulWidget> createState() {
    return CarDetailState(this._rent_a_car,this.c1);
  }

}
class CarDetailState extends State<CarDetail>{
  DateTime selectedDate;
  int count =0;
  rent_a_Car _rent_a_car;
  AddImage img;
  car c1;
  dbHelper sdbhelper = dbHelper();
  CarDetailState(this._rent_a_car,this.c1);
  @override
  Widget build(BuildContext context) {

    var name= Container(
      child: Text(this.c1.car_name,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var model= Container(
      child: Text(this.c1.model.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var fuel= Container(
      child: Text(this.c1.fuel_type,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var mileage= Container(
      child: Text(this.c1.mileage.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var color= Container(
      child: Text(this.c1.color,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var transmission= Container(
      child: Text(this.c1.transmission,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var cap= Container(
      child: Text(this.c1.seats.toString(),
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
          Container(
            margin:EdgeInsets.only(top:20.0),
            height: 30.0,
            child:Text("Car Name",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          name,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Model",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          model,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Fuel Type",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          fuel,
          Container(
            margin: EdgeInsets.only(top:50.0,),
            height: 30.0,
            child:Text("Color",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          color,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Seats",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          cap,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Transmission",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          transmission,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Mileage",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          mileage

        ],
      ),
    );
  }
}
