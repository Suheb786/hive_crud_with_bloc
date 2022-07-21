import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/data/Model/contact_details.dart';
import 'app/data/constants/theme.dart';
import 'app/module/home/cubit/home_cubit.dart';
import 'app/module/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  var box = await Hive.openBox<ContactModel>("ContactBox");
  runApp(MaterialApp(
    theme: Themes(),
    title: "Contacts",
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => HomeCubit(),
      child: HomeView(),
    ),
  ));
}
