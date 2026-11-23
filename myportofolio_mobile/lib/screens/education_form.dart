
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _institutionController =
      TextEditingController();
  final TextEditingController _majorController =
      TextEditingController();
  final TextEditingController _startYearController =
      TextEditingController();
  final TextEditingController _graduationYearController =
      TextEditingController();

  String _degree = 'S1';

  final List<String> _degrees = [
    'SMA/SMK',
    'D3',
    'S1',
    'S2',
    'S3',
  ];

  @override
  void dispose() {
    _institutionController.dispose();
    _majorController.dispose();
    _startYearController.dispose();
    _graduationYearController.dispose();
    super.dispose();
  }

  void _saveEducation() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ringkasan Pendidikan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Institusi: ${_institutionController.text.trim()}'),
                Text('Jenjang: $_degree'),
                Text('Jurusan: ${_majorController.text.trim()}'),
                Text('Tahun Masuk: ${_startYearController.text}'),
                Text('Tahun Lulus: ${_graduationYearController.text}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendidikan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Riwayat Pendidikan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Nama institusi
              TextFormField(
                controller: _institutionController,
                decoration: const InputDecoration(
                  labelText: 'Nama Institusi',
                  hintText: 'Contoh: Universitas Indonesia',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama institusi wajib diisi!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Jenjang pendidikan
              DropdownButtonFormField<String>(
                initialValue: _degree,
                decoration: const InputDecoration(
                  labelText: 'Jenjang Pendidikan',
                  border: OutlineInputBorder(),
                ),
                items: _degrees.map((String degree) {
                  return DropdownMenuItem<String>(
                    value: degree,
                    child: Text(degree),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _degree = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Jurusan
              TextFormField(
                controller: _majorController,
                decoration: const InputDecoration(
                  labelText: 'Jurusan',
                  hintText: 'Contoh: Sistem Informasi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jurusan wajib diisi!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tahun masuk
              TextFormField(
                controller: _startYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tahun Masuk',
                  hintText: 'Contoh: 2025',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final year = int.tryParse(value ?? '');

                  if (value == null || value.trim().isEmpty) {
                    return 'Tahun masuk wajib diisi!';
                  }
                  if (year == null || year < 1900 ||
                      year > DateTime.now().year + 10) {
                    return 'Masukkan tahun yang valid!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tahun lulus
              TextFormField(
                controller: _graduationYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tahun Lulus',
                  hintText: 'Contoh: 2029',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final graduationYear = int.tryParse(value ?? '');
                  final startYear =
                      int.tryParse(_startYearController.text);

                  if (value == null || value.trim().isEmpty) {
                    return 'Tahun lulus wajib diisi!';
                  }
                  if (graduationYear == null ||
                      graduationYear < 1900 ||
                      graduationYear > DateTime.now().year + 10) {
                    return 'Masukkan tahun yang valid!';
                  }
                  if (startYear != null &&
                      graduationYear < startYear) {
                    return 'Tahun lulus tidak boleh sebelum tahun masuk!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEducation,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
