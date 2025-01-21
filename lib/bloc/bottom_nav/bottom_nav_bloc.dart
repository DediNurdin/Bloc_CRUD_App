import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<SelectTabEvent>((event, emit) {
      emit(BottomNavState(selectedIndex: event.selectedIndex));
    });
  }
}
