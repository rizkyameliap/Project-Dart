class Teman {
  String nama;
  DateTime tanggalUlangTahun;
  Teman(this.nama, this.tanggalUlangTahun);
}

// Fungsi utama yang menjalankan aplikasi
void jalankanAplikasiUlangTahun() {
  final daftarTeman = [
    Teman('Andi', DateTime(1995, 10, 28)), // Ulang tahun hari ini!
    Teman('Budi', DateTime(2000, 11, 5)),
    Teman('Citra', DateTime(1998, 3, 15)),
    Teman('Dewi', DateTime(1999, 10, 30)), // Ulang tahun 2 hari lagi
  ];

  print('--- 🎂 Aplikasi Pengingat Ulang Tahun ---');
  final hariIni = DateTime(2025, 10, 28); 
  
  print('Hari ini tanggal: ${hariIni.day}-${hariIni.month}-${hariIni.year}\n');
  cekUlangTahunHariIni(daftarTeman, hariIni);
  tampilkanHitungMundur(daftarTeman, hariIni);
}

// Fungsi untuk mengecek siapa yang ulang tahun hari ini
void cekUlangTahunHariIni(List<Teman> daftarTeman, DateTime hariIni) {
  print('--- 🎊 Yang Ulang Tahun Hari Ini ---');
  bool adaYangUlangTahun = false;

  for (final teman in daftarTeman) {
    // Kita hanya bandingkan HARI dan BULAN
    if (teman.tanggalUlangTahun.day == hariIni.day &&
        teman.tanggalUlangTahun.month == hariIni.month) {
      
      // Hitung umur
      int umur = hariIni.year - teman.tanggalUlangTahun.year;
      print('🎉 Selamat ulang tahun ke-$umur, ${teman.nama}! 🎉');
      adaYangUlangTahun = true;
    }
  }

  if (!adaYangUlangTahun) {
    print('Tidak ada yang ulang tahun hari ini.');
  }
}

// Fungsi untuk menampilkan hitung mundur
void tampilkanHitungMundur(List<Teman> daftarTeman, DateTime hariIni) {
  print('\n--- 🗓️ Hitung Mundur Ulang Tahun ---');
  
  // Urutkan daftar teman berdasarkan sisa hari
  // Kita buat List baru agar tidak mengubah daftar aslinya
  List<Teman> daftarUrut = List.from(daftarTeman);
  
  daftarUrut.sort((a, b) {
    int sisaHariA = hitungSisaHari(a.tanggalUlangTahun, hariIni);
    int sisaHariB = hitungSisaHari(b.tanggalUlangTahun, hariIni);
    return sisaHariA.compareTo(sisaHariB); // Bandingkan sisa harinya
  });

  // Tampilkan daftar yang sudah diurutkan
  for (final teman in daftarUrut) {
    int sisaHari = hitungSisaHari(teman.tanggalUlangTahun, hariIni);
    
    if (sisaHari == 0) {
      continue; 
    } else {
      print('* ${teman.nama}: $sisaHari hari lagi');
    }
  }
}

// Fungsi helper untuk menghitung sisa hari ke ulang tahun berikutnya
int hitungSisaHari(DateTime tanggalUlangTahun, DateTime hariIni) {
  // 1. Tentukan tanggal ulang tahun di TAHUN INI
  DateTime ultahTahunIni = DateTime(
    hariIni.year,
    tanggalUlangTahun.month,
    tanggalUlangTahun.day,
  );

  // 2. Cek apakah ulang tahunnya sudah lewat tahun ini
  if (ultahTahunIni.isBefore(hariIni)) {
    DateTime ultahTahunDepan = DateTime(
      hariIni.year + 1,
      tanggalUlangTahun.month,
      tanggalUlangTahun.day,
    );
    // Hitung selisih hari
    return ultahTahunDepan.difference(hariIni).inDays;
  } else {
    return ultahTahunIni.difference(hariIni).inDays;
  }
}