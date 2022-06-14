import 'package:flutter/material.dart';
import 'filter_popup.dart';

//Global filtered categories selected by user
List<String> filteredCategories = [];

///Builds app bar with filter button
AppBar buildFilterAppBar(BuildContext context) {
  return AppBar(
      title: const Text("Chuck Norris Jokes",
          style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FilterPopup(
                  globalCategories: filteredCategories,
                );
              }));
            },
            icon: const Icon(Icons.filter_alt))
      ]);
}
