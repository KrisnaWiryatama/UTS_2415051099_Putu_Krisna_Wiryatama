import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import 'dino_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _selectedDiet = 'Carnivora';
  String _searchQuery = '';

  // Data Spesimen Dinosaurus per Kategori Diet
  final List<DinoSpecimen> _allSpecimens = const [
    // --- CARNIVORA ---
    DinoSpecimen(
      id: 'c1',
      name: 'Tyrannosaurus Rex',
      diet: 'Carnivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '12.3 meter',
      weight: '8.4 ton',
      description:
          'Predator puncak dengan kekuatan gigitan terkuat di antara hewan darat yang pernah hidup. Memiliki indra penciuman sangat tajam.',
      discoveredIn: 'Hell Creek Formation, Amerika Utara',
    ),
    DinoSpecimen(
      id: 'c2',
      name: 'Spinosaurus Aegyptiacus',
      diet: 'Carnivora',
      era: 'Late Cretaceous (99 - 93.5 Mya)',
      length: '14 - 15 meter',
      weight: '7.4 ton',
      description:
          'Dinosaurus theropoda terpanjang dengan layar punggung ikonik dan adaptasi semi-akuatik untuk berburu ikan raksasa.',
      discoveredIn: 'Gurun Sahara, Mesir & Maroko',
    ),
    DinoSpecimen(
      id: 'c3',
      name: 'Velociraptor Mongoliensis',
      diet: 'Carnivora',
      era: 'Late Cretaceous (75 - 71 Mya)',
      length: '2.0 meter',
      weight: '15 - 18 kg',
      description:
          'Theropoda gesit berbulu dengan cakar melengkung sabit di kaki belakang untuk mencengkeram mangsa secara lincah.',
      discoveredIn: 'Gurun Gobi, Mongolia',
    ),
    DinoSpecimen(
      id: 'c4',
      name: 'Allosaurus Fragilis',
      diet: 'Carnivora',
      era: 'Late Jurassic (155 - 145 Mya)',
      length: '8.5 - 9.7 meter',
      weight: '2.3 ton',
      description:
          'Predator dominan era Jurassic dengan tengkorak berengsel fleksibel dan tanduk kecil di atas matanya.',
      discoveredIn: 'Morrison Formation, Amerika Serikat',
    ),

    // --- HERBIVORA ---
    DinoSpecimen(
      id: 'h1',
      name: 'Brachiosaurus Altithorax',
      diet: 'Herbivora',
      era: 'Late Jurassic (154 - 153 Mya)',
      length: '21 - 22 meter',
      weight: '40 - 58 ton',
      description:
          'Sauropoda leher tegak dengan kaki depan lebih tinggi dari kaki belakang, memungkinkannya menjangkau tajuk pohon konifer tertinggi.',
      discoveredIn: 'Colorado, Amerika Serikat',
    ),
    DinoSpecimen(
      id: 'h2',
      name: 'Triceratops Horridus',
      diet: 'Herbivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '8.0 - 9.0 meter',
      weight: '6 - 12 ton',
      description:
          'Herbivora berkaki empat masif dengan tiga tanduk wajah tajam dan pelindung leher tulang padat untuk bertahan dari T-Rex.',
      discoveredIn: 'Amerika Utara bagian Barat',
    ),
    DinoSpecimen(
      id: 'h3',
      name: 'Stegosaurus Stenops',
      diet: 'Herbivora',
      era: 'Late Jurassic (155 - 150 Mya)',
      length: '9.0 meter',
      weight: '4.5 - 5.0 ton',
      description:
          'Dinosaurus bertubuh gempal yang dilengkapi barisan lempeng tulang di punggung dan 4 duri ekor (thagomizer) mematikan.',
      discoveredIn: 'Morrison Formation, Amerika Serikat',
    ),
    DinoSpecimen(
      id: 'h4',
      name: 'Ankylosaurus Magniventris',
      diet: 'Herbivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '8.0 meter',
      weight: '6.0 ton',
      description:
          'Tank lapis baja prasejarah dengan punggung tebal berlapis osteoderm dan gada tulang keras di ujung ekor.',
      discoveredIn: 'Montana & Alberta, Amerika Utara',
    ),

    // --- OMNIVORA ---
    DinoSpecimen(
      id: 'o1',
      name: 'Oviraptor Philoceratops',
      diet: 'Omnivora',
      era: 'Late Cretaceous (75 Mya)',
      length: '1.6 - 2.0 meter',
      weight: '33 - 40 kg',
      description:
          'Dinosaurus berparuh kuat tanpa gigi yang mengerami sarang telurnya. Memakan tanaman, moluska, dan vertebrata kecil.',
      discoveredIn: 'Djadokhta Formation, Mongolia',
    ),
    DinoSpecimen(
      id: 'o2',
      name: 'Gallimimus Bullatus',
      diet: 'Omnivora',
      era: 'Late Cretaceous (70 Mya)',
      length: '6.0 meter',
      weight: '440 - 500 kg',
      description:
          'Ornithomimosaurus mirip burung unta tercepat, memanfaatkan paruh lamela untuk memfilter tanaman air, biji, dan serangga.',
      discoveredIn: 'Nemegt Basin, Mongolia',
    ),
    DinoSpecimen(
      id: 'o3',
      name: 'Therizinosaurus Cheloniformis',
      diet: 'Omnivora',
      era: 'Late Cretaceous (70 Mya)',
      length: '10.0 meter',
      weight: '5.0 ton',
      description:
          'Theropoda aneh bertubuh besar dengan cakar tangan terpanjang di dunia (mencapai 1 meter) untuk merengkuh ranting dahan tinggi.',
      discoveredIn: 'Nemegt Formation, Mongolia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter berdasarkan Kategori Diet yang dipilih dan Search Query
    final filteredList = _allSpecimens.where((dino) {
      final matchesDiet = dino.diet.toLowerCase() == _selectedDiet.toLowerCase();
      final matchesSearch = dino.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dino.era.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDiet && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('SPECIES ARCHIVE'),
      ),
      body: Column(
        children: [
          // 1. Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Cari nama spesimen atau era...',
                  hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // 2. Tiga Kategori Pilihan Pola Makan (Carnivora, Herbivora, Omnivora)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Row(
              children: [
                _buildDietTab(
                  label: 'Carnivora',
                  icon: Icons.pets,
                  activeColor: AppColors.eraCretaceous,
                ),
                const SizedBox(width: 8),
                _buildDietTab(
                  label: 'Herbivora',
                  icon: Icons.grass,
                  activeColor: AppColors.natGeoGreen,
                ),
                const SizedBox(width: 8),
                _buildDietTab(
                  label: 'Omnivora',
                  icon: Icons.lunch_dining,
                  activeColor: const Color(0xFFE5A910),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // 3. Grid / List Kartu Spesimen Dinosaurus
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.travel_explore,
                          size: 56,
                          color: AppColors.textMuted.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada spesimen "$_selectedDiet" ditemukan',
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final dino = filteredList[index];
                      return _buildSpecimenCard(context, dino);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Widget Pill Tombol Diet Tab
  Widget _buildDietTab({
    required String label,
    required IconData icon,
    required Color activeColor,
  }) {
    final bool isSelected = _selectedDiet == label;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDiet = label;
          });
        },
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? activeColor : AppColors.borderSubtle,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Kartu Spesimen
  Widget _buildSpecimenCard(BuildContext context, DinoSpecimen dino) {
    Color badgeColor;
    if (dino.diet == 'Carnivora') {
      badgeColor = AppColors.eraCretaceous;
    } else if (dino.diet == 'Herbivora') {
      badgeColor = AppColors.natGeoGreen;
    } else {
      badgeColor = const Color(0xFFE5A910);
    }

    return Card(
      elevation: 1,
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
              builder: (context) => DinoDetailScreen(
                dinoName: dino.name,
                era: dino.era,
                diet: dino.diet,
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
                  // Icon Thumbnail Box
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      dino.diet == 'Carnivora'
                          ? Icons.pets
                          : dino.diet == 'Herbivora'
                              ? Icons.grass
                              : Icons.lunch_dining,
                      color: badgeColor,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dino.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          dino.era,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                dino.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textDark,
                  height: 1.35,
                ),
              ),
              const Divider(height: 18, color: AppColors.borderSubtle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.straighten, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        dino.length,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.scale, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        dino.weight,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    dino.discoveredIn,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
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