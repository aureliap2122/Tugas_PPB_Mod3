import 'package:flutter/material.dart';

import '../models/country.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/history.dart';
import '../screens/favorite.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final List<Country> _history = [];
  final List<Country> _favorites = [];

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

  // Hard delete satu item riwayat
  void _removeHistoryItem(Country country) {
    setState(() {
      _history.removeWhere((c) => c.name == country.name);
    });
  }

  // Hard delete semua riwayat sekaligus
  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  // Toggle favorit: tambah kalau belum ada, hapus kalau udah ada
  void _toggleFavorite(Country country) {
    setState(() {
      final exists = _favorites.any((c) => c.name == country.name);
      if (exists) {
        _favorites.removeWhere((c) => c.name == country.name);
      } else {
        _favorites.add(country);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        onCountryOpened: _addToHistory,
        favorites: _favorites,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoritePage(favorites: _favorites, onToggleFavorite: _toggleFavorite),
      HistoryPage(
        history: _history,
        onDelete: _removeHistoryItem,
        onClearAll: _clearHistory,
        favorites: _favorites,
        onToggleFavorite: _toggleFavorite,
      ),
      ProfilePage(onHomeTap: () => _onTabTapped(0)),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
