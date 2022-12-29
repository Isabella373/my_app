import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/profile_screen.dart';
import 'package:my_app/record_history.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';




class AddNewTrip extends StatefulWidget{
  const AddNewTrip({Key? key}) : super(key: key);

  @override
  _AddNewTripState createState() => _AddNewTripState(); 
}

class _AddNewTripState extends State<AddNewTrip>{
 
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      File file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
        .child('images/imageName')
        .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          var imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
  
  String imageUrl = "https://i.imgur.com/sUFH1Aq.png";
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Upload Evidence', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        centerTitle:true,
        elevation:0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(  
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: (imageUrl != null)
                ? Image.network(imageUrl)
                : Image.network('https://i.imgur.com/sUFH1Aq.png')
            ),
            SizedBox(height: 20.0,),
   FloatingActionButton.extended(
  label: Text("Upload Image", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20)),
  onPressed: (){
    uploadImage();
  },
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
    side: BorderSide(color: Colors.blue)
  ),
  elevation: 5.0,
  splashColor: Colors.grey,
),
          ],
        ),
      ),
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