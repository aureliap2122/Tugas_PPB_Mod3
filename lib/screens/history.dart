import 'package:flutter/material.dart';

import '../models/country.dart';
import 'detail.dart';

class HistoryPage extends StatelessWidget {
  final List<Country> history;
  final void Function(Country country)? onDelete;
  final VoidCallback? onClearAll;
  final List<Country> favorites;
  final void Function(Country country)? onToggleFavorite;

  const HistoryPage({
    super.key,
    required this.history,
    this.onDelete,
    this.onClearAll,
    this.favorites = const [],
    this.onToggleFavorite,
  });

  Future<void> _confirmClearAll(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus semua riwayat?'),
        content: const Text(
          'Semua riwayat negara yang pernah dibuka akan dihapus permanen dan tidak bisa dikembalikan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      onClearAll?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              tooltip: 'Hapus semua riwayat',
              icon: const Icon(Icons.delete_forever),
              onPressed: () => _confirmClearAll(context),
            ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('Belum ada negara yang dibuka'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final country = history[i];
                final isFav = favorites.any((c) => c.name == country.name);

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
                    trailing: IconButton(
                      tooltip: 'Hapus dari riwayat',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => onDelete?.call(country),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            country: country,
                            isFavorite: isFav,
                            onToggleFavorite: onToggleFavorite,
                          ),
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
