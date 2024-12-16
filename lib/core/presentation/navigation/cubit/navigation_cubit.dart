import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationTab { users, products }

class NavigationCubit extends Cubit<NavigationTab> {
  NavigationCubit() : super(NavigationTab.users);

  void setTab(NavigationTab tab) => emit(tab);
}
