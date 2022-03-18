import 'package:flutter/material.dart';
import 'dart:async';
import '../Models/Owner.dart';
import '../Models/photography.dart';
import '../Utils/dbhelper.dart';
import 'package:get/get.dart';
import 'AddImage.dart';


class PhotographyForm extends StatefulWidget
{
  final Owner owner;
  final photography photo;

  PhotographyForm(this.owner,[this.photo]);

  @override
  PhotographyFormState createState()
  {
    return PhotographyFormState(this.owner,this.photo);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class PhotographyFormState extends State<PhotographyForm>
{
  Owner owner;
  photography photo;
  dbHelper sdbHelper = dbHelper();

  PhotographyFormState(this.owner,[this.photo]);

  // Create a global key that uniquely identifies the Form widge
  // and allows validation of the form.
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _contacterror=null;
  TextEditingController PhotonameController = TextEditingController();
  TextEditingController PhotocontactController = TextEditingController();
  TextEditingController PhotopriceController = TextEditingController();
  TextEditingController PhotodescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  if(this.photo.isNull==false){
    PhotonameController.text = this.photo.service_name;
    PhotocontactController.text ="0"+this.photo.phone_no.toString();
    PhotopriceController.text = this.photo.price.toString();
    PhotodescriptionController.text=this.photo.description;

  }
    // Build a Form widget using the _formKey created above.
    return  Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Photography Form"),
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
                    controller: PhotonameController,
                    decoration: InputDecoration(
                        labelText: 'Photography Service Name *',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter your Photography Service Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text){
                      debugPrint('$PhotonameController');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This Field is Required ';
                      }
                      //if(value=="Catering"){
                      //return 'This venue already exist';
                      //}
                      if(value.length>20){
                        return 'name should be less than 20';
                      }
                      return null;
                    },


                  )),
              //Contact No.
              TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: PhotocontactController,
                decoration: InputDecoration(
                    labelText: 'Contact No. *',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter your 11-Digit Phone No.',
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: _contacterror,
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
                  if (value.length!=11) {
                    return 'Phone No. should be 11 Digits ';
                  }
                  return null;
                },
              ),
              //Photography price
              TextFormField(
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
                keyboardType: TextInputType.number,
                controller: PhotopriceController,
                decoration: InputDecoration(
                    labelText: 'Price*',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Price',
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
              //CATERING DESCRIPTION
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    style: TextStyle(color: Colors.white),
                    controller: PhotodescriptionController,
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
                      debugPrint('$PhotodescriptionController');
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
                            // int status = await sdbHelper.checkPhotographyContact(int.parse(PhotocontactController.text));
                            // if (status == 0)
                            // {
                            //   //ALERT DIALOG FOR CONTACT AND ADDRESS BOTH
                            // }
                            // else if(status == 1)
                            // {

                           if(_formKey.currentState.validate())
                           {
                          //   int status = await sdbHelper.checkPhotographyContact(int.parse(PhotocontactController.text));
                          //   if (status == 0)
                          //   {
                          //     //ALERT DIALOG FOR CONTACT AND ADDRESS BOTH
                          //   }
                          //   else if(status == 1)
                          //   {

                              ////////////////////////////////////////////////////
                              photography photo = photography(PhotonameController.text, int.parse(PhotocontactController.text), int.parse(PhotopriceController.text), PhotodescriptionController.text, this.owner.owner_id);
                              ////////////////////////////////////////////////////
                              _insertphotography(photo);
                              int x = await _getId(photo.owner_id, photo.phone_no);

                              Get.to(AddImage(this.owner, x));
                            }
                            else
                            {
                              debugPrint("FAILURE IN CHECKING PHOTOGRAPHY'S UNIQUE CONSTRAINTS");
                            }

                        },


                      )))




            ],
          ),

        ));
  }

  void _insertphotography (photography ph) async
  {
    if(this.photo.isNull==false){
      sdbHelper.updatePhotographyService(ph);
    }
    else {
      await sdbHelper.insertPhotographyService(ph);
    }
  }

  Future<int> _getId (int ownerid, int cntctno) async
  {
    photography p = await sdbHelper.getPhotographyMapList1(ownerid, cntctno);
    return p.service_id;
  }
  Future<int> checkcontact () async{
    int status = await sdbHelper.checkPhotographyContact(int.parse(PhotocontactController.text));
    return status;

  }
}