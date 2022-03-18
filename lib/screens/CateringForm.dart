import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddImage.dart';
import '../Models/Owner.dart';
import '../Models/catering.dart';
import '../Utils/dbhelper.dart';
import 'dart:async';



class CateringForm extends StatefulWidget 
{
  final Owner owner;
  final catering cat;

  CateringForm(this.owner,[this.cat]);
  @override
  CateringFormState createState() 
  {
    return CateringFormState(this.owner,this.cat);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CateringFormState extends State<CateringForm>
{
  Owner owner;
  catering cat;
  dbHelper sdbHelper = dbHelper();
  
  CateringFormState(this.owner,[this.cat]);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String _addresserrorText= null;
  String _contacterrorText= null;
  TextEditingController CaternameController = TextEditingController();
  TextEditingController CatercontactController = TextEditingController();
  TextEditingController CaterareaController = TextEditingController();
  TextEditingController CateraddressController = TextEditingController();
  TextEditingController CaterdescriptionController = TextEditingController();
  TextEditingController CaterpriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(this.cat.isNull==false){
      CaternameController.text = this.cat.caterer_name;
      CatercontactController.text = "0"+this.cat.phone_no.toString();
      CaterareaController.text = this.cat.area;
      CateraddressController.text = this.cat.address;
      CaterdescriptionController.text = this.cat.description;
      CaterpriceController.text = this.cat.price.toString();

    }

    // Build a Form widget using the _formKey created above.
    return  Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Catering Form"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              //username
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CaternameController,
                    decoration: InputDecoration(
                        labelText: 'Catering Name *',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter your Catering Service Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$CaternameController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      //if(value=="Catering"){
                        //return 'This venue already exist';
                      //}
                      if(value.length>20){
                        return 'Catering name should be less than 20';
                      }
                      return null;
                    },


                  )),
              //Contact No.
              TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: CatercontactController,
                decoration: InputDecoration(
                    labelText: 'Contact No. *',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter your 11-Digit Phone No.',
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: _contacterrorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )

                ),

                onChanged: (String text) async
                {
                  int xstatus = await checkcontact(text);
                  setState(()
                  {
                    if( xstatus == 0)
                    {
                      debugPrint("Contact mojoud he");
                      _contacterrorText= "This Contact Number Already exist";
                    }
                    else
                    {
                      _contacterrorText= null;
                    }
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This Field is Required ';
                  }
                  if (value.length!=11) {
                    return 'Phone No. should be 11 Digits ';
                  }
                  return null;
                },
              ),
             //Catering Area
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CaterareaController,
                    decoration: InputDecoration(
                        labelText: 'Area*',
                        hintText: 'Enter Area',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$CaterareaController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length>30){
                        return 'Area name length should be less than 30';
                      }
                      return null;
                    },


                  )),
              //Catering Price
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CaterpriceController,
                    decoration: InputDecoration(
                        labelText: 'Price per Head*',
                        hintText: 'Enter minimum price',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$CaterpriceController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length>30){
                        return 'Price length should be less than 30';
                      }
                      return null;
                    },


                  )),

              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(

                    style: TextStyle(color: Colors.white),
                    controller: CateraddressController,
                    decoration: InputDecoration(
                        labelText: 'Address *',
                        hintText: 'Enter full Address ',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _addresserrorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (String text) async
                    {
                      int xstatus = await checkaddress(text);
                      setState(()
                      {
                        if( xstatus == 0)
                        {
                          debugPrint("Address mojoud he");
                          _addresserrorText= "This Address Already exist";
                        }
                        else
                        {
                          _addresserrorText= null;
                        }
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length>256){
                        return 'This Field is too large';
                      }
                      return null;
                    },


                  )),

          //CATERING DESCRIPTION
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    style: TextStyle(color: Colors.white),
                    controller: CaterdescriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description *',
                        hintText: 'Enter Description ',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )
                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CaterdescriptionController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length>500){
                        return 'This Field is too large';
                      }
                      return null;
                    },


                  )),


              Padding(
                  padding: EdgeInsets.only(top:20.0,left: 120.00,right: 120.00),
                  child: Builder(
                      builder:(context)=> RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,

                        child: Text(
                          'Submit',
                          textScaleFactor: 1.5,
                        ),

                        onPressed: () async
                        {
                          if(_formKey.currentState.validate())
                          {
                            // int status = await sdbHelper.checkCateringContact(int.parse(CatercontactController.text));
                            // int status1 = await sdbHelper.checkCateringAddress(CateraddressController.text);
                            // if (status == 0 && status1 == 0)
                            // {
                            //   //ALERT DIALOG FOR CONTACT AND ADDRESS BOTH

                            //
                            //


                            // }
                            // else if (status == 0 && status1 == 1)
                            // {
                            //   //ALERT DIALOG FOR CONTACT ONLY

                            //   debugPrint("Contact already");
                            //

                            // }
                            // else if (status == 1 && status1 == 0)
                            // {
                            //   //ALERT DIALOG FOR ADDRESS ONLY
                            // }
                            // else if (status == 1 && status1 == 1)
                            // {
                              ////////////////////////////////////////////////////
                              catering caterS = catering(CaternameController.text, int.parse(CatercontactController.text), CaterareaController.text , CateraddressController.text, int.parse(CaterpriceController.text), CaterdescriptionController.text, this.owner.owner_id);
                              ////////////////////////////////////////////////////
                              _insertcatservice(caterS);
                             Navigator.pop(context);
                              int x = await _getId(caterS.owner_id, caterS.price);
                             // Get.to(AddImage(this.owner,x ));
                            

                            }
                            else
                            {
                              debugPrint("FAILURE IN CHECKING CATERING'S UNIQUE CONSTRAINTS");
                            }

                        },


                      )))




            ],
          ),

        ));
  }

  void _insertcatservice (catering c1) async
  {
    if(this.cat.isNull==false){
    sdbHelper.updateCateringService(c1);
  }
  else {
    await sdbHelper.insertCateringService(c1);
  }
  }

  Future<int> _getId (int ownerid, int cntctno) async
  {
    catering ct = await sdbHelper.getCateringMapList1(ownerid, cntctno);
    return ct.caterer_id;
  }
  Future<int> checkcontact (text) async{
    int status = await sdbHelper.checkCateringContact(int.parse(text));
    return status;

  }

  Future<int> checkaddress (text) async{
    int status1 = await sdbHelper.checkCateringAddress(CateraddressController.text);
    return status1;

  }
}