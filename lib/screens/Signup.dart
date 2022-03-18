import 'dart:async';
import "package:flutter/material.dart";
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/screens/LoginScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shadihal/Models/User.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  String _nicerror = null;
  String _ownernameerror = null;
  String _usernameerror = null;
  String _usercontacterror = null;
  dbHelper sdbHelper = dbHelper();
  List<Owner> ownerList;
  int count = 0;
  Owner owner = new Owner(' ', ' ', ' ', ' ', 0, 0);
  User user = new User(' ', ' ', ' ', ' ', 0);
  Future<int> status;

  TextEditingController usernameController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();

  TextEditingController ownernameController = TextEditingController();
  TextEditingController ownerpasswordController = TextEditingController();
  TextEditingController ofnameController = TextEditingController();
  TextEditingController olnameController = TextEditingController();
  TextEditingController NICController = TextEditingController();
  TextEditingController ophonenoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (ownerList == null) {
      ownerList = List<Owner>();
    }

    return Form(
        key: _formKey,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  //My name is jawwad
                  //My name is Usman
                  title: Text("SIGNUP"),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "BECOME A USER"),
                      Tab(text: "BECOME A MEMBER"),
                    ],
                  ),
                ),
                body: TabBarView(children: <Widget>[
                  ListView(
                    children: <Widget>[
                      //username
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: usernameController,
                            decoration: InputDecoration(
                                labelText: 'Username *',
                                hintText: 'Enter a unique Username',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                errorText: _usernameerror,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }

                              return null;
                            },
                          )),
                      //password
                      TextFormField(
                        onTap: () async {
                          int xstatus = await checkuser();
                          setState(() {
                            if (xstatus == 0) {
                              debugPrint("Username mojoud he");
                              _usernameerror = "This Username Already exist";
                            } else {
                              _usernameerror = null;
                            }
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: userpasswordController,
                        decoration: InputDecoration(
                            labelText: 'Password *',
                            hintText: 'Enter 8-digit Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                        onChanged: (text) {
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
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            controller: phonenoController,
                            decoration: InputDecoration(
                                labelText: 'Phone No',
                                hintText: 'Enter 11-Digit Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                errorText: _usercontacterror,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$phonenoController');
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            onTap: () async {
                              int xstatus = await checkcontact();
                              setState(() {
                                if (xstatus == 0) {
                                  debugPrint("Contact mojoud he");
                                  _usercontacterror =
                                      "This Contact Number Already exist";
                                } else {
                                  _usercontacterror = null;
                                }
                              });
                            },
                            style: TextStyle(color: Colors.white),
                            controller: fnameController,
                            decoration: InputDecoration(
                                labelText: 'First Name *',
                                hintText: 'Enter your First name',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$fnameController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: lnameController,
                            decoration: InputDecoration(
                                labelText: 'Last Name *',
                                hintText: 'Enter a Last Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, left: 120.00, right: 120.00),
                          child: Builder(
                              builder: (context) => RaisedButton(
                                    color: Theme.of(context).primaryColorDark,
                                    textColor:
                                        Theme.of(context).primaryColorLight,
                                    child: Text(
                                      'Register',
                                      textScaleFactor: 1.5,
                                    ),
                                    onPressed: () async {
                                      // int status = await sdbHelper.checkUserUsername(usernameController.text);
                                      // if (status == 0)
                                      // {
                                      //   debugPrint("Failure2");
                                      // }
                                      // else
                                      // {
                                      //   int status1 = await sdbHelper.checkUserPhoneNo(int.parse(phonenoController.text));
                                      //   if(status1 == 0)
                                      //   {
                                      //     debugPrint("Failure3");
                                      //   }
                                      //   else
                                      //   {

                                      if (_formKey.currentState.validate()) {
                                        //   int status = await sdbHelper.checkUserUsername(usernameController.text);
                                        //   if (status == 0)
                                        //   {
                                        //     debugPrint("Failure2");
                                        //   }
                                        //   else
                                        //   {
                                        //     int status1 = await sdbHelper.checkUserPhoneNo(int.parse(phonenoController.text));
                                        //     if(status1 == 0)
                                        //     {
                                        //       debugPrint("Failure3");
                                        //     }
                                        //     else
                                        //     {

                                        // If the form is valid, display a Snackbar.
                                        this.user.firstName =
                                            fnameController.text;
                                        this.user.lastName =
                                            lnameController.text;
                                        this.user.userName =
                                            usernameController.text;
                                        this.user.pass =
                                            userpasswordController.text;
                                        this.user.phoneNo =
                                            int.parse(phonenoController.text);
                                        _insertuser(this.user);
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('please wait')));
                                        Get.to(Login());
                                      }
                                    },
                                  )))
                    ],
                  ),
                  //2nd tab
                  ListView(
                    children: <Widget>[
                      //username
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: ownernameController,
                            decoration: InputDecoration(
                                labelText: 'Username *',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Enter a unique Username',
                                hintStyle: TextStyle(color: Colors.grey),
                                errorText: _ownernameerror,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$ownernameController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              } else if (value.length < 8) {
                                return 'username must be of 8 characters';
                              }
                              return null;
                            },
                          )),
                      //password
                      TextFormField(
                        onTap: () async {
                          int xstatus = await checkowner();
                          setState(() {
                            if (xstatus == 0) {
                              debugPrint("Owner mojoud he");
                              _ownernameerror = "This Owner Already exist";
                            } else {
                              _ownernameerror = null;
                            }
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: ownerpasswordController,
                        decoration: InputDecoration(
                            labelText: 'Password *',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter a Password of length 8',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                        onChanged: (text) {
                          debugPrint('$ownerpasswordController');
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This Field is Required ';
                          }
                          if (value.length < 8) {
                            return 'password must be 8 characters long';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            controller: NICController,
                            decoration: InputDecoration(
                                labelText: 'CNIC *',
                                hintText: 'Enter Your CNIC',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                errorText: _nicerror,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$NICController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            onTap: () async {
                              int xstatus = await checknic();
                              setState(() {
                                if (xstatus == 0) {
                                  debugPrint("CNIC mojoud he");
                                  _nicerror = "This CNIC Already exist";
                                } else {
                                  _nicerror = null;
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            controller: ophonenoController,
                            decoration: InputDecoration(
                                labelText: 'Phone No *',
                                hintText: 'Enter 11-Digit Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$ophonenoController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: ofnameController,
                            decoration: InputDecoration(
                                labelText: 'First Name *',
                                hintText: 'Enter your First name',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$ofnameController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: olnameController,
                            decoration: InputDecoration(
                                labelText: 'Last Name *',
                                hintText: 'Enter a Last Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (text) {
                              debugPrint('$olnameController');
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This Field is Required ';
                              }
                              return null;
                            },
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, left: 120.00, right: 120.00),
                          child: Builder(
                              builder: (context) => RaisedButton(
                                    color: Theme.of(context).primaryColorDark,
                                    textColor:
                                        Theme.of(context).primaryColorLight,
                                    child: Text(
                                      'Register',
                                      textScaleFactor: 1.5,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        debugPrint(ownernameController.text);
                                        debugPrint(
                                            ownerpasswordController.text);
                                        debugPrint(NICController.text);
                                        debugPrint(ofnameController.text);
                                        debugPrint(olnameController.text);
                                        debugPrint(ophonenoController.text);

                                        // int status = await sdbHelper.checkOwnerUsername(ownernameController.text);
                                        // if (status == 0)
                                        // {
                                        //   debugPrint("Failure");
                                        // }
                                        // else
                                        // {
                                        //   int status1 = await sdbHelper.checkOwnerNic(int.parse(NICController.text));
                                        //   if(status1 == 0)
                                        //   {
                                        //     debugPrint("Failure1");
                                        //   }
                                        //   else
                                        //   {
                                        try {
                                          this.owner.firstName =
                                              ofnameController.text;
                                          this.owner.lastName =
                                              olnameController.text;
                                          this.owner.userName =
                                              ownernameController.text;
                                          this.owner.pass =
                                              ownerpasswordController.text;
                                          this.owner.nic =
                                              int.parse(NICController.text);
                                          this.owner.phoneNo = int.parse(
                                              ophonenoController.text);
                                        } catch (e) {
                                          debugPrint(e);
                                        }
                                        debugPrint('hello1' + owner.userName);
                                        try {
                                          // ignore: unrelated_type_equality_checks
                                          _insertowner(this.owner);
                                        } catch (e) {
                                          print(e);
                                        } finally {
                                          Get.to(Login());
                                        }
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('please wait')));
                                      }
                                    },
                                  )))
                    ],
                  ),
                ]))));
  }

  void _deleteowner(BuildContext context, Owner owner) async {
    int result = await sdbHelper.deleteOwner(owner.owner_id);
  }

  Future<int> _insertowner(Owner owner) async {
    await sdbHelper.insertOwner(owner);
    return 1;
  }

  void _deleteuser(BuildContext context, User user) async {
    int result = await sdbHelper.deleteUser(user.user_id);
  }

  void _insertuser(User user) async {
    await sdbHelper.insertUser(user);
  }

  Future<int> checkuser() async {
    int status = await sdbHelper.checkUserUsername(usernameController.text);
    return status;
  }

  Future<int> checkowner() async {
    int status = await sdbHelper.checkOwnerUsername(ownernameController.text);
    return status;
  }

  Future<int> checkcontact() async {
    int status1 =
        await sdbHelper.checkUserPhoneNo(int.parse(phonenoController.text));
    return status1;
  }

  Future<int> checknic() async {
    int status1 = await sdbHelper.checkOwnerNic(int.parse(NICController.text));
    return status1;
  }
}
