import 'package:flutter/material.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Models/Photo.dart';
import 'package:shadihal/Utils/imgutility.dart';
import 'package:shadihal/screens/OwnerProfile.dart';
import 'package:shadihal/screens/OwnerVenuelist.dart';
import 'package:get/get.dart';
import 'dart:async';

class AddImage extends StatefulWidget
{
  final Owner owner;
  int ser_id;
  int cid;

  AddImage(this.owner,this.ser_id, [this.cid]);

  @override
  AddImageState createState()
  {
    debugPrint("TESTPOINT 1");
    debugPrint(this.cid.runtimeType.toString());
    return AddImageState(this.owner,this.ser_id, this.cid);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddImageState extends State<AddImage>
{
  int ser_id;
  Future<File> imageFile;
  Image image;

  dbHelper sdbHelper;
  List<Photo> images;
  List<Photo> images1;
  Owner owner;
  int cid;


  AddImageState(this.owner , this.ser_id, [this.cid]);

  @override
  void initState()
  {

    super.initState();
    images = [];
    sdbHelper = dbHelper();
    refreshImages(this.owner.owner_id, this.ser_id, this.cid);
    List<Image> img1= images.map((photo)
    {
      return Utility.imageFromBase64String(photo.photo_name);
    }).toList();
  }

  refreshImages(int ownerid, int serviceid, [int cid])
  {
    sdbHelper.getPhotos(ownerid, serviceid, cid).then((imgs)
    {
      setState(()
      {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery(int cid)
  {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile)
    {
      String imgString = Utility.base64String( imgFile.readAsBytesSync() );
      Photo photo = Photo(imgString, ser_id, this.owner.owner_id, cid);
      sdbHelper.save(photo);
      refreshImages(photo.owner_id, photo.service_id, photo.c_id);
    });
  }

  gridView()
  {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo)
        {
          return Utility.imageFromBase64String(photo.photo_name);
        }).toList(),
        ),
        );
  }

  @override
  Widget build(BuildContext context)
  {
    debugPrint("TESTPOINT 2");
    debugPrint(this.cid.runtimeType.toString());
    return Scaffold(
        appBar: AppBar(
            title: Text("Add Image"),
            actions: <Widget>
            [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: ()
                  {
                    pickImageFromGallery(this.cid);
                  },
              )
            ],
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: gridView(),
                ),
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

                          onPressed: ()
                          {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },


                        )))


              ],
            ),
        ),
      );
    }

    Future<List<Image>> getServiceImages (int ownerid, int serviceid) async
    {
      List<Photo> serimage = await sdbHelper.getPhotos(ownerid, serviceid);
      List<Image> img1 = images1.map((serimage)
      {
        return Utility.imageFromBase64String(serimage.photo_name);
      }).toList();
      //List<Image> abc = images1;
      return img1;
    }
  }