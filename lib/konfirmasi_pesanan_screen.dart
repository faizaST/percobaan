import 'package:flutter/material.dart';

class KonfirmasiPesananScreen extends StatefulWidget {
  final String namaPengunjung;
  final DateTime tanggalKunjungan;
  final int jumlahTiket;

  const KonfirmasiPesananScreen({
    super.key,
    required this.namaPengunjung,
    required this.tanggalKunjungan,
    required this.jumlahTiket,
  });

  @override
  State<KonfirmasiPesananScreen> createState() =>
      _KonfirmasiPesananScreenState();
}

class _KonfirmasiPesananScreenState extends State<KonfirmasiPesananScreen> {
  static const int hargaTiketPerOrang = 50000;

  // Variabel ini hanya simulasi status upload
  bool _isFileUploaded = false;

  void _uploadBukti() {
    // Karena tanpa file picker, kita cuma toggle status saja
    setState(() {
      _isFileUploaded = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Simulasi bukti pembayaran diupload')),
    );
  }

  void _submit() {
    if (!_isFileUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan unggah bukti pembayaran')),
      );
      return;
    }

    // Proses selanjutnya, misal kirim ke backend

    Navigator.popUntil(context, (route) => route.isFirst);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil dikonfirmasi!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalBayar = widget.jumlahTiket * hargaTiketPerOrang;

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pesanan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama Pengunjung:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              widget.namaPengunjung,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const Text(
              'Tanggal Kunjungan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              widget.tanggalKunjungan
                  .toLocal()
                  .toIso8601String()
                  .split("T")
                  .first,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const Text(
              'Jumlah Tiket:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              '${widget.jumlahTiket}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            const Text(
              'Total Bayar:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Rp ${totalBayar.toString()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Silakan transfer pembayaran ke rekening berikut:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bank BCA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'No. Rekening: 1234-5678-9012',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text('Atas Nama: MuseumGo', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Unggah Bukti Pembayaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: _uploadBukti,
              icon: const Icon(Icons.upload_file),
              label: Text(
                _isFileUploaded
                    ? 'Bukti sudah diupload'
                    : 'Unggah Bukti Pembayaran',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFileUploaded ? Colors.green : null,
              ),
            ),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Konfirmasi Pesanan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
