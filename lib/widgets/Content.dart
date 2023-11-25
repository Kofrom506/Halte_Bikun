import 'package:flutter/material.dart';

class TechStackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Tech Stack untuk Aplikasi Deteksi Objek',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildListTile('ESP32-CAM sebagai Pengirim Data', 'Mengambil gambar atau video dan mengirimkannya ke server.'),
        _buildListTile('Server Berbasis PHP', 'Menerima data dari ESP32-CAM, menyimpan data (opsional), mengolah data, dan mengirimkannya ke YOLOv4.'),
        _buildListTile('YOLOv4 untuk Deteksi Objek', 'Melakukan deteksi objek pada gambar yang diterima dari server.'),
        _buildListTile('Frontend', 'Menampilkan hasil deteksi objek kepada pengguna.'),
      ],
    );
  }

  Widget _buildListTile(String title, String description) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}