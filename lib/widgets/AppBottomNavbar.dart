import 'package:flutter/material.dart';
import 'package:notecraft/views/notes.dart';
import 'package:notecraft/views/todos_list.dart';

class AppBottomNavbar extends StatefulWidget {
  const AppBottomNavbar({super.key});

  @override
  State<AppBottomNavbar> createState() => _AppBottomNavbarState();
}

class _AppBottomNavbarState extends State<AppBottomNavbar> {
  int _currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Notes(),
    TodosList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(
              color: Colors.black,
            ),
            selectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.feed,
                    size: 28,
                  ),
                  label: 'Notes'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.checklist_rtl,
                    size: 28,
                  ),
                  label: 'Todos')
            ],
          ),
        ));
  }
}
