import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadihal/screens/VenueForm.dart';
import 'package:shadihal/Models/Owner.dart';
import 'package:shadihal/Utils/dbhelper.dart';
import 'package:shadihal/Models/Venue.dart';
import 'package:sqflite/sqflite.dart';
class OwnerVenueList extends StatefulWidget
{
  final Owner owner;


  OwnerVenueList(this.owner);

  @override
  State<StatefulWidget> createState() {
    return ownervenueliststate(this.owner);
  }

}
class ownervenueliststate extends State<OwnerVenueList>
{
  int count =0;
  dbHelper sdbhelper = dbHelper();
  Owner owner;
  List <Venue> vlist;
  ownervenueliststate(this.owner);


  @override
  Widget build(BuildContext context)
  {
    if (vlist == null)
    {
      vlist = List<Venue>();
      updateListView();
    }
   return Scaffold(
      appBar: AppBar(
        title: Text(this.owner.firstName+ ' '+'VENUES'),
      ),
      body: getVenueListView(),
       floatingActionButton: FloatingActionButton(
       onPressed: () {
     debugPrint('FAB clicked');
     Get.to(VenueForm(this.owner));
   },

    tooltip: 'Add Venue',
    backgroundColor: Colors.deepPurple,

  child: Icon(Icons.add_business_rounded),

    )
   );

}

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, Venue venue ) async {

    int result = await sdbhelper.deleteVenue(venue.venue_id);
    if (result != 0) {
      _showSnackBar(context, 'venue Deleted Successfully');
    }
  }
  void updateListView() {

    final Future<Database> dbFuture = sdbhelper.initDb();
    dbFuture.then((database) {

      //Future<List<Not>> noteListFuture = sdbHelper.getNoteList();
      Future<List<Venue>> l1 = sdbhelper.getVenueList(this.owner.owner_id);
      l1.then((vList) {
        setState(() {
          this.vlist = vList;
          this.count = vList.length;
        });
      });
    });
  }
  void navigateToDetail(Owner owner,Venue venue) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VenueForm(owner,venue);
    }));

    if (result == true) {
      updateListView();
    }
  }
  ListView getVenueListView() {


    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              child: Image(image: AssetImage("assets/fb.png")),
            ),

            title: Text(this.vlist[position].venue_name),

            subtitle: Text(this.vlist[position].pricelb.toString()),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, this.vlist[position]);
                updateListView();
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.owner,this.vlist[position]);
            },

          ),
        );
      },
    );
  }

}
// ListView.builder(
// itemCount: count,
// itemBuilder: (BuildContext context, int position) {
// return Card(
// color: Colors.white,
// elevation: 2.0,
// child: ListTile(
//
// leading: CircleAvatar(
// backgroundColor: Colors.white,
// child: Image(image: AssetImage("assets/fb.png")),
// ),
//
// title: Text(this.venue[position].venue_name),
//
// subtitle: Text(this.venue[position].pricelb.toString()),
//
// trailing: GestureDetector(
// child: Icon(Icons.delete, color: Colors.grey,),
// onTap: () {
// _delete(context, venue[position]);
// },
// ),
// onTap: () {
// debugPrint("ListTile Tapped");
// Get.to(VenueForm(this.owner, this.venue[position]));
//
//
// },
//
// ),
//
//
// );
// }
//
//
// ),