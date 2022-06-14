import 'package:flutter/material.dart';
import 'api_interactions.dart';

///Widget that shows filter options
class FilterPopup extends StatefulWidget {
  final List<String> globalCategories;

  const FilterPopup({Key? key, required this.globalCategories})
      : super(key: key);

  @override
  State<FilterPopup> createState() => _FilterPopup();
}

///State controll of FilterPopup widget
class _FilterPopup extends State<FilterPopup> {
  //Categories that are not filtered by user
  late List<String> _globalCategories;

  @override
  void initState() {
    super.initState();
    _globalCategories = super.widget.globalCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Chuck Norris Jokes",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
            child: SafeArea(
                child: FutureBuilder<List<String>>(
          future: loadCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(snapshot.data![index],
                          style: const TextStyle(fontSize: 20)),
                      trailing:
                          _globalCategories.contains(snapshot.data![index])
                              ? const Icon(Icons.check_box_outlined)
                              : const Icon(Icons.check_box_outline_blank),
                    ),
                    onTap: () {
                      //Remove or add catergory to _globalCategories
                      if (_globalCategories.contains(snapshot.data![index])) {
                        _globalCategories.remove(snapshot.data![index]);
                      } else {
                        _globalCategories.add(snapshot.data![index]);
                      }
                      setState(() {});
                    },
                    //To make filter more user friendly, I add long press feature!
                    onLongPress: () {
                      if (_globalCategories.contains(snapshot.data![index])) {
                        _globalCategories.clear();
                        _globalCategories.add(snapshot.data![index]);
                      } else {
                        _globalCategories.clear();
                        for (var category in snapshot.data!) {
                          _globalCategories.add(category);
                        }
                        _globalCategories.remove(snapshot.data![index]);
                      }
                      setState(() {});
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ))));
  }
}
