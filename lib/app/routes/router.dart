import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/bloc/add_contact_bloc.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/views/add_contact_view.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/views/update_contact_view.dart';
import 'package:hive_crud_with_bloc/app/module/home/home_view.dart';

import '../data/Model/contact_details.dart';

class AppRouter {
  //* Routes constants ----------------->>>>>>>>>>>
  static const String HOME = "/";
  static const String ADD_CONTACT = "/addContact";
  static const String UPDATE_CONTACT = "/updateContact";

  final AddContactBloc _addContactBloc = AddContactBloc();

  Route<dynamic> onGeneratedRouted(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case ADD_CONTACT:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: AddContactBloc(),
                  child: const AddContactView(),
                ));

      case UPDATE_CONTACT:
        final argmnt = routeSettings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addContactBloc,
                  child: UpdateContact(
                    keyValue: argmnt,
                  ),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child:
                          Text('No route defined for ${routeSettings.name}')),
                ));
    }
  }

  void dispose() {
    _addContactBloc.close();
  }
}
