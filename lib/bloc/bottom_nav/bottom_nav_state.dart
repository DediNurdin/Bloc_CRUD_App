part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  final int selectedIndex;

  const BottomNavState({this.selectedIndex = 0});

  @override
  List<Object> get props => [selectedIndex];
}
