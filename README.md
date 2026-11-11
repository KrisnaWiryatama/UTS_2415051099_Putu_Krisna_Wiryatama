# Jurassica - Mesozoic Encyclopedia & Geological Field Journal

Aplikasi mobile ensiklopedia dinosaurus dan jurnal lapangan era Mesozoikum yang dibangun menggunakan Flutter, Provider, arsitektur bertingkat, REST API, serta backend database Supabase.

## Identitas Pengembang
- **Nama:** Putu Krisna Wiryatama
- **NIM:** 2415051099
- **Kelas:** PTI 5B
- **Mata Kuliah:** Pemrograman Mobile (UTS)
- **Program Studi:** Pendidikan Teknik Informatika
- **Institusi:** Universitas Pendidikan Ganesha (Undiksha)

---

## Fitur Utama Aplikasi
1. **Basecamp / Home Dashboard:** Ringkasan fosil unggulan, statistik taksonomi, dan akses cepat ke era geologis.
2. **Species Catalog (CRUD Lengkap):** 
   - Pencarian dinosaurus berdasarkan nama, diet, dan era geologis.
   - Penambahan spesimen baru (Create).
   - Pembaruan spesimen dan tautan gambar multi-sumber (Update).
   - Penghapusan spesimen dengan dialog konfirmasi keamanan (Delete).
3. **Specimen Detail Screen:** Informasi morfologi komprehensif (panjang, estimasi bobot, diet, formasi geologis, dan deskripsi lapangan).
4. **Mesozoic Trail Atlas:** Peta petualangan interaktif 3 era (Triassic, Jurassic, Cretaceous) dengan jalur berundak, rating ekspedisi, dan transisi ke jurnal era.
5. **Paleontology News (REST API):** Pengambilan artikel berita dan temuan fosil berkala via HTTP GET REST API dengan penanganan loading, error, dan empty state.
6. **Researcher Profile:** Profil kurator lapangan, statistik total arsip & spesies predator apex, status sinkronisasi cloud, serta preferensi pengukuran.

---

## Tech Stack & Arsitektur
- **Framework:** Flutter & Dart (Null Safety)
- **State Management:** Provider (`ChangeNotifier`)
- **Backend & Database:** Supabase (PostgreSQL)
- **REST API:** HTTP Client (GET JSON Parsing to Dart Models)
- **Pola Arsitektur:**
  ```text
  lib/
  ├── constants/      # AppTheme, Colors, Palettes
  ├── models/         # DinoSpecimen, EraDetail, FossilLog, DinoNews
  ├── providers/      # DinoCatalogProvider, NewsProvider, dsb.
  ├── repositories/   # DinoRepository (Supabase Client Wrapper)
  ├── services/       # Network, HTTP/REST Client Services
  ├── screens/        # Home, Catalog, Detail, Form Dialogs, Atlas, Profile
  ├── widgets/        # Reusable Card, Metric, Image Loader, Custom Painters
  └── main.dart       # MultiProvider & App Initialization