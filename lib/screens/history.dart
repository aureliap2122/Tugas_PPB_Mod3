import 'package:flutter/material.dart';

import '../models/country.dart';
import 'detail.dart';

class HistoryPage extends StatelessWidget {
  final List<Country> history;

  const HistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat')),
      body: history.isEmpty
          ? const Center(child: Text('Belum ada negara yang dibuka'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final country = history[i];
                return Card(
                  child: ListTile(
                    leading: country.flagsPng != null
                        ? Image.network(
                            country.flagsPng!,
                            width: 50,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.flag, size: 32),
                          )
                        : const SizedBox(width: 50),
                    title: Text(country.name),
                    subtitle: Text(country.region),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(country: country),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
