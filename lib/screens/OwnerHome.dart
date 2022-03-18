import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shadihal/screens/CateringList.dart';
import 'package:shadihal/screens/ContactUs.dart';
import 'package:shadihal/screens/JoinUs.dart';
import 'package:shadihal/screens/PhotographyList.dart';
import 'package:shadihal/screens/RentaCarList.dart';
import 'package:shadihal/screens/LoginScreen.dart';
import 'package:shadihal/screens/Signup.dart';
import 'VenueList.dart';
import 'homescreen.dart';
import 'package:shadihal/Models/Owner.dart';
import 'OwnerProfile.dart';
import 'AboutUs.dart';

class Ownerhome extends StatefulWidget
{
  final Owner owner;

  Ownerhome(this.owner);

  @override
  State<StatefulWidget> createState()
  {
    return Ownerhomestate(this.owner);
  }
}

class Ownerhomestate extends State<Ownerhome>
{
  Owner owner;
  final _minimumPadding = 5.0;

  Ownerhomestate (this.owner);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => SystemNavigator.pop(),
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title:Text('Shadihal'),
              actions: <Widget>[
              Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Text("LOGOUT"),
                  Icon(Icons.logout),
              ]),
                onTap: ()
                {
                  this.owner=null;

                  Get.to(homescreen());
                },
                )
                ),

              ],

              ),
              drawer: Drawer(



              child: Container(
              color: Colors.black,
              child:ListView(
              children: <Widget>[
              SizedBox(
              height: 65.0,
              child:DrawerHeader(
              //margin: EdgeInsets.only(top:5.0),
              child: Text('Menu',
              textScaleFactor: 1.7,
              style: TextStyle(
              color: Colors.white,
              ),
              ),
              decoration: BoxDecoration(

                              color: Colors.deepPurple,

                            ),
                          )
                      ),
                      ListTile(
                        title: Text(this.owner.firstName+this.owner.lastName,style: TextStyle(color: Colors.yellow),textScaleFactor: 1.2),
                        onTap: () {
                          // Update the state of the app.
                          Get.to(Ownerprofile(this.owner));
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text('Log Out',style: TextStyle(color: Colors.yellow),textScaleFactor: 1.2),
                        onTap: ()
                        {
                          this.owner=null;

                          Get.to(homescreen());
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text('About Us',style: TextStyle(color: Colors.yellow),textScaleFactor: 1.2),
                        onTap: () {
                          // Update the state of the app.
                          Get.to(aboutus());
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text('Contact Us',style: TextStyle(color: Colors.yellow),textScaleFactor: 1.2),
                        onTap: () {
                          // Update the state of the app.
                          Get.to(ContactUs());
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text('Join Us',style: TextStyle(color: Colors.yellow),textScaleFactor: 1.2),
                        onTap: () {
                          // Update the state of the app.
                          Get.to(JoinUs());
                          // ...
                        },
                      ),

                    ],
                  )),
            ),



            body: Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding * 5, bottom: _minimumPadding * 5),
                child: ListView(
                  children: <Widget>[
                    //first Child
                    venue_opt(),
                    Container(height: 25.0),
                    catering_opt(),
                    Container(height: 25.0),
                    rent_a_car(),
                    Container(height: 25.0),
                    Photography(),
                  ],
                ))));
  }

  Widget venue_opt() {
    AssetImage assetImage = AssetImage('assets/venue.jpg');
    Image image = Image(image: assetImage, fit: BoxFit.fill,);
    return InkWell(
      child: Column(children: <Widget>[
        Container(height:10.0),
        Container(
          height: 200.0,
          width: 300.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),

            child: image,

          ),


        ),
        Container(
          height: 10.0,
        ),
        Text("VENUE",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.yellow)),
        Text("starting from Rs.10000",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
      ]),
      onTap: () {
        Get.to(VenueList());
      },
    );
  }

  Widget catering_opt() {
    AssetImage assetImage = AssetImage('assets/Catering.jpg');
    Image image = Image(image: assetImage, fit: BoxFit.fill,);
    return InkWell(
      child: Column(children: <Widget>[
        Container(height:10.0),
        Container(
          height: 200.0,
          width: 300.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),

            child: image,

          ),


        ),
        Container(
          height: 10.0,
        ),
        Text("CATERING",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.yellow)),
        Text("starting from Rs.5000",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
      ]),
      onTap: () {
        Get.to(CateringList());
      },


    );
  }

  Widget rent_a_car() {
    AssetImage assetImage = AssetImage('assets/Rent.jpg');
    Image image = Image(image: assetImage, fit: BoxFit.fill,);
    return InkWell(
      child: Column(children: <Widget>[
        Container(height:10.0),
        Container(
          height: 200.0,
          width: 300.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),

            child: image,

          ),


        ),
        Container(
          height: 10.0,
        ),
        Text("RENT A CAR",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.yellow)),
        Text("starting from Rs.1000",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
      ]),
      onTap: () {
        Get.to(RentaCarList());
      },
    );
  }

  Widget Photography() {
    AssetImage assetImage = AssetImage('assets/photo.jpg');
    Image image = Image(image: assetImage, fit: BoxFit.fill);
    return InkWell(
      child: Column(children: <Widget>[
        Container(height:10.0),
        Container(
          height: 200.0,
          width: 300.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),

            child: image,

          ),


        ),
        Container(
          height: 10.0,
        ),
        Text("PHOTOGRAPHY",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.yellow)),
        Text("starting from Rs.5000",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
      ]),
      onTap: () {
        Get.to(PhotographyList());
      },
    );
  }
}
