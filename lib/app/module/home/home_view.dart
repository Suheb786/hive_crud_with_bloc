import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/add_contact/add_contact_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/constants/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

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
            title: Center(child: Text("Contacts"))),
        backgroundColor: DARK_GREEN,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Expanded(
              //     child: ValueListenableBuilder<Box>(
              //         valueListenable: contactBox.listenable(),
              //         builder: (context, box, contacts) {
              //           return ListView.separated(
              //               itemBuilder: ((context, index) {
              //                 final key = contactBox.keys.toList()[index];
              //                 final value = contactBox.get(key);
              //                 return ListTile(
              //                   leading: CircleAvatar(
              //                     backgroundColor: LIGHT_GREEN,
              //                     child: Text("${key[0]}"),
              //                   ),
              //                   trailing: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       InkWell(
              //                         // onTap: () =>
              //                         //     Get.toNamed(Routes.UPDATE_CONTATC),
              //                         child: Container(
              //                           decoration: BoxDecoration(
              //                               color: LIGHT_GREEN,
              //                               borderRadius:
              //                                   BorderRadius.circular(5)),
              //                           padding: EdgeInsets.all(10),
              //                           child: Icon(
              //                             Icons.edit,
              //                             color: Colors.white70,
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 15,
              //                       ),
              //                       InkWell(
              //                         // onTap: () => contactBox.delete(key),
              //                         child: Container(
              //                           decoration: BoxDecoration(
              //                               color: LIGHT_GREEN,
              //                               borderRadius:
              //                                   BorderRadius.circular(5)),
              //                           padding: EdgeInsets.all(10),
              //                           child: Icon(
              //                             Icons.delete,
              //                             color: Colors.red,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   title: Text("$key",
              //                       style: GoogleFonts.montserrat(
              //                           fontSize: 18,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.bold)),
              //                   subtitle: Text("$value",
              //                       style: GoogleFonts.montserrat(
              //                           fontSize: 18,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.bold)),
              //                 );
              //               }),
              //               separatorBuilder: ((context, index) {
              //                 return Divider(
              //                   color: LIGHT_GREEN,
              //                 );
              //               }),
              //               itemCount: 2
              //               //  contactBox.keys.toList().length
              //               );
              //         })),

              SizedBox(
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
