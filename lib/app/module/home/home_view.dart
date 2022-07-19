import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/views/add_contact_view.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/views/update_contact_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/constants/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

String? nullText; //! in case of email is shows null

class _HomeViewState extends State<HomeView> {
  late Box<ContactModel> contactBox;

  @override
  void initState() {
    contactBox = Hive.box("ContactBox");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: LIGHT_GREEN,
            title: Center(child: Text("Hive CRUD with Bloc on CONTACTS"))),
        backgroundColor: DARK_GREEN,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: contactBox.listenable(),
                  builder: ((context, Box<ContactModel> contacts, _) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          final key = contactBox.keys.toList()[index];

                          final ContactModel? modelContact =
                              contactBox.get(key);
                          return ListTile(
                            title: Text(modelContact!.name,
                                style: TextStyle(color: Colors.white)),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${modelContact.phone}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                // if (nullText != null)
                                Text(
                                  "  ${modelContact.email}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            dense: false,
                            leading: CircleAvatar(
                              backgroundColor: LIGHT_GREEN,
                              child: Text(modelContact.name[0]),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return UpdateContact(
                                        // index: index,
                                        // key: key,
                                        keyID: key,
                                      );
                                    }));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: LIGHT_GREEN,
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            backgroundColor: LIGHT_GREEN,
                                            title: Text(
                                              "Confirmation to delete ",
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            content: Text(
                                              "You desire to delete ${modelContact.name} from your Contacts",
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white54),
                                                      )),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        contactBox.delete(key);
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[700]),
                                                      ))
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: LIGHT_GREEN,
                                    radius: 20,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[700],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: ((context, index) {
                          return Divider(
                            color: LIGHT_GREEN,
                          );
                        }),
                        itemCount: contactBox.keys.toList().length);
                  }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddContact()));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: LIGHT_GREEN),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.edit,
                          color: GREEN_TEXT,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("ADD NEW CONTACT",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: GREEN_TEXT,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
