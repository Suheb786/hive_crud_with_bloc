import 'package:hive/hive.dart';

part 'contact_details.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int phone;
  @HiveField(2)
  var email;
  @HiveField(3)
  var dateTime;

  ContactModel(
    this.name,
    this.phone,
    this.email,
    this.dateTime,
  );
}
