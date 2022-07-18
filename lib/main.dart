import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/home/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  var box = await Hive.openBox<ContactModel>("ContactBox");
  runApp(const MaterialApp(
    title: "Contacts",
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}