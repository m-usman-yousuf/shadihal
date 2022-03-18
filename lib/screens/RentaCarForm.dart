import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/screens/CarForm.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Models/car.dart';
import 'package:get/get.dart';
import 'AddImage.dart';

import '../Models/Rent_a_car.dart';
import '../Utils/dbhelper.dart';

class RentaCarForm extends StatefulWidget
{
 final Owner owner;
  final rent_a_Car rent;
  RentaCarForm(this.owner,[this.rent]);

  @override
  RentaCarFormState createState()
  {
    return RentaCarFormState(this.owner, this.rent);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class RentaCarFormState extends State<RentaCarForm>
{
  String _addresserror;
  String _contacterror;
  Owner owner;
  rent_a_Car rent;
  dbHelper sdbHelper = dbHelper();
  List<car> carList = List<car>();
  int serviceid;

  RentaCarFormState(this.owner,[this.rent]);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = new MaskTextInputFormatter(mask: '##:##-##:##', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController rentnameController = TextEditingController();
  TextEditingController rentcontactController = TextEditingController();
  TextEditingController rentareaController = TextEditingController();
  TextEditingController rentaddressController = TextEditingController();
  TextEditingController rentoffhrsController = TextEditingController();
  TextEditingController rentdescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    if(this.rent.isNull==false){
      rentnameController.text = this.rent.service_name;
      rentcontactController.text = "0"+this.rent.contact_no.toString();
      rentareaController.text = this.rent.area;
      rentaddressController.text = this.rent.address;
      rentoffhrsController.text = this.rent.office_hrs;
      rentdescriptionController.text= this.rent.description;

    }
    // Build a Form widget using the _formKey created above.
    return  Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Rent a Car Form"),
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
                    controller: rentnameController,
                    decoration: InputDecoration(
                        labelText: 'Service Name *',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter a Service Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$rentnameController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }
                      if(value=="Rent")
                      {
                        return 'This Service already exist';
                      }
                      if(value.length>20)
                      {
                        return 'Service name should be less than 20';
                      }
                      return null;
                    },


                  )),
              //


              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    inputFormatters: [maskFormatter],
                    style: TextStyle(color: Colors.white),
                    controller: rentoffhrsController,
                    decoration: InputDecoration(
                        labelText: 'Office Hours *',
                        hintText: 'In Hours:Min-Hours:Min',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$rentoffhrsController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      return null;
                    },


                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: rentareaController,
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
                      debugPrint('$rentareaController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length>20){
                        return 'Area name length should be less than 20';
                      }
                      return null;
                    },


                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: rentcontactController,
                    decoration: InputDecoration(
                        labelText: 'Contact No*',
                        hintText: 'Enter Your 11-Digit Phone No',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _contacterror,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$rentcontactController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      if(value.length!=11){
                        return 'Phone No length should be 11';

                      }
                      return null;
                    },


                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    onTap: () async{
                      int xstatus = await checkcontact();
                      setState(() {

                        if( xstatus == 0)
                        {
                          debugPrint("Contact mojoud he");
                          _contacterror= "This Contact Number Already exist";
                        }
                        else
                        {
                          _contacterror= null;
                        }

                      });
                    },

                    style: TextStyle(color: Colors.white),
                    controller: rentaddressController,
                    decoration: InputDecoration(
                        labelText: 'Address *',
                        hintText: 'Enter full Address ',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _addresserror,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$rentaddressController');
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


              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    onTap: () async{
                      int xstatus = await checkaddress();
                      setState(() {

                        if( xstatus == 0)
                        {
                          debugPrint("Address mojoud he");
                          _addresserror= "This Address Already exist";
                        }
                        else
                        {
                          _addresserror= null;
                        }

                      });
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 20,
                    minLines: 1,
                    style: TextStyle(color: Colors.white),
                    controller: rentdescriptionController,
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
                      debugPrint('$rentdescriptionController');
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: Text("Submit", style: TextStyle(fontSize: 20.0,color: Colors.white)),

                      onPressed: () async
                      {
                        if (carList.isEmpty)
                        {
                          debugPrint("Usman Jani 1");
                          if(_formKey.currentState.validate())
                          {
                            // int status = await sdbHelper.checkRentServiceContact(int.parse(rentcontactController.text));
                            // int status1 = await sdbHelper.checkRentServiceAddress(rentaddressController.text);
                            // if (status == 0 && status1 == 0)
                            // {
                            //   //ALERT DIALOG FOR CONTACT AND ADDRESS BOTH
                            // }
                            // else if (status == 0 && status1 == 1)
                            // {
                            //   //ALERT DIALOG FOR CONTACT ONLY
                            // }
                            // else if (status == 1 && status1 == 0)
                            // {
                            //   //ALERT DIALOG FOR ADDRESS ONLY
                            // }
                            // else if (status == 1 && status1 == 1)
                            // {
                            //   debugPrint("Usman Jani");
                              ////////////////////////////////////////////////////
                              rent_a_Car r1 = rent_a_Car(rentnameController.text, int.parse(rentcontactController.text), rentareaController.text, rentaddressController.text, rentoffhrsController.text, rentdescriptionController.text, this.owner.owner_id);
                              ////////////////////////////////////////////////////
                              _insertRentService(r1);
                              serviceid = await _getId(r1.owner_id, r1.contact_no);
                              Navigator.pop(context);
                              //Get.to(CarForm(serviceid));

                             // Get.to(CarForm(serviceid, this.owner));

                              Get.to(AddImage(this.owner, serviceid));
                              //Get.to(CarForm(serviceid, this.owner));

                            }
                            else
                            {
                              debugPrint("FAILURE IN CHECKING RENT A CAR'S UNIQUE CONSTRAINTS");
                            }

                          }






                      },
                    )]),
          SizedBox(
            height: 200.0,
            child: ListView(

            ),
          ),

              // Padding(

              //     padding: EdgeInsets.only(top:20.0,left: 120.00,right: 120.00),
              //     child: Builder(
              //         builder:(context)=> RaisedButton(
              //           color: Theme.of(context).primaryColorDark,
              //           textColor: Theme.of(context).primaryColorLight,
              //
              //           child: Text(
              //             'Submit',
              //             textScaleFactor: 1.5,
              //           ),
              //
              //           onPressed: ()
              //           {
              //
              //           },
              //
              //
              //         )))




            ],
          ),

        ));
  }

  void _insertRentService (rent_a_Car r) async
  {
    if(this.rent.isNull==false){
      sdbHelper.updateRentService(r);
    }
    else {
      await sdbHelper.insertRentService(r);
    }
  }

  Future<int> _getId (int ownerid, int cntctno) async
  {
    rent_a_Car rt = await sdbHelper.getRentServiceMapList1(ownerid, cntctno);
    return rt.service_id;
  }
  Future<int> checkcontact () async{
    int status = await sdbHelper.checkRentServiceContact(int.parse(rentcontactController.text));
    return status;

  }

  Future<int> checkaddress () async{
    int status1 = await sdbHelper.checkRentServiceAddress(rentaddressController.text);
    return status1;

  }

}