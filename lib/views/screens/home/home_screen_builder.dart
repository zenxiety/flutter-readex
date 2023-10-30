import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/home_builder_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenBuilder extends StatefulWidget {
  const HomeScreenBuilder({super.key});

  @override
  State<HomeScreenBuilder> createState() => _HomeScreenBuilderState();
}

class _HomeScreenBuilderState extends State<HomeScreenBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeBuilderProvider>(
        builder: (context, state, _) {
          return IndexedStack(
            index: state.selectedIndex,
            children: state.screens,
          );
        },
      ),
      bottomNavigationBar: Consumer<HomeBuilderProvider>(
        builder: (context, state, _) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.black,
            elevation: 0,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.saved_search_rounded,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "",
              ),
            ],
            currentIndex: state.selectedIndex,
            onTap: state.selectScreen,
          );
        },
      ),
    );
  }
}
