import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_contacts_state.dart';

class AddContactsCubit extends Cubit<AddContactsState> {
  AddContactsCubit() : super(AddContactsInitial());
}
