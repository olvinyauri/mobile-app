import 'package:flutter/material.dart';

class PrivacyPoliciesView extends StatelessWidget {
  const PrivacyPoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Kebijakan Privasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Kami menghargai privasi Anda dan berkomitmen untuk melindungi informasi pribadi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda. Kebijakan Privasi ini berlaku untuk semua informasi pribadi yang kami kumpulkan atau terima tentang Anda, baik saat Anda menggunakan situs web kami, aplikasi seluler, atau layanan lainnya yang kami sediakan (secara kolektif, "Layanan"), atau saat Anda berinteraksi dengan kami secara langsung. Kami mungkin mengubah Kebijakan Privasi ini dari waktu ke waktu. Kami akan memberi tahu Anda tentang perubahan tersebut dengan memperbarui tanggal "Terakhir Diperbarui" di bagian atas Kebijakan Privasi ini. Anda diharapkan untuk memeriksa halaman ini secara berkala untuk memastikan Anda mengetahui perubahan apa pun, karena mereka mengikat bagi Anda.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Informasi yang Kami Kumpulkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Kami mengumpulkan informasi pribadi Anda saat Anda menggunakan Layanan kami. Informasi pribadi adalah informasi yang dapat digunakan untuk mengidentifikasi Anda secara pribadi. Informasi pribadi juga mencakup informasi tentang Anda yang dapat digabungkan dengan informasi lain yang dapat digunakan untuk mengidentifikasi Anda secara pribadi. Informasi pribadi yang kami kumpulkan dapat mencakup, tetapi tidak terbatas pada:',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '1. Nama lengkap',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '2. Alamat email',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '3. Nomor telepon',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '4. Alamat',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '5. Informasi demografis (seperti usia, tanggal lahir, dan jenis kelamin)',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Informasi yang Anda Berikan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Kami mengumpulkan informasi pribadi yang Anda berikan kepada kami secara sukarela melalui Layanan kami. Misalnya, kami mengumpulkan informasi pribadi Anda saat Anda mendaftar untuk akun, mengisi formulir, menghubungi kami, atau berpartisipasi dalam survei, kontes, atau acara lainnya. Informasi pribadi yang Anda berikan kepada kami dapat mencakup, tetapi tidak terbatas pada:',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '1. Nama lengkap',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '2. Alamat email',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '3. Nomor telepon',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '4. Alamat',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '5. Informasi demografis (seperti usia, tanggal lahir, dan jenis kelamin)',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '6. Informasi yang Anda berikan kepada kami saat Anda menghubungi kami, seperti melalui formulir kontak atau email',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
