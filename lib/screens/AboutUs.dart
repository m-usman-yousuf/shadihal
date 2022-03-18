import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class aboutus extends StatelessWidget
{
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar
            (
            title: Text("ABOUT US"),
          ),
          body: Center(

                   child: SingleChildScrollView(
                     //margin: EdgeInsets.only(top: 20.0),
                   child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>
                  [
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      height: 50.0,
                      child:Text("Our Company", textAlign:TextAlign.center,
                        style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),),
                    Text("Shadihal is an official product of ASUM Technologies. At ASUM Technologies we provide  Top Quality Software Solutions.",textAlign: TextAlign.center ,
                      style: TextStyle(fontSize: 20.0,color: Colors.amber),),


                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(height: 50.0,
                          child:Text("Our Team", textAlign:TextAlign.center,
                            style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),), ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      height: 200.0,
                    child: Image(image: AssetImage('assets/CEO.jpg')),),

                    Text("Usman Yousuf",style: TextStyle(fontSize: 25.0,color: Colors.white),),
                    Text("CEO and Managing Director",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      height: 200.0,
                      child: Image(image: AssetImage('assets/DB.jpg')),),

                    Text("Muhammad Jawwad",style: TextStyle(fontSize: 25.0,color: Colors.white),),
                    Text("Database Engineer",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      height: 200.0,
                      child: Image(image: AssetImage('assets/UI.jpg')),),

                    Text("Ritika Thorani",style: TextStyle(fontSize: 25.0,color: Colors.white),),
                    Text("UI/UX Developer",style: TextStyle(fontSize: 20.0,color: Colors.white),),




                                  ]),)));



    }
  }



