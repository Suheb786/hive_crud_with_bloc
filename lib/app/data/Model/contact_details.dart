import 'package:hive/hive.dart';
part 'contact_details.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int phone;

  ContactModel(this.name, this.phone);
}
