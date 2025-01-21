part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class SelectTabEvent extends BottomNavEvent {
  final int selectedIndex;

  const SelectTabEvent(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
