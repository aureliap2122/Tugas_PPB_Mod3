import 'package:flutter/material.dart';

import '../models/country.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/history.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final List<Country> _history = [];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Dipanggil dari HomePage tiap kali user buka detail sebuah negara
  void _addToHistory(Country country) {
    setState(() {
      // hindari duplikat: kalau negara yang sama udah pernah dibuka,
      // pindahin ke paling atas aja (biar urut dari yang terbaru)
      _history.removeWhere((c) => c.name == country.name);
      _history.insert(0, country);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onCountryOpened: _addToHistory),
      HistoryPage(history: _history),
      ProfilePage(onHomeTap: () => _onTabTapped(0)),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
