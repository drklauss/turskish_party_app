import 'package:flutter/material.dart';
import 'package:turkish_party_app/features/info/screen.dart';
import 'package:turkish_party_app/features/pass/screen.dart';
import 'package:turkish_party_app/features/format/screen.dart';
import 'package:turkish_party_app/features/address/screen.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  static const _pages = <Widget>[
    InfoScreen(),
    FormatScreen(),
    PassScreen(),
    AddressScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: RichText(
                text: TextSpan(children: [
          const TextSpan(
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            text: "Turkish party",
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(
                "assets/images/turkish_flag.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ]))),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
            label: 'Инфо',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_sharp),
            label: 'Формат',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key),
            label: 'Pass',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation_outlined),
            label: 'Адрес',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
