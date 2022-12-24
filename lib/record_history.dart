import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/add_new_trip.dart';
import 'package:my_app/profile_screen.dart';

class RecordHistory extends StatefulWidget{
  const RecordHistory({Key? key}) : super(key: key);

  @override
  _RecordHistoryState createState() => _RecordHistoryState(); 
}

class _RecordHistoryState extends State<RecordHistory>{
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
        label: Text("Add New Trip"),
        icon: Icon(Icons.add),
        onPressed: (){
         Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> const AddNewTrip()),
          );
        },
        heroTag: 'Add New Trip'
      )
    ]
  )

    );
  }
}