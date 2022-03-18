import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/Models/venue_reg.dart';
import 'package:shadihal/screens/AddImage.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shadihal/Models/User.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'LoginScreen.dart';


class VenueDetail extends StatefulWidget
{
  Venue venue;
  User user;
  
  VenueDetail(this.venue, [this.user]);

  @override
  State<StatefulWidget> createState()
  {
    return VenueDetailState(this.venue, this.user);
  }

}
class VenueDetailState extends State<VenueDetail>
{
  DateTime selectedDate;
  int count =0;
  AddImage imghelper= AddImage(null,0);
  dbHelper sdbhelper = dbHelper();
  Venue venue;
  List <Image> vlist;
  User user=null;
  int status;

  VenueDetailState(this.venue, this.user);
  @override
  Widget build(BuildContext context)
  {
    var description= Container(
      child: Text(this.venue.description,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
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
    var pricemin= Container(
      child: Text(this.venue.pricelb.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var pricemax= Container(
      child: Text(this.venue.priceub.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var phone= Container(
      child: Text("0"+this.venue.contact_no.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var offhrs= Container(
      child: Text(this.venue.office_hrs,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var area= Container(
      child: Text(this.venue.area,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var address= Container(
      child: Text(this.venue.address,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var capacity= Container(
      child: Text(this.venue.capacity.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(this.venue.venue_name),

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
            child:Text("Minimum Price",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          pricemin,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Maximum Price",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          pricemax,
          Container(
            margin: EdgeInsets.only(top:50.0),
            height: 30.0,
            child:Text("Office Hours",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          offhrs,
          Container(
            margin: EdgeInsets.only(top:50.0,),
            height: 30.0,
            child:Text("Capacity",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          capacity,
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
            margin: EdgeInsets.only(bottom:30.0,top:30.0,left:50.0,right: 50.0),
             height: 50.0,

          child: RaisedButton(

            color: Colors.deepPurple,
              child: Text("Book Now",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),

              onPressed:()
              {
                _selectDate(context, this.user);
              }
          )),
          Container(
              margin: EdgeInsets.only(bottom:30.0,top:30.0,left:50.0,right: 50.0),
              height: 50.0,

              child: RaisedButton(

                  color: Colors.deepPurple,
                  child: Text("Call Now",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),

                  onPressed:() {
                    launch("tel:"+"0"+this.venue.contact_no.toString());
                  }
              ))









        ],
      ),
    );
  }
  _selectDate(BuildContext context, User user) async
  {
  if(this.user.isNull==true)
  {
    debugPrint("user null h");
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget loginButton = FlatButton(
      child: Text("Login"),
      onPressed: () {
        Get.to(Login());
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ERROR"),
      content: Text("The User Is not Logged in"),
      actions: [
        loginButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  else
  {
    debugPrint("idhr kiun arhe");
  final DateTime picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2025),
  );

  status = await _checkDate(picked.toString(), this.venue.venue_id);

  if (picked != null && status == 1)
  {

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Your Booking has been reserved"),
      content: Text("Booking Date: "+ " "+picked.toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  setState(()
  {
  selectedDate = picked;
  ven_reg v = ven_reg(selectedDate.toString(), this.user.user_id, this.venue.venue_id);
  _insertVenreg(v);
  debugPrint(selectedDate.toString());
  });

  }
  else if(picked !=null && status==0)
  {
  //DISPLAY ALERT DIALOUGE
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ERROR"),
      content: Text("This date is already booked"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  debugPrint("ye Date pehele se he");
  }
  else{

  }
  }

  }


SizedBox ImageCarousel()
{
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
  //     Future<List<Image>> l1 = imghelper
  //     l1.then((vList) {
  //       setState(() {
  //         this.vlist = vList;
  //         this.count = vList.length;
  //       });
  //     });
  //   });
  // }
  final List<AssetImage> carouselimages = [
    AssetImage("assets/VEN3.jpg"),
    AssetImage("assets/venue.jpg"),
    AssetImage("assets/VEN1.jpg"),
    AssetImage("assets/VEN2.jpg"),
    AssetImage("assets/BeachLuxury.jpg"),
  ];

  Future<int> _checkDate(String date, int sid) async
  {
    int result = await sdbhelper.checkVenRegDate(date.toString(), sid);
    return result;
  }

  void _insertVenreg (ven_reg v) async
  {
    await sdbhelper.insertVenRegDate(v);
  }

}

