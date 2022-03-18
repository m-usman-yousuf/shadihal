import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    return contactusstate();
  }

}
class contactusstate extends State<ContactUs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar
          (
          title: Text("JOIN US"),
        ),
        body:Padding(
            padding: EdgeInsets.only(left: 10.0,top: 100.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>
                [
                  Container(height: 50.0,
                    child:Text("Connect with US", textAlign:TextAlign.center, style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),),

                  GestureDetector(
                      onTap: ()=> launch("https://www.facebook.com/usman.rao.5245961"),
                  child: Container(height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30,width: 30,
                      child: Container(
                        child: Image(image:AssetImage('assets/fb.png')),
                      ),),

                      Text("  Facebook/Usman Yousuf",
                    style: TextStyle(fontSize: 20.0,color: Colors.white),),

                    ]))),
                  Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: ()=>launch("tel:03168620582"),
                  child:Container(height: 50.0,
                    child: Text("Contact No: 03168620582",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0,color: Colors.white)),)))

                ]
            )));
  }
}