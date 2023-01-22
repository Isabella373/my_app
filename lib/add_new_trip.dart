import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/food.dart';
import 'package:my_app/profile_screen.dart';
import 'package:my_app/record_history.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class AddNewTrip extends StatefulWidget{
  const AddNewTrip({Key? key}) : super(key: key);

  @override
  _AddNewTripState createState() => _AddNewTripState(); 
}

class _AddNewTripState extends State<AddNewTrip>{
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List _subingredients = [];
  Food _currentFood = Food();
  String _imageUrl = 'https://i.imgur.com/sUFH1Aq.png';
  File? _imageFile;
  TextEditingController subingredientController = new TextEditingController();


@override
void initState(){
  super.initState();
}


  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("image placeholder");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile!,
            fit: BoxFit.cover,
            height: 250,
          ),
          FloatingActionButton.extended(
            heroTag: "btn1",
            label: Text("Image"),
        icon: Icon(Icons.add_a_photo),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FloatingActionButton.extended(
            heroTag: "btn2",
            label: Text("Image"),
        icon: Icon(Icons.add_a_photo),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    ImagePicker _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isDenied){
      openAppSettings();
    }

    if (permissionStatus.isGranted){
      //Select Image
      
      XFile? image =
                         await _imagePicker.pickImage(source: ImageSource.gallery);
                    print('${image?.path}');
      if (image == null) return;
      File file = File(image.path);

      if (image != null){

        setState(() {

          _imageFile = file;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Name must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String? value) {
        _currentFood.name = value!;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Distance'),
      initialValue: _currentFood.category,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Distance is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Category must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String? value) {
        _currentFood.category = value!;
      },
    );
  }

  _buildSubingredientField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: subingredientController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Description'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _onFoodUploaded(Food food) {
    Navigator.pop(context);
  }

  _addSubingredient(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _subingredients.add(text);
      });
      subingredientController.clear();
    }
  }

  _saveFood() {
    print('saveFood Called');
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    print('form saved');

    _currentFood.subIngredients = _subingredients;

    //uploadFoodAndImage(_currentFood, widget.isUpdating, _imageFile, _onFoodUploaded);

    print("name: ${_currentFood.name}");
    print("category: ${_currentFood.category}");
    print("subingredients: ${_currentFood.subIngredients.toString()}");
    print("_imageFile ${_imageFile.toString()}");
    print("_imageUrl $_imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload Evidence', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        centerTitle:true,
        elevation:0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          //autovalidate: true,
          child: Column(children: <Widget>[
            _showImage(),
            SizedBox(height: 16),
       
            SizedBox(height: 16),
            _imageFile == null && _imageUrl == null
                ? ButtonTheme(
                    child: FloatingActionButton(
                      heroTag: "btn3",
                      onPressed: () => _getLocalImage(),
                      child: Text(
                        'Add Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : SizedBox(height: 0),
            _buildNameField(),
            _buildCategoryField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildSubingredientField(),
                ButtonTheme(
                  child: FloatingActionButton(
                    heroTag: "btn4",
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    onPressed: () => _addSubingredient(subingredientController.text),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: _subingredients
                  .map(
                    (ingredient) => Card(
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          ingredient,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ]),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
      FloatingActionButton.extended(
        heroTag: "btn5",
        label: Text("Submit"),
        icon: Icon(Icons.save),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _saveFood();
        },
        
      ),


      Row(
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
        ]


      
    )
    );
  }
}