import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigation/cubit/navigation_cubit.dart';
import '../../../features/users/presentation/pages/users_page.dart';
import '../../../features/products/presentation/pages/products_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationTab>(
        builder: (context, tab) {
          switch (tab) {
            case NavigationTab.users:
              return const UsersPage();
            case NavigationTab.products:
              return const ProductsPage();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationTab>(
        builder: (context, tab) {
          return BottomNavigationBar(
            currentIndex: tab.index,
            onTap: (index) => context
                .read<NavigationCubit>()
                .setTab(NavigationTab.values[index]),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'المستخدمين',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'المنتجات',
              ),
            ],
          );
        },
      ),
    );
  }
}
