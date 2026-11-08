import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/era_detail.dart';
import 'era_detail_screen.dart';

class AtlasScreen extends StatelessWidget {
  const AtlasScreen({super.key});

  static const List<EraDetailData> _eraDataset = [
    // --- 1. TRIASSIC PERIOD ---
    EraDetailData(
      name: 'Triassic Period',
      timeline: '252 - 201 Juta Tahun Lalu',
      summary:
          'Fajar era Mesozoikum yang diawali kepunahan massal Permian-Triassic. Dinosaurus berevolusi dari archosaurus kecil dan mulai berbagi daratan bersama synapsida dan reptil purba lainnya.',
      climate:
          'Kering dan gersang di wilayah pedalaman, dengan musim monsun ekstrem di dekat pesisir. Fluktuasi suhu sangat tajam tanpa tutupan es di kutub.',
      geography:
          'Superbenua tunggal Pangea membentang luas dari kutub ke kutub, dikelilingi oleh satu samudera raksasa yang disebut Panthalassa.',
      flora:
          'Didominasi tumbuhan runjung (konifer), ginkgo, cycad, dan pakis purba tahan kering. Tumbuhan berbunga belum berevolusi sama sekali.',
      landmarkEvent:
          'Kepunahan Triassic-Jurassic (201 Mya) memusnahkan sebagian besar reptil pesaing, membuka jalan bagi dinosaurus untuk mendominasi bumi.',
      keyDinos: [
        EraDinoInfo(
          id: 't1',
          name: 'Coelophysis Bauri',
          role: 'Pemburu Kawanan Awal',
          diet: 'Carnivora',
          brief: 'Theropoda ramping bertulang rongga udara dengan kecepatan tinggi dan indra visual tajam.',
        ),
        EraDinoInfo(
          id: 't2',
          name: 'Plateosaurus Engelhardti',
          role: 'Herbivora Raksasa Pertama',
          diet: 'Herbivora',
          brief: 'Prosauropoda bertubuh panjang yang mampu berdiri dengan dua kaki belakang untuk merengkuh pucuk daun.',
        ),
        EraDinoInfo(
          id: 't3',
          name: 'Herrerasaurus Ischigualastensis',
          role: 'Predator Darat Primitif',
          diet: 'Carnivora',
          brief: 'Salah satu dinosaurus karnivora paling awal dengan cakar kaki mencengkeram kuat.',
        ),
      ],
    ),

    // --- 2. JURASSIC PERIOD ---
    EraDetailData(
      name: 'Jurassic Period',
      timeline: '201 - 145 Juta Tahun Lalu',
      summary:
          'Zaman keemasan dinosaurus raksasa. Iklim bumi berubah menjadi hangat dan lembap secara merata, menghasilkan hutan hujan konifer yang luar biasa subur dan menumbuhkan sauropoda berukuran masif.',
      climate:
          'Hangat, lembap, dan tropis di hampir seluruh belahan bumi. Tidak ada lapisan es di kutub, dengan curah hujan tinggi yang stabil.',
      geography:
          'Superbenua Pangea mulai terbelah menjadi dua superkontinen besar: Laurasia di utara dan Gondwana di selatan, membentuk lautan Tethys.',
      flora:
          'Hutan lebat tumbuhan runjung tinggi, pakis pohon setinggi rumah, dan cycad rimbun yang menjadi pasokan makanan tak terbatas bagi sauropoda.',
      landmarkEvent:
          'Munculnya garis evolusi burung pertama (seperti Archaeopteryx) dari theropoda berbulu terbang.',
      keyDinos: [
        EraDinoInfo(
          id: 'h1',
          name: 'Brachiosaurus Altithorax',
          role: 'Megaherbivora Kanopi Tinggi',
          diet: 'Herbivora',
          brief: 'Sauropoda raksasa dengan postur tubuh menjulang tinggi untuk menjangkau tajuk pohon konifer tertinggi.',
        ),
        EraDinoInfo(
          id: 'h3',
          name: 'Stegosaurus Stenops',
          role: 'Herbivora Lapis Baja Punggung',
          diet: 'Herbivora',
          brief: 'Dinosaurus berperisai pelat tulang segitiga di sepanjang tulang belakang dengan 4 duri ekor pemusnah.',
        ),
        EraDinoInfo(
          id: 'c4',
          name: 'Allosaurus Fragilis',
          role: 'Apex Predator Jurassic',
          diet: 'Carnivora',
          brief: 'Pemburu puncak Jurassic dengan rahang fleksibel berengsel yang memangsa sauropoda muda.',
        ),
      ],
    ),

    // --- 3. CRETACEOUS PERIOD ---
    EraDetailData(
      name: 'Cretaceous Period',
      timeline: '145 - 66 Juta Tahun Lalu',
      summary:
          'Era puncak keanekaragaman dan spesialisasi bentuk dinosaurus tertinggi, sebelum diakhiri hantaman asteroid Chicxulub yang memicu kepunahan massal Cretaceous-Paleogene (K-Pg).',
      climate:
          'Awalnya hangat dengan permukaan laut tertinggi dalam sejarah bumi, lalu mengalami dinamika pendinginan global secara bertahap menjelang akhir era.',
      geography:
          'Benua-benua modern mulai terpisah mendekati posisi sekarang. Muncul kepulauan luas dan jalur laut pedalaman dangkal (Western Interior Seaway).',
      flora:
          'Revolusi biosfer terbesar: Tumbuhan berbunga (Angiospermae) pertama kali muncul dan berkembang pesat, bersama serangga penyerbuk.',
      landmarkEvent:
          'Hantaman asteroid selebar 10–15 km di Semenanjung Yucatán (Kawah Chicxulub) mengakhiri zaman dinosaurus non-avian 66 juta tahun lalu.',
      keyDinos: [
        EraDinoInfo(
          id: 'c1',
          name: 'Tyrannosaurus Rex',
          role: 'Predator Puncak Terbesar',
          diet: 'Carnivora',
          brief: 'Raja predator Late Cretaceous dengan kekuatan gigitan remuk-tulang hingga 6 ton per inci persegi.',
        ),
        EraDinoInfo(
          id: 'c2',
          name: 'Spinosaurus Aegyptiacus',
          role: 'Predator Semi-Akuatik Terpanjang',
          diet: 'Carnivora',
          brief: 'Theropoda raksasa bersirip layar dengan moncong mirip buaya pemakan ikan purba raksasa Onchopristis.',
        ),
        EraDinoInfo(
          id: 'h2',
          name: 'Triceratops Horridus',
          role: 'Herbivora Bertanduk Tiga',
          diet: 'Herbivora',
          brief: 'Spesimen ceratopsia bertulang leher padat anti peluru gigitan T-Rex dengan 3 tanduk pertahanan tajam.',
        ),
        EraDinoInfo(
          id: 'c3',
          name: 'Velociraptor Mongoliensis',
          role: 'Predator Berbulu Inteligen',
          diet: 'Carnivora',
          brief: 'Theropoda berbulu tangkas dengan cakar sabit mematikan di padang pasir Mongolia.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('GEOLOGICAL ATLAS'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // Banner Panduan Atlas
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.natGeoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.natGeoGreen.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.natGeoGreen, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pilih salah satu periode geologi di bawah untuk mengeksplorasi kondisi alam, iklim, dan spesies endemiknya.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Triassic Period Card
          _buildEraNavigationCard(
            context: context,
            era: _eraDataset[0],
            themeColor: const Color(0xFFF57C00),
            icon: Icons.flash_on,
          ),
          const SizedBox(height: 14),

          // Jurassic Period Card
          _buildEraNavigationCard(
            context: context,
            era: _eraDataset[1],
            themeColor: AppColors.natGeoGreen,
            icon: Icons.park,
          ),
          const SizedBox(height: 14),

          // Cretaceous Period Card
          _buildEraNavigationCard(
            context: context,
            era: _eraDataset[2],
            themeColor: AppColors.eraCretaceous,
            icon: Icons.local_fire_department,
          ),
        ],
      ),
    );
  }

  Widget _buildEraNavigationCard({
    required BuildContext context,
    required EraDetailData era,
    required Color themeColor,
    required IconData icon,
  }) {
    final String koleksiText = era.keyDinos.map((d) => d.name.split(' ').first).join(', ');

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EraDetailScreen(
                era: era,
                themeColor: themeColor,
                icon: icon,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: themeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: themeColor, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          era.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          era.timeline,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                era.summary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: AppColors.textDark,
                ),
              ),
              const Divider(height: 20, color: AppColors.borderSubtle),
              Row(
                children: [
                  Icon(Icons.hub_outlined, size: 15, color: themeColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Koleksi: $koleksiText',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: themeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}