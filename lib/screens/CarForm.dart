import 'package:flutter/material.dart';
import 'package:shadihal/Models/car.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../Utils/dbhelper.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:get/get.dart';
import 'AddImage.dart';


class CarForm extends StatefulWidget
{
  int serviceid;
  final Owner owner;

  CarForm(this.serviceid, this.owner);

  @override
  CarFormState createState()
  {
    return CarFormState(this.serviceid, this.owner);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CarFormState extends State<CarForm>
{
  List<Asset> images = List<Asset>();
  List<car> carList = List<car>();
  int sid;
  Owner owner;

  dbHelper sdbHelper = dbHelper();
  String _regnoerror;

  CarFormState(this.sid, this.owner);

  void initState()
  {
    super.initState();
  }

  // Future<void> pickImages() async
  // {
  //   List<Asset> resultList = List<Asset>();
  //
  //   try
  //   {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 5,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       materialOptions: MaterialOptions(
  //         actionBarTitle: "Add images",
  //       ),
  //     );
  //   } on Exception catch (e)
  //   {
  //     print(e);
  //   }
  //
  //   setState(()
  //   {
  //     images = resultList;
  //   });
  // }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String seatdropdownValue = '4';
  String fueldropdownValue = 'Gasoline';
  String transmissiondropdownValue = 'Manual';
  TextEditingController CarnameController = TextEditingController();
  TextEditingController CarmodelController = TextEditingController();
  TextEditingController CarNumberController = TextEditingController();
  TextEditingController CarseatController = TextEditingController();
  TextEditingController CarmileageController = TextEditingController();
  TextEditingController CarcolorController = TextEditingController();
  TextEditingController CarrentController = TextEditingController();
  TextEditingController CarfuelController = TextEditingController();
  TextEditingController CartransmissionController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    // Build a Form widget using the _formKey created above.
    debugPrint("Testing Point");
    debugPrint(this.sid.toString());

    return  Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("ADD CAR"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>
            [
              //CAR NAME
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CarnameController,
                    decoration: InputDecoration(
                        labelText: 'Car Name *',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Car Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CarnameController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }
                      if(value=="Car")
                      {
                        return 'This Car already exist';
                      }
                      if(value.length>20)
                      {
                        return 'Car name should be less than 20';
                      }
                      return null;
                    },


                  )),
              //CAR MODEL
              TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: CarmodelController,
                decoration: InputDecoration(
                    labelText: 'Model *',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'For e.g 2008',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )

                ),
                onChanged: (text)
                {
                  debugPrint(CarmodelController.text);
                },
                validator: (value)
                {
                  if (value.isEmpty)
                  {
                    return 'This Field is Required ';
                  }

                  if (value.length!=4)
                  {
                    return 'Model should 4-digit';
                  }
                  return null;
                },
              ),

              //REGISTRATION NUMBER
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CarNumberController,
                    decoration: InputDecoration(
                        labelText: 'Registration Number *',
                        hintText: 'e.g ABC-123',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _regnoerror,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CarNumberController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }
                      if (value.length > 7)
                      {
                        return 'INAVLID FORMAT';
                      }
                      return null;
                    },


                  )),

              //SEATS
              Padding(
                  padding: EdgeInsets.only(top:20.0,left:10,right: 180),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Expanded(
                          child: Text('Seats *', textAlign: TextAlign.start,style: TextStyle(fontSize: 20.0,color: Colors.white)),),
                        Expanded(
                            child: DropdownButton<String>(
                              value: seatdropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple,fontSize: 20.0),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue)
                              {
                                setState(()
                                {
                                  seatdropdownValue = newValue;
                                });
                                CarseatController.text= seatdropdownValue;
                                debugPrint('$CarseatController');
                              },
                              items: <String>['2', '4', '7']
                                  .map<DropdownMenuItem<String>>((String value)
                              {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ))])),

              //MILEAGE
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    onTap: () async{
                      int xstatus = await checkregno();
                      setState(() {

                        if( xstatus == 0)
                        {
                          debugPrint("Contact mojoud he");
                          _regnoerror= "This Contact Number Already exist";
                        }
                        else
                        {
                          _regnoerror= null;
                        }

                      });
                    },
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: CarmileageController,
                    decoration: InputDecoration(
                        labelText: 'Mileage *',
                        hintText: 'enter Car Mileage',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CarmileageController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }
                      return null;
                    },


                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: CarcolorController,
                    decoration: InputDecoration(
                        labelText: 'Color *',
                        hintText: 'For e.g. Red',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CarcolorController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }

                      return null;
                    },


                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom:10.0),

                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: CarrentController,
                    decoration: InputDecoration(
                        labelText: 'Rent *',
                        hintText: 'Enter per day rent',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )

                    ),
                    onChanged: (text)
                    {
                      debugPrint('$CarrentController');
                    },
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'This Field is Required ';
                      }
                      return null;
                    },


                  )),
              Expanded(child:Padding(
                  padding: EdgeInsets.only(top:20.0,left:10,right: 180),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Expanded(
                          child: Text('Type *', textAlign: TextAlign.start,style: TextStyle(fontSize: 20.0,color: Colors.white)),),
                        Expanded(
                            child: DropdownButton<String>(
                              value: fueldropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple,fontSize: 20.0),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue)
                              {
                                setState(()
                                {
                                  fueldropdownValue = newValue;
                                });
                                CarfuelController.text= fueldropdownValue;
                                debugPrint('$CarfuelController');
                              },
                              items: <String>['Gasoline', 'CNG', 'Diesel','Electric']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ))]))),


              Padding(
                  padding: EdgeInsets.only(top:20.0,bottom:20,left:10,right: 110),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Expanded(
                          child: Text('Transmission *', textAlign: TextAlign.start,style: TextStyle(fontSize: 20.0,color: Colors.white)),),
                        Expanded(
                            child: DropdownButton<String>(
                              value: transmissiondropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple,fontSize: 20.0),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue)
                              {
                                setState(()
                                {
                                  transmissiondropdownValue = newValue;
                                });
                                CartransmissionController.text= transmissiondropdownValue;
                                debugPrint('$CartransmissionController');
                              },
                              items: <String>['Automatic','Manual']
                                  .map<DropdownMenuItem<String>>((String value)
                              {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ))])),

              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children:<Widget>[
              //       OutlinedButton(
              //         style: OutlinedButton.styleFrom(backgroundColor: Colors.deepPurple),
              //         child: Text("Add Images", style: TextStyle(fontSize: 20.0,color: Colors.white)),
              //
              //         onPressed: ()
              //         {
              //           //pickImages();
              //         },
              //       )]),
              // SizedBox(
              //     height: 200.0,
              //     child: GridView.count(
              //       crossAxisCount: 3,
              //       children: List.generate(images.length, (index)
              //       {
              //         Asset asset = images[index];
              //         return AssetThumb(
              //           asset: asset,
              //           width: 300,
              //           height: 300,
              //         );
              //       }),
              //     )),

              Padding(
                  padding: EdgeInsets.only(top:20.0,left: 120.00,right: 120.00),
                  child: Builder(
                      builder:(context) => RaisedButton(
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
                            // int status = await sdbHelper.checkCarRegno(CarNumberController.text);
                            // if (status == 0)
                            // {
                            //   //ALERT DIALOG FOR CAR REG NO
                            // }
                            // else if (status == 1)
                            // {
                              ////////////////////////////////////////////////////
                              car c1 = car(CarnameController.text,
                                  CarmodelController.text,
                                  CarNumberController.text,
                                  int.parse(CarseatController.text),
                                  double.parse(CarmileageController.text),
                                  CarcolorController.text,
                                  int.parse(CarrentController.text),
                                  CarfuelController.text,
                                  CartransmissionController.text,
                                  this.sid);
                              ////////////////////////////////////////////////////

                              debugPrint("TESTING POINT 2");
                              debugPrint(c1.service_id.toString());
                              _insertcar (c1);
                              int x = await _getId (c1.service_id, c1.reg_no);
                              debugPrint("TESTING POINT 3");
                              debugPrint(x.toString());
                              Navigator.pop(context);
                              //Get.to(AddImage(this.owner, this.sid, x));
                            }
                            else
                            {
                              debugPrint("FAILURE IN CHECKING RENT A CAR'S UNIQUE CONSTRAINTS");
                            }

                        },


                      )))




            ],
          ),

        ));
  }

  void _insertcar (car c) async
  {
    await sdbHelper.insertCar(c);
  }

  Future<int> _getId (int servid, String regno) async
  {
    car cr = await sdbHelper.getCarMapList1(servid, regno);
    return cr.service_id;
  }
  Future<int> checkregno () async{
    int status = await sdbHelper.checkCarRegno(CarNumberController.text);
    return status;

  }
}