import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import '../models/country.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  final void Function(Country country)? onCountryOpened;

  const HomePage({super.key, this.onCountryOpened});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Country>> _futureCountries;
  List<Country> _allCountries = [];

  String _selectedRegion = 'All';
  bool _sortAscending = true;

  final List<String> _regions = [
    'All',
    'Africa',
    'Americas',
    'Asia',
    'Europe',
    'Oceania',
    'Polar',
  ];

  @override
  void initState() {
    super.initState();
    _futureCountries = fetchCountries();
  }

  Future<List<Country>> fetchCountries() async {
    final uri = Uri.parse('https://www.apicountries.com/countries');
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();

    if (response.statusCode == 200) {
      final respBody = await response.transform(utf8.decoder).join();
      final List jsonData = jsonDecode(respBody);
      _allCountries = jsonData.map((j) => Country.fromJson(j)).toList();
      return _allCountries;
    } else {
      throw Exception('Failed to load countries: ${response.statusCode}');
    }
  }

  // Terapkan filter benua + sorting ke data yang udah kesimpen
  List<Country> get _visibleCountries {
    var list = _selectedRegion == 'All'
        ? List<Country>.from(_allCountries)
        : _allCountries.where((c) => c.region == _selectedRegion).toList();

    list.sort(
      (a, b) =>
          _sortAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedRegion,
                    decoration: const InputDecoration(
                      labelText: 'Benua',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: _regions
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedRegion = value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: _sortAscending ? 'Urutkan Z-A' : 'Urutkan A-Z',
                  icon: Icon(
                    _sortAscending ? Icons.arrow_downward : Icons.arrow_upward,
                  ),
                  onPressed: () {
                    setState(() => _sortAscending = !_sortAscending);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Country>>(
              future: _futureCountries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No countries found'));
                }

                final list = _visibleCountries;

                if (list.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada negara di benua ini'),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final country = list[i];
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
                          widget.onCountryOpened?.call(country);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(country: country),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
