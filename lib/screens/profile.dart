import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onHomeTap;

  const ProfilePage({super.key, this.onHomeTap});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: ganti nilai-nilai di bawah ini sesuai data kamu sendiri
  final String nama =
      'Aurelia Putri Cahyani'; // ganti kalau mau nama lengkap + NIM
  final String nim = '21120124120019';
  final String fotoUrl =
      'https://drive.google.com/uc?export=view&id=1hIlEygo0iW49XJEF55YnGi6o_dih-Y_9';
  final String backgroundUrl =
      'https://drive.google.com/uc?export=view&id=1hIlEygo0iW49XJEF55YnGi6o_dih-Y_9';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: widget.onHomeTap),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(backgroundUrl),
                  ),
                  color: const Color.fromARGB(
                    255,
                    255,
                    252,
                    252,
                  ).withValues(alpha: 128),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(fotoUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(nim, style: const TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
