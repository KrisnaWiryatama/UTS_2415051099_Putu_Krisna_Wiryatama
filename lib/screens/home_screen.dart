import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../constants/dino_images.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';
import 'dino_detail_screen.dart';
import 'favorites_screen.dart';
import 'popular_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onTabChange;

  const HomeScreen({super.key, this.onTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentFactIndex = 0;

  final _faktaMenarik = [
    {
      'title': 'Raja Predator Berbulu?',
      'fact':
          'Fosil kerabat dekat T-Rex seperti Yutyrannus membuktikan bahwa keluarga Tyrannosauroidea memiliki bulu filamen halus untuk isolasi suhu tubuh.',
      'tag': 'Theropoda',
    },
    {
      'title': 'Bukan Dinosaurus Terpanjang!',
      'fact':
          'Spinosaurus adalah predator theropoda semi-akuatik terpanjang (15 meter), melampaui T-Rex, dengan moncong mirip buaya modern dan ekor mirip dayung.',
      'tag': 'Semi-Akuatik',
    },
    {
      'title': 'Otak Seukuran Kenari',
      'fact':
          'Stegosaurus memiliki bobot tubuh hingga 5 ton, tetapi rongga otaknya hanya berbobot sekitar 80 gram—seukuran kacang kenari kecil.',
      'tag': 'Anatomi',
    },
    {
      'title': 'Daya Cengkeram Gigitan Dahsyat',
      'fact':
          'Kekuatan gigitan T-Rex diperkirakan mencapai 35.000–57.000 Newton, sanggup menghancurkan tulang mangsa bulat-bulat dengan mudah.',
      'tag': 'Paleo-Biomekanik',
    },
    {
      'title': 'Kekerabatan Unggas Modern',
      'fact':
          'Semua burung modern yang hidup hari ini secara taksonomi adalah dinosaurus theropoda avian yang selamat dari kepunahan massal batas K-Pg.',
      'tag': 'Evolusi',
    },
  ];

  void _acakFakta() {
    setState(() {
      _currentFactIndex = Random().nextInt(_faktaMenarik.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = context.watch<DinoCatalogProvider>();
    final popularList = catalogProvider.popularSpecimens;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/Dinosaur_icon.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.pets,
                    color: AppColors.textDark,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('JURASSICA'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Sapaan Personal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: AppColors.borderSubtle, width: 0.8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Halo, Krisna! 👋',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.natGeoGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.radar,
                                size: 12, color: AppColors.natGeoGreen),
                            SizedBox(width: 4),
                            Text(
                              'Ekspedisi Aktif',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.natGeoGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Siap mengarungi era prasejarah dan mencatat temuan fosil hari ini?',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seksi Expeditions
                  const Text(
                    'Expeditions',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildExpeditionButton(
                          label: 'All Eras',
                          icon: Icons.public,
                          color: AppColors.natGeoGreen,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          onTap: () {
                            if (widget.onTabChange != null) {
                              widget.onTabChange!(2);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildExpeditionButton(
                          label: 'Popular',
                          icon: Icons.local_fire_department,
                          color: Colors.white,
                          textColor: AppColors.textDark,
                          iconColor: Colors.orange.shade700,
                          hasBorder: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PopularScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildExpeditionButton(
                          label: 'Logbook',
                          icon: Icons.bookmark,
                          color: Colors.white,
                          textColor: AppColors.textDark,
                          iconColor: AppColors.textDark,
                          hasBorder: true,
                          badgeCount:
                              catalogProvider.bookmarkedSpecimens.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavoritesScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // Seksi Featured Discovery
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Discovery',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (widget.onTabChange != null) {
                            widget.onTabChange!(1);
                          }
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.natGeoGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  catalogProvider.isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.0),
                            child: CircularProgressIndicator(
                              color: AppColors.natGeoGreen,
                            ),
                          ),
                        )
                      : popularList.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.0),
                                child: Text(
                                  'Belum ada spesimen unggulan.',
                                  style: TextStyle(color: AppColors.textMuted),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 290,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: popularList.length > 5
                                    ? 5
                                    : popularList.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 14),
                                itemBuilder: (context, index) {
                                  final dino = popularList[index];
                                  return _buildFullFeaturedCard(
                                    context,
                                    dino: dino,
                                    cardWidth: screenWidth - 44,
                                  );
                                },
                              ),
                            ),
                  const SizedBox(height: 24),

                  // Seksi Fakta Menarik Purba
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: Colors.amber, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Fakta Menarik Purba',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        tooltip: 'Acak Fakta',
                        icon: const Icon(Icons.shuffle,
                            size: 20, color: AppColors.natGeoGreen),
                        onPressed: _acakFakta,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  _buildFaktaCard(_faktaMenarik[_currentFactIndex]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpeditionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
    bool hasBorder = false,
    int badgeCount = 0,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      elevation: hasBorder ? 0 : 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border:
                hasBorder ? Border.all(color: AppColors.borderSubtle) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (badgeCount > 0) ...[
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryYellow,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$badgeCount',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullFeaturedCard(
    BuildContext context, {
    required DinoSpecimen dino,
    required double cardWidth,
  }) {
    final assetPath =
        DinoImages.getAssetPath(dino.name, diet: dino.diet);

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: AppColors.natGeoGreenDark,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gambar Asli Dino dari folder Assets
            Image.asset(
              assetPath,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.natGeoGreen,
                child: const Center(
                  child: Icon(Icons.pets, size: 64, color: Colors.white24),
                ),
              ),
            ),

            // Lapisan Gradien Gelap Nat Geo
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black.withValues(alpha: 0.75),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 0.35, 0.68, 1.0],
                ),
              ),
            ),

            // Konten Teks & Badge
            Material(
              color: Colors.transparent,
              child: InkWell(
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
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              dino.diet.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite,
                                    size: 13, color: Colors.redAccent),
                                const SizedBox(width: 5),
                                Text(
                                  '${dino.likeCount} Suka',
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dino.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.history_toggle_off,
                                        size: 13, color: AppColors.primaryYellow),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        '${dino.era} • ${dino.discoveredIn}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  dino.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.35,
                                    color: Colors.white.withValues(alpha: 0.88),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.natGeoGreen.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaktaCard(Map<String, String> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data['tag']!,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Tahukah Kamu?',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data['title']!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data['fact']!,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textDark,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Klik acak 🔀 untuk fakta lainnya',
                style: TextStyle(fontSize: 11, color: AppColors.natGeoGreen),
              ),
            ],
          ),
        ],
      ),
    );
  }
}