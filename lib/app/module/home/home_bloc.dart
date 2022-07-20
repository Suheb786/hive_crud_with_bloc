// import 'package:bloc/bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
// import 'package:meta/meta.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   late Box<ContactModel> contactBox;
//   HomeBloc() : super(HomeInitial()) {
//     on<HomeList>((event, emit) {
//       if (contactBox.isEmpty) {
//         emit(HomeEmpty());
//       } else {
//         emit(HomeFilled());
//       }
//     });
//   }
// }
