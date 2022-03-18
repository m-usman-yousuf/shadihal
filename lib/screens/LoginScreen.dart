import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Models/User.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/OwnerHome.dart';
import 'package:get/get.dart';
import 'package:shadihal/screens/homescreen.dart';
import 'package:shadihal/screens/UserHome.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }

}
class LoginState extends State<Login>
{
  dbHelper sdbHelper = dbHelper();
  Owner owner = new Owner(' ', ' ', ' ', ' ', 0, 0);
  User user = new User (' ', ' ', ' ', ' ', 0);

  TextEditingController usernameController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  TextEditingController ownernameController = TextEditingController();
  TextEditingController ownerpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: DefaultTabController(
        length: 2,
        child:Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Login"),
        bottom: TabBar(
          tabs: [
            Tab(text: "USER"),
            Tab(text: "MEMBER"),
          ],

        ),

      ),
        body: TabBarView(

        children:<Widget>[
          ListView(
          children: <Widget>[
            //username
            Padding(
          padding: EdgeInsets.only(top: 10.0,bottom:10.0),

          child: TextFormField(
            style: TextStyle(color: Colors.white),
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )

              ),
              onChanged: (text){
                debugPrint('$usernameController');
              },

            validator: (value) {
              if (value.isEmpty) {
                return 'This Field is Required ';
              }
              return null;
            },
            )),
            //password
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: userpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter 8-digit Password',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )

              ),
              onChanged: (text){
                //debugPrint('$text');
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'This Field is Required ';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top:20.0,left: 120.00,right: 120.00),
            child: Builder(
                builder:(context)=> RaisedButton(
        color: Theme.of(context).primaryColorDark,
    textColor: Theme.of(context).primaryColorLight,

    child: Text(
    'Login',
    textScaleFactor: 1.5,
    ),

               onPressed: ()
               {
                  if(_formKey.currentState.validate())
                  {
                    // If the form is valid, display a Snackbar.
                    //this.user.userName = usernameController.text;

                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('please wait')));
                    _checkProfile(usernameController.text, userpasswordController.text, 0);
                  }
                  //_checkProfile(usernameController.text, userpasswordController.text, 0);
                },





            )))


          ],
        ),
        //2nd tab
          ListView(
            children: <Widget>[
              //username
              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                controller: ownernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )

                ),
                onChanged: (text){
                  debugPrint('$ownernameController');
                },

                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This Field is Required ';
                    }
                    return null;
                  },
              )),
              //password
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: ownerpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )

                ),
                onChanged: (text){
                  //debugPrint('$text');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This Field is Required ';
                  }
                  return null;
                },
              ),
    Padding(
    padding: EdgeInsets.only(top:20.0,left: 120.00,right: 120.00),
    child: Builder(
    builder:(context)=> RaisedButton(
    color: Theme.of(context).primaryColorDark,
    textColor: Theme.of(context).primaryColorLight,

    child: Text(
    'Login',
    textScaleFactor: 1.5,
    ),

    onPressed: ()
    {
      if(_formKey.currentState.validate())
      {
        // If the form is valid, display a Snackbar.
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('please wait')));
        _checkProfile(ownernameController.text, ownerpasswordController.text, 1);
      }

    },


    )))],
          ),


    ]))));
  }

  Future <dynamic> _checkProfile (String nameToCheck, String passToCheck, int identifier) async
  {
    if (identifier == 0)
    {
      var res = await sdbHelper.checkUserProfie(nameToCheck, passToCheck);
      if (res == 0)
      {
        debugPrint("Incorrect Username or password");
       return showDialog(
         context: context,
           builder:(context){

           return AlertDialog(
         title: Text("ERROR"),
         content: Text("Incorrect Username or password"),

         actions: <Widget>[
           FlatButton(child: Text("Enter Again"),
           onPressed: (){
             Navigator.of(context).pop();
             usernameController.clear();
             userpasswordController.clear();

           },),
         ],
       );});
      }
      else
      {
        user = res;
        debugPrint("Hello");
        debugPrint(user.firstName);
        debugPrint(user.lastName);
        debugPrint(user.userName);
        debugPrint(user.pass);
        debugPrint(user.phoneNo.toString());
        Get.to(userhome(this.user));
      }
    }
    else if (identifier == 1)
    {
      var res = await sdbHelper.checkOwnerProfie(nameToCheck, passToCheck);
      if (res == 0)
      {
        debugPrint("incorrect");
        return showDialog(
            context: context,
            builder:(context){
        return AlertDialog(
          title: Text("ERROR"),
          content: Text("Incorrect Username or password"),

          actions: <Widget>[
            FlatButton(child: Text("Enter Again"),
              onPressed: (){
              Navigator.of(context).pop();
              ownernameController.clear();
              ownerpasswordController.clear();
              }


            )]
        );});}
      else
      {
        owner = res;
        debugPrint("Hello");
        debugPrint(owner.owner_id.toString());
        debugPrint(owner.firstName);
        debugPrint(owner.lastName);
        debugPrint(owner.userName);
        debugPrint(owner.pass);
        debugPrint(owner.nic.toString());
        debugPrint(owner.phoneNo.toString());
        Get.to(Ownerhome(this.owner));

      }
    }
    else
    {
      debugPrint('Exception Encountered');
    }

  }

}
