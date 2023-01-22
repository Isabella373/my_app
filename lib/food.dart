import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Food {
  String? id;
  String? name;
  String? category;
  String? image;
  List subIngredients = [];


  Food();

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    subIngredients = data['subIngredients'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'subIngredients': subIngredients,
 
    };
  }
}