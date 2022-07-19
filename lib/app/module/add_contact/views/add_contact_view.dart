import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/data/constants/colors.dart';
import 'package:hive_crud_with_bloc/app/data/widgets/customTextFormField.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/bloc/add_contact_bloc.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

late Box<ContactModel> contactBox;

class _AddContactState extends State<AddContact> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileNOCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  late final key = nameCtrl.text;
  late final value = mobileNOCtrl.text;

  @override
  void initState() {
    contactBox = Hive.box("ContactBox");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_GREEN,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                // flex: 10,
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
                                  padding: EdgeInsets.all(10),
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                        SizedBox(
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
              SizedBox(
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // context.read<AddContactBloc>().check_and_save();
                        ContactModel modelvalue =
                            ContactModel(key, int.parse(value));
                        contactBox.add(modelvalue);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: DARK_BLUE),
                        child: Center(
                          child: Text("SAVE",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
