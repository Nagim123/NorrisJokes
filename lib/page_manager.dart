import 'package:flutter/material.dart';
import 'main_page.dart';
import 'favourites_page.dart';
import 'filter.dart';
import 'save_mode.dart';

///Widget to manage all pages
class FlexiblePages extends StatefulWidget {
  const FlexiblePages({Key? key}) : super(key: key);

  @override
  State<FlexiblePages> createState() => _FlexiblePages();
}

class _FlexiblePages extends State<FlexiblePages> {
  int _selectedIndex = 0;

  //List of available pages
  final List<Widget> _widgetOptions = [
    const MainPage(),
    const FavouritesPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? buildFilterAppBar(context)
          : buildSaveModesAppBar(),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourites")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onTap,
      ),
    );
  }
}
