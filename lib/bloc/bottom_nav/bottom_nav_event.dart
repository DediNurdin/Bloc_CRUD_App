part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent {}

class TabChange extends BottomNavEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
