import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onHomeTap;

  const ProfilePage({super.key, this.onHomeTap});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: lengkapi/ubah anggota kelompok kamu di sini
  final List<Map<String, String>> groupMembers = const [
    {'nama': 'Aurelia Putri Cahyani', 'nim': '21120124120019'},
    {'nama': 'Habib Mukhlis Triatmojo', 'nim': '21120124130081'},
    {'nama': 'Ahmad Dika Styansah', 'nim': '21120124130052'},
    {'nama': 'Citra Marta Fatmala', 'nim': '21120124120012'},
  ];

  final String fotoUrl =
      'https://drive.google.com/uc?export=view&id=1s5okViNKbH2tKDRQTDS_I90khUfA7ke0';
  final String backgroundUrl =
      'https://drive.google.com/uc?export=view&id=1cRAMeVctBLrh0s-qnaBX48-AHODDIN7F';

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
      body: Column(
        children: [
          // Banner + foto profil ditumpuk pakai Stack, jadi abu-abu
          // banner "nembus" ke belakang setengah lingkaran foto profil
          SizedBox(
            height: 210, // 160 (tinggi banner) + 50 (setengah avatar)
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.network(
                    backgroundUrl,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // Foto profil bulat, posisinya ditarik ke atas 50px supaya
                // separuh badannya nempel di banner abu-abu, separuhnya lagi
                // turun ke area putih di bawahnya.
                Positioned(
                  top: 110, // 160 (tinggi banner) - 50 (jari-jari avatar)
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(fotoUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (var member in groupMembers)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Text(
                    member['nama'] ?? 'No Name',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    member['nim'] ?? 'No NIM',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
