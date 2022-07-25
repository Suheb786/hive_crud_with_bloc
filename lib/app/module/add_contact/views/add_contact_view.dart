import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/Model/contact_details.dart';
import '../../../data/constants/colors.dart';
import '../../../data/widgets/customTextFormField.dart';
import '../../../data/widgets/saveButton.dart';
import '../bloc/add_contact_bloc.dart';

class AddContactView extends StatefulWidget {
  const AddContactView({Key? key}) : super(key: key);

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

late Box<ContactModel> contactBox;

class _AddContactViewState extends State<AddContactView> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileNOCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  late final names = nameCtrl.text;
  late final phones = mobileNOCtrl.text;
  late final extraValue = emailCtrl.text;
  late final dateTime = DateTime.now();

  @override
  void initState() {
    contactBox = Hive.box("ContactBox");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_GREEN,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Expanded(
                      child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: LIGHT_GREEN,
                        radius: 70,
                        child: Icon(
                          Icons.person,
                          color: DARK_GREEN,
                          size: 80,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: () {
                            ImagePicker();
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: DARK_BLUE,
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: LIGHT_GREEN),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          BlocBuilder<AddContactBloc, AddContactState>(
                            builder: (context, state) {
                              if (state is AddContactError) {
                                return Center(
                                  child: Container(
                                    color: Colors.red,
                                    child: Text(state.errorMsg),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: nameCtrl,
                            onChanged: ((change) {
                              BlocProvider.of<AddContactBloc>(context).add(
                                  TextChangedEvent(nameCtrl.text,
                                      mobileNOCtrl.text, emailCtrl.text));
                            }),
                            hintText: "Name",
                            fillColor: DARK_GREEN,
                          ),
                          CustomTextField(
                            controller: mobileNOCtrl,
                            onChanged: ((change) {
                              BlocProvider.of<AddContactBloc>(context).add(
                                  TextChangedEvent(nameCtrl.text,
                                      mobileNOCtrl.text, emailCtrl.text));
                            }),
                            hintText: "Mobile No.",
                            keyboardType: TextInputType.number,
                            fillColor: DARK_GREEN,
                          ),
                          CustomTextField(
                            controller: emailCtrl,
                            onChanged: ((change) {
                              BlocProvider.of<AddContactBloc>(context).add(
                                  TextChangedEvent(nameCtrl.text,
                                      mobileNOCtrl.text, emailCtrl.text));
                            }),
                            hintText: "Email",
                            fillColor: DARK_GREEN,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LIGHT_GREEN),
                          child: Center(
                            child: Text("CANCLE",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: GREEN_TEXT,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: BlocBuilder<AddContactBloc, AddContactState>(
                        builder: (context, state) {
                          return (state is AddContactValid)
                              ? SaveButton(
                                  context: context,
                                  color: DARK_BLUE,
                                  fontColor: Colors.white,
                                  onTap: () {
                                    ContactModel modelvalue = ContactModel(
                                        names,
                                        int.parse(phones),
                                        extraValue,
                                        dateTime);
                                    // contactBox.add(modelvalue);
                                    contactBox.put(modelvalue.name, modelvalue);
                                    Navigator.pop(context);
                                  })
                              : SaveButton(
                                  context: context,
                                  color: Colors.grey.shade900,
                                  fontColor: Colors.grey);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
