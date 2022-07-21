import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../../../data/Model/contact_details.dart';
import '../../../data/constants/colors.dart';
import '../../../data/widgets/customTextFormField.dart';
import '../../../data/widgets/saveButton.dart';
import '../bloc/add_contact_bloc.dart';
import '../../home/home_view.dart';




class UpdateContact extends StatefulWidget {
  String keyValue;
  UpdateContact({
    Key? key,
    required this.keyValue,
  }) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

late Box<ContactModel> contactBox;
Null _isNull;

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileNOCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  late final names = nameCtrl.text;
  late final phones = mobileNOCtrl.text;
  late final extraValue = emailCtrl.text;

  @override
  void initState() {
    contactBox = Hive.box("ContactBox");
    // Future.delayed(Duration(seconds: 3));
    log(widget.keyValue.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ContactModel? modelContact = contactBox.get(widget.keyValue);
    if (modelContact != null) {
      nameCtrl.text = modelContact.name;
      mobileNOCtrl.text = modelContact.phone.toString();
    }
    if (modelContact!.email == null) {
      nameCtrl.text = "";
    } else if (modelContact.email != null) {
      emailCtrl.text = modelContact.email;
    }

    return Scaffold(
        backgroundColor: DARK_GREEN,
        body: SafeArea(
          child: Padding(
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
                                  text: "UPDATE",
                                  fontColor: Colors.white,
                                  onTap: () {
                                    ContactModel modelvalue = ContactModel(
                                        names, int.parse(phones), extraValue);
                                    contactBox.put(widget.keyValue, modelvalue);

                                    Navigator.pop(context);
                                  })
                              : SaveButton(
                                  text: "UPDATE",
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
