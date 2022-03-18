import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Models/Rent_a_car.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:shadihal/Models/catering.dart';
import 'package:shadihal/Models/photography.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/AddImage.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PhotoDetail extends StatefulWidget{
  photography photo;

  PhotoDetail(this.photo);

  @override
  State<StatefulWidget> createState() {
    return PhotoDetailState(this.photo);
  }

}
class PhotoDetailState extends State<PhotoDetail>{
  DateTime selectedDate;
  int count =0;
  photography photo;
  AddImage img;
  dbHelper sdbhelper = dbHelper();
  catering cat;
  PhotoDetailState(this.photo);
  List <Image> vlist;
  @override
  Widget build(BuildContext context) {
    // if (vlist == null)
    // {
    //   vlist = List<Image>();
    //   updateListView();
    // }
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
      child: Text(this.photo.description,
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var phone= Container(
      child: Text("0"+this.photo.phone_no.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );
    var price= Container(
      child: Text(this.photo.price.toString(),
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.5,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(this.photo.service_name),

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
            child:Text("Price",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
              textScaleFactor: 1.5,),),
          price,
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
                  child: Text("Call Now",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),

                  onPressed:() {
                    launch("tel:"+"0"+this.photo.phone_no.toString());
                  }
              ))

        ],
      ),
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
    AssetImage("assets/PHOTO1.jpg"),
    AssetImage("assets/PHOTO2.jpg"),
    AssetImage("assets/PHOTO3.jpg"),
    AssetImage("assets/Mphoto.jpg"),
    //AssetImage("assets/BeachLuxury.jpg"),
  ];

}
