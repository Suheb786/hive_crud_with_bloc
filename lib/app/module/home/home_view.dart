import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/Model/contact_details.dart';
import '../../routes/router.dart';
import '../add_contact/bloc/add_contact_bloc.dart';
import '../add_contact/views/add_contact_view.dart';
import '../add_contact/views/update_contact_view.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

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
    // contactBox.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: LIGHT_GREEN,
            title:
                const Center(child: Text("Hive CRUD with Bloc on CONTACTS"))),
        backgroundColor: DARK_GREEN,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return (state == HomeState.Filled)
                        ? const Icon(
                            Icons.contact_mail,
                            color: LIGHT_GREEN,
                            size: 50,
                          )
                        : ValueListenableBuilder(
                            valueListenable: contactBox.listenable(),
                            builder: ((context, Box<ContactModel> contacts, _) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    // final key = contactBox.keys.toList(); //? also can be used with key but sorting might now work
//* Hive  is Iterable Database from here it's been sorted by Name -------------->>>>>
                                    final keyValue = contactBox.values.toList();
                                    keyValue.sort((a, b) {
                                      return a.name
                                          .toString()
                                          .toLowerCase()
                                          .compareTo(
                                              b.name.toString().toLowerCase());
                                    });
                                    // log(key.toString());

                                    final ContactModel modelContact =
                                        keyValue[index];
                                    return ListTile(
                                      title: Text("${modelContact.name}",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      subtitle: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${modelContact.phone}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            // if (nullText != null)
                                            Text(
                                              "${modelContact.email}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
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
                                              Navigator.pushNamed(context,
                                                  AppRouter.UPDATE_CONTACT , arguments:  modelContact.name);

                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (ctx) {
                                              //   return BlocProvider(
                                              //     create: (context) =>
                                              //         AddContactBloc(),
                                              //     child: UpdateContact(
                                              //       // index: index,
                                              //       // key: key,
                                              //       keyValue: modelContact.name,
                                              //     ),
                                              //   );
                                              // }));
                                            },
                                            child: const CircleAvatar(
                                              radius: 20,
                                              backgroundColor: LIGHT_GREEN,
                                              child: Icon(Icons.edit),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          LIGHT_GREEN,
                                                      title: const Text(
                                                        "Confirmation to delete ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                      content: Text(
                                                        "You desire to delete ${modelContact.name} from your Contacts",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white54),
                                                                )),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  contactBox.delete(
                                                                      modelContact
                                                                          .name);
                                                                },
                                                                child: Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          700]),
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
                                    return const Divider(
                                      color: LIGHT_GREEN,
                                    );
                                  }),
                                  itemCount: contactBox.keys.toList().length);
                            }),
                          );
                  },
                )),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.ADD_CONTACT);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: LIGHT_GREEN),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.edit,
                            color: GREEN_TEXT,
                          ),
                          const SizedBox(
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
          ),
        ));
  }
}
