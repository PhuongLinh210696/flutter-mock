import 'package:flutter/material.dart';
import 'package:myapp/Mock/SQLHelper/mynote_app.dart';
//import 'package:myapp/Day4/extra_task.dart';
//import 'package:myapp/Day5/item_screen.dart';
//import 'package:myapp/Mock/province_screen.dart';
//import 'package:myapp/Day1/my_app.dart';
//import 'package:myapp/Day1/pavlova_recipe.dart';
//import 'package:myapp/Day2/product_widget.dart';
//import 'package:myapp/Day2/profile.dart';
//import 'package:myapp/Day3/favorite_app.dart';
//import 'package:myapp/Day3/navigation_bar.dart';
//import 'package:myapp/Day4/form.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MynoteApp());
}


