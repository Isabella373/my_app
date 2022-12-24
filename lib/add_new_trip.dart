import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/profile_screen.dart';
import 'package:my_app/record_history.dart';

class AddNewTrip extends StatefulWidget{
  const AddNewTrip({Key? key}) : super(key: key);

  @override
  _AddNewTripState createState() => _AddNewTripState(); 
}

class _AddNewTripState extends State<AddNewTrip>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     floatingActionButton: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton.extended(
        label: Text("Back to Profile"),
        icon: Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> const ProfileScreen()),
          );
        },
        heroTag: 'Profile'
        
      ),
      SizedBox(
        width: 10,
      ),
      FloatingActionButton.extended(           
        label: Text("Record History"),
        icon: Icon(Icons.navigation),
        onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> const RecordHistory()),
          );
        },
        heroTag: 'Record History'
      )
    ]
  )

    );
  }
}