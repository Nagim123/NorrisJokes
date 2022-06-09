import 'package:flutter/material.dart';
import 'main_page.dart';
import 'favourites_page.dart';

class FlexiblePages extends StatefulWidget {

  const FlexiblePages({Key? key}) : super(key: key);

  @override
  State<FlexiblePages> createState() => _FlexiblePages();
}

class _FlexiblePages extends State<FlexiblePages> {
  int _selectedIndex = 0;

  final AppBar _commonAppBar = AppBar(title: const Text("Chuck Norris Jokes", style: const TextStyle(color: Colors.white),));

  final List<Widget> _widgetOptions = [
    MainPage(),
    FavouritesPage(),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _commonAppBar,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favourites"
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onTapped,
      ),
    );
  }
  
}