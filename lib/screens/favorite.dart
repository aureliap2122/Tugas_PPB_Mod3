import 'package:flutter/material.dart';

import '../models/country.dart';
import 'detail.dart';

class FavoritePage extends StatelessWidget {
  final List<Country> favorites;
  final void Function(Country country)? onToggleFavorite;

  const FavoritePage({
    super.key,
    required this.favorites,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),
      body: favorites.isEmpty
          ? const Center(child: Text('Belum ada negara favorit'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                final country = favorites[i];
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
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => onToggleFavorite?.call(country),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            country: country,
                            isFavorite: true,
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
