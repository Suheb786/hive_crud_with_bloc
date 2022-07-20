import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late Box<ContactModel> contactBox;

  HomeCubit() : super(HomeState.Intial);

  void checkList() {
    if (contactBox.isNotEmpty) {
      emit(HomeState.Empty);
    } else {
      emit(HomeState.Filled);
    }
  }
}
