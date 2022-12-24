
import 'package:flutter/material.dart';
import 'package:my_app/add_new_trip.dart';
import 'package:my_app/record_history.dart';


class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  _ProfileScreenState createState() => _ProfileScreenState(); 
}

class _ProfileScreenState extends State<ProfileScreen>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
floatingActionButton: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton.extended(
        label: Text("Add New Trip"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> const AddNewTrip()),
          );
        },
        heroTag: 'Add New Trip'
        
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