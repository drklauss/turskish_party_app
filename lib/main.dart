import 'package:flutter/material.dart';
import 'package:turkish_party_app/address_screen.dart';
import 'package:turkish_party_app/screens/format/format_screen.dart';
import 'package:turkish_party_app/screens/info/info_screen.dart';
import 'package:turkish_party_app/screens/pass/pass_screen.dart';

// TextStyles
const TextStyle headlineLarge = TextStyle(fontSize: 22, color: Colors.red);
const TextStyle titleMedium = TextStyle(fontSize: 18);
const TextStyle bodyMedium = TextStyle(fontSize: 14);
const TextStyle bodySmall = TextStyle(fontSize: 12);

//
void main() {
  runApp(const TurkishPartyApp());
}

class TurkishPartyApp extends StatelessWidget {
  const TurkishPartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool darkMode = false;
    return MaterialApp(
      title: 'Turkish party App',
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(
        // brightness: darkMode ? Brightness.dark : Brightness.light,
        textTheme: const TextTheme(
          titleMedium: titleMedium,
          bodySmall: bodySmall,
          headlineLarge: headlineLarge,
        ),
        primarySwatch: Colors.red,
      ),
      home: const Main(),
    );
  }
}

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
              text: "Turkish party"),
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
