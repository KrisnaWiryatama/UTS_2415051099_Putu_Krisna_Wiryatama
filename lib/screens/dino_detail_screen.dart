import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../constants/dino_images.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';

class DinoDetailScreen extends StatelessWidget {
  final DinoSpecimen? dino;
  final String? dinoName;
  final String? era;
  final String? diet;
  final String? description;
  final String? length;
  final String? weight;
  final String? discoveredIn;
  final int? likeCount;

  const DinoDetailScreen({
    super.key,
    this.dino,
    this.dinoName,
    this.era,
    this.diet,
    this.description,
    this.length,
    this.weight,
    this.discoveredIn,
    this.likeCount,
  });

  Color _getDietColor(String diet) {
    switch (diet) {
      case 'Carnivora':
        return const Color(0xFFD32F2F);
      case 'Herbivora':
        return const Color(0xFF2E7D32);
      case 'Omnivora':
        return const Color(0xFF1976D2);
      default:
        return AppColors.textDark;
    }
  }

  // Kurasi fakta ilmiah paleontologi
  Map<String, dynamic> _getPaleoResearchData(String name, String eraName, String site) {
    final clean = name.toLowerCase();

    if (clean.contains('velociraptor')) {
      return {
        'clade': 'Dromaeosauridae (Eudromaeosauria)',
        'fossilSite': 'Formasi Djadochta, Gurun Gobi (Mongolia & Tiongkok)',
        'paleoFact':
            'Spesimen legendaris "Fighting Dinosaurs" (1971) membuktikan Velociraptor terkubur badai pasir saat bertarung hidup-mati dengan Protoceratops. Penemuan tonjolan tangkai bulu (quill knobs) pada ulna tahun 2007 mengonfirmasi spesies ini memiliki bulu aerodinamis mirip burung modern.',
        'uniqueTrait': 'Cakar Sabit Bergerak (Sickle Claw) 6,5 cm pada jari kaki ke-2',
        'discoveryYear': '1923 (Peter Kaisen, Peter the Great ekspedisi AMNH)',
      };
    } else if (clean.contains('tyrannosaurus') || clean.contains('t-rex')) {
      return {
        'clade': 'Tyrannosauridae (Coelurosauria)',
        'fossilSite': 'Hell Creek Formation, Montana & South Dakota, AS',
        'paleoFact':
            'Penelitian biomekanik menunjukkan kekuatan gigitannya mencapai 57.000 Newton dengan gigi bergerigi tebal penembus tulang (bone-crushing bite). Penglihatan binokular T-Rex melampaui elang modern dengan sudut pandang stereoskopik 55 derajat.',
        'uniqueTrait': 'Penciuman Olfaktorius Raksasa & Penglihatan Binokular Tajam',
        'discoveryYear': '1902 (Barnum Brown)',
      };
    } else if (clean.contains('spinosaurus')) {
      return {
        'clade': 'Spinosauridae (Megalosauroidea)',
        'fossilSite': 'Kem Kem Beds, Maroko & Bahariya Formation, Mesir',
        'paleoFact':
            'Penelitian fosil ekor tahun 2020 membuktikan Spinosaurus memiliki ekor berbentuk dayung lebar dan kepadatan tulang osteosklerotik tinggi untuk menyelam di ekosistem sungai Cretaceous Sahara memangsa ikan raksasa Mawsonia dan Onchopristis.',
        'uniqueTrait': 'Layar Punggung Neural Spine 1,65 m & Moncong Neurovaskular',
        'discoveryYear': '1912 (Ernst Stromer)',
      };
    } else if (clean.contains('triceratops')) {
      return {
        'clade': 'Ceratopsidae (Chasmosaurinae)',
        'fossilSite': 'Lance Formation, Wyoming & Hell Creek, AS',
        'paleoFact':
            'Tengkorak Triceratops adalah salah satu yang terbesar di antara hewan darat (mencapai 2,5 meter). Fosil bekas gigitan T-Rex yang sembuh pada jumbai leher (frill) membuktikan tanduk dan perisainya berfungsi aktif sebagai pertahanan tempur.',
        'uniqueTrait': 'Tiga Tanduk Masif & Frill Tulang Leher Tebal',
        'discoveryYear': '1887 (John Bell Hatcher / O.C. Marsh)',
      };
    } else if (clean.contains('brachiosaurus')) {
      return {
        'clade': 'Brachiosauridae (Macronaria)',
        'fossilSite': 'Morrison Formation, Colorado, Amerika Serikat',
        'paleoFact':
            'Kaki depan Brachiosaurus lebih panjang daripada kaki belakangnya, memberinya postur tegak menyerupai jerapah untuk menjangkau tajuk pohon konifer setinggi 12-16 meter tanpa perlu mengangkat tubuh dengan ekor.',
        'uniqueTrait': 'Kaki Depan Elevasi Tinggi & Jantung Bertekanan Darah Ekstrem',
        'discoveryYear': '1900 (Elmer S. Riggs)',
      };
    } else if (clean.contains('oviraptor')) {
      return {
        'clade': 'Oviraptoridae (Caenagnathoidea)',
        'fossilSite': 'Formasi Djadochta, Gurun Gobi (Mongolia)',
        'paleoFact':
            'Awalnya dituduh sebagai "pencuri telur" saat ditemukan di atas sarang telur pada 1923. Penemuan embrio pada dekade 1990-an membuktikan fosil tersebut justru seekor induk Oviraptor yang sedang mengerami telurnya sendiri penuh kasih.',
        'uniqueTrait': 'Paruh Bebas Gigi Bertanduk Kuat & Jengger Tengkorak Pneumatik',
        'discoveryYear': '1924 (Roy Chapman Andrews)',
      };
    } else if (clean.contains('baryonx') || clean.contains('baryonyx')) {
      return {
        'clade': 'Spinosauridae (Baryonychinae)',
        'fossilSite': 'Smokejacks Pit, Surrey, Inggris (Weald Clay Formation)',
        'paleoFact':
            'Fosil isi lambung Baryonyx mengawetkan sisik ikan purba Lepidotes yang terkorosi asam lambung serta tulang belulang Iguanodon muda, menegaskan dietnya sebagai predator oportunistik sungai.',
        'uniqueTrait': 'Cakar Ibu Jari 31 cm Melengkung Ekstrem & Moncong Mirip Buaya',
        'discoveryYear': '1983 (William J. Walker)',
      };
    } else if (clean.contains('quetzal') || clean.contains('quetztal')) {
      return {
        'clade': 'Azhdarchidae (Pterosauria)',
        'fossilSite': 'Javelina Formation, Texas, Amerika Serikat',
        'paleoFact':
            'Quetzalcoatlus adalah salah satu hewan terbang terbesar sepanjang masa dengan rentang sayap mencapai 10-11 meter (seukuran pesawat tempur kecil). Meskipun bertubuh masif, kerangka tulangnya memiliki rongga udara pneumatik yang membuatnya sangat ringan dan mampu meluncur ratusan kilometer.',
        'uniqueTrait': 'Rentang Sayap 11 Meter & Paruh Raksasa Tanpa Gigi',
        'discoveryYear': '1971 (Douglas A. Lawson)',
      };
    }

    // Default Fallback
    return {
      'clade': 'Dinosauria (Archosauria)',
      'fossilSite': site.isNotEmpty ? site : 'Catatan Formasi Geologis Purba',
      'paleoFact':
          'Spesimen fosil ini menunjukkan adaptasi morfologi era $eraName. Lapisan sedimen mengindikasikan hewan ini berevolusi dengan efisiensi tinggi pada ekosistemnya.',
      'uniqueTrait': 'Adaptasi Spesifik Era $eraName',
      'discoveryYear': 'Terdokumentasi dalam Katalog Paleontologi',
    };
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DinoCatalogProvider>();

    // 1. Ambil data asli yang diisi user dari form Create / Supabase secara prioritas
    final String resolvedName = dino?.name ?? dinoName ?? 'Spesimen Purba';
    final String resolvedEra = dino?.era ?? era ?? 'Mesozoic Era';
    final String resolvedDiet = dino?.diet ?? diet ?? 'Carnivora';
    final String resolvedDesc = (dino?.description != null && dino!.description.isNotEmpty)
        ? dino!.description
        : (description != null && description!.isNotEmpty)
            ? description!
            : 'Spesimen ini berhasil didokumentasikan dalam arsip penelitian ekspedisi lapangan.';

    final String resolvedLength = (dino?.length != null && dino!.length.isNotEmpty)
        ? dino!.length
        : (length != null && length!.isNotEmpty)
            ? length!
            : '-';

    final String resolvedWeight = (dino?.weight != null && dino!.weight.isNotEmpty)
        ? dino!.weight
        : (weight != null && weight!.isNotEmpty)
            ? weight!
            : '-';

    final String resolvedSite = (dino?.discoveredIn != null && dino!.discoveredIn.isNotEmpty)
        ? dino!.discoveredIn
        : (discoveredIn != null && discoveredIn!.isNotEmpty)
            ? discoveredIn!
            : 'Lokasi Penggalian Belum Ditentukan';

    final String? resolvedId = dino?.id;

    final isBookmarked = resolvedId != null ? provider.isBookmarked(resolvedId) : false;
    final isLiked = resolvedId != null ? provider.isLiked(resolvedId) : false;
    final int currentLikes = dino?.likeCount ?? likeCount ?? 0;

    final dietColor = _getDietColor(resolvedDiet);
    final researchData = _getPaleoResearchData(resolvedName, resolvedEra, resolvedSite);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          resolvedName.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          if (resolvedId != null)
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? AppColors.primaryYellow : Colors.white,
              ),
              tooltip: 'Simpan ke Logbook',
              onPressed: () {
                provider.toggleBookmark(resolvedId);
                final added = provider.isBookmarked(resolvedId);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 900),
                    backgroundColor: added ? AppColors.natGeoGreen : AppColors.textDark,
                    content: Text(
                      added
                          ? 'Spesimen disimpan ke Logbook Ekspedisi'
                          : 'Spesimen dihapus dari Logbook',
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Image Spesimen (Proporsional, Tinggi 310, Tidak Terpotong)
            Container(
              height: 310,
              width: double.infinity,
              color: Colors.black12,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DinoImages.buildImage(
                    imageSource: dino?.imageUrl,
                    dinoName: resolvedName,
                    diet: resolvedDiet,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.background,
                            AppColors.background.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Header Spesimen: Nama & Suka
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resolvedName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$resolvedEra ($resolvedSite)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (resolvedId != null)
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () async {
                            await provider.toggleLike(resolvedId);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.borderSubtle),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red.shade700,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '$currentLikes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: isLiked
                                        ? Colors.red.shade700
                                        : AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. Matriks Metrik Fisik (Diet, Panjang, Bobot Hasil Create)
                  Row(
                    children: [
                      _buildMetricCard('DIET', resolvedDiet, dietColor, Icons.restaurant),
                      const SizedBox(width: 8),
                      _buildMetricCard('PANJANG', resolvedLength, AppColors.textDark, Icons.straighten),
                      const SizedBox(width: 8),
                      _buildMetricCard('EST. BOBOT', resolvedWeight, AppColors.textDark, Icons.scale_outlined),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 4. Deskripsi Morfologi (Hasil Inputan Form Create)
                  const Text(
                    'DESKRIPSI MORFOLOGI',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: AppColors.natGeoGreen,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Text(
                      resolvedDesc,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textDark,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 5. Bukti & Hasil Penelitian Ilmiah
                  const Row(
                    children: [
                      Icon(Icons.science_outlined, size: 18, color: AppColors.natGeoGreen),
                      SizedBox(width: 6),
                      Text(
                        'CATATAN PENELITIAN PALEONTOLOGI',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppColors.natGeoGreen,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildResearchRow(
                          'Klad / Filogeni',
                          researchData['clade'] as String,
                          Icons.account_tree_outlined,
                        ),
                        const Divider(height: 20, color: AppColors.borderSubtle),
                        _buildResearchRow(
                          'Lokasi Stratigrafi Fosil',
                          researchData['fossilSite'] as String,
                          Icons.terrain_outlined,
                        ),
                        const Divider(height: 20, color: AppColors.borderSubtle),
                        _buildResearchRow(
                          'Karakteristik Kunci',
                          researchData['uniqueTrait'] as String,
                          Icons.auto_awesome,
                        ),
                        const Divider(height: 20, color: AppColors.borderSubtle),
                        _buildResearchRow(
                          'Tahun Penemuan Awal',
                          researchData['discoveryYear'] as String,
                          Icons.calendar_today_outlined,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.natGeoGreen.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.menu_book, size: 18, color: AppColors.natGeoGreen),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  researchData['paleoFact'] as String,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    height: 1.45,
                                    color: AppColors.textDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color valueColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: AppColors.textMuted),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.textMuted,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResearchRow(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.natGeoGreen),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}