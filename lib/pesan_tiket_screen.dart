import 'package:flutter/material.dart';
import 'konfirmasi_pesanan_screen.dart';

class PesanTiketScreen extends StatefulWidget {
  const PesanTiketScreen({super.key});

  @override
  State<PesanTiketScreen> createState() => _PesanTiketScreenState();
}

class _PesanTiketScreenState extends State<PesanTiketScreen> {
  DateTime? _tanggalKunjungan;
  int _jumlahTiket = 1;
  final TextEditingController _namaController = TextEditingController();

  void _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalKunjungan ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _tanggalKunjungan) {
      setState(() {
        _tanggalKunjungan = picked;
      });
    }
  }

  void _submitPesanan() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama pengunjung')),
      );
      return;
    }
    if (_tanggalKunjungan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal kunjungan')),
      );
      return;
    }

    // Navigasi ke halaman konfirmasi dan kirim data pesanan
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => KonfirmasiPesananScreen(
              namaPengunjung: _namaController.text,
              tanggalKunjungan: _tanggalKunjungan!,
              jumlahTiket: _jumlahTiket,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Tiket')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Pengunjung',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Tanggal Kunjungan'),
              subtitle: Text(
                _tanggalKunjungan == null
                    ? 'Belum dipilih'
                    : _tanggalKunjungan!
                        .toLocal()
                        .toIso8601String()
                        .split("T")
                        .first,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _pilihTanggal,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Tiket', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_jumlahTiket > 1) {
                          setState(() {
                            _jumlahTiket--;
                          });
                        }
                      },
                    ),
                    Text('$_jumlahTiket', style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _jumlahTiket++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _submitPesanan,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child: const Text('Pesan Tiket'),
            ),
          ],
        ),
      ),
    );
  }
}
