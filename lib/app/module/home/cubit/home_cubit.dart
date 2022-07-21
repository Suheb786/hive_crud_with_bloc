import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../data/Model/contact_details.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late Box<ContactModel> contactBox;

  HomeCubit() : super(HomeState.Intial);

  void checkList() {
    if (contactBox.keys.isEmpty) {
      emit(HomeState.Empty);
    } else {
      emit(HomeState.Filled);
    }
  }
}
