import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/era_detail.dart';
import 'era_detail_screen.dart';

class AtlasScreen extends StatefulWidget {
  const AtlasScreen({super.key});

  @override
  State<AtlasScreen> createState() => _AtlasScreenState();
}

class _AtlasScreenState extends State<AtlasScreen> {
  final List<Map<String, dynamic>> _eras = const [
    {
      'level': 1,
      'title': 'Triassic Period',
      'period': '252 - 201 Juta Tahun Lalu',
      'tagline': 'Fajar Era Mesozoikum',
      'imageAsset': 'assets/Trias.jpg',
      'summary':
          'Diawali kepunahan massal Permian-Triassic. Dinosaurus berevolusi dari archosaurus kecil dan mulai berbagi daratan bersama synapsida.',
      'collection': 'Coelophysis, Plateosaurus, Herrerasaurus',
      'geography': 'Superbenua tunggal Pangaea yang dikelilingi samudera Panthalassa luas.',
      'flora': 'Pakis, cycadophyta primitif, dan tumbuhan berbiji terbuka (Gymnospermae).',
      'climate': 'Kering, gersang, musim monsun ekstrem di superbenua Pangaea.',
      'landmarkEvent': 'Kemunculan archosaurus terestrial pertama dan permulaan diversifikasi dinosaurus awal.',
      'keyDinos': [
        EraDinoInfo(
          name: 'Coelophysis',
          role: 'Theropoda Karnivora Awal',
          length: '3 Meter',
          diet: 'Carnivora',
          brief: 'Predator ramping dan gesit pemburu hewan kecil di daratan kering.',
        ),
        EraDinoInfo(
          name: 'Plateosaurus',
          role: 'Prosauropoda Herbivora',
          length: '8 Meter',
          diet: 'Herbivora',
          brief: 'Pemakan tumbuhan berkaki dua awal dengan leher panjang pemakan daun tinggi.',
        ),
        EraDinoInfo(
          name: 'Herrerasaurus',
          role: 'Predator Dini Basal',
          length: '4 Meter',
          diet: 'Carnivora',
          brief: 'Salah satu predator dinosaurus terawal dengan rahang kuat bersendi ganda.',
        ),
      ],
      'accentColor': Color(0xFFE65100),
      'icon': Icons.bolt_rounded,
      'alignX': 0.55,
    },
    {
      'level': 2,
      'title': 'Jurassic Period',
      'period': '201 - 145 Juta Tahun Lalu',
      'tagline': 'Zaman Keemasan Raksasa',
      'imageAsset': 'assets/Jura.jpg',
      'summary':
          'Iklim bumi berubah menjadi hangat dan lembap merata, menghasilkan hutan hujan konifer yang luar biasa subur dan menumbuhkan sauropoda raksasa.',
      'collection': 'Brachiosaurus, Stegosaurus, Allosaurus',
      'geography': 'Pangaea mulai terbelah menjadi Laurasia di utara dan Gondwana di selatan.',
      'flora': 'Hutan konifer raksasa, ginkgo, bennettitales, dan hutan pakis lebat.',
      'climate': 'Hangat, lembap, tanpa tutupan es kutub, vegetasi pakis dan konifer masif.',
      'landmarkEvent': 'Dominasi sauropoda berleher panjang dan kemunculan dinosaurus berbulu pertama.',
      'keyDinos': [
        EraDinoInfo(
          name: 'Brachiosaurus',
          role: 'Sauropoda Raksasa',
          length: '26 Meter',
          diet: 'Herbivora',
          brief: 'Raksasa herbivora berleher tegak pemakan puncak pohon konifer.',
        ),
        EraDinoInfo(
          name: 'Stegosaurus',
          role: 'Thyreophora Bertanduk Lempeng',
          length: '9 Meter',
          diet: 'Herbivora',
          brief: 'Dinosaurus berperisai lempeng dorsal ganda dengan ekor berduri mematikan.',
        ),
        EraDinoInfo(
          name: 'Allosaurus',
          role: 'Predator Puncak Karnivora',
          length: '10 Meter',
          diet: 'Carnivora',
          brief: 'Karnivora puncak penguasa daratan Jurassic dengan cakar depan melengkung.',
        ),
      ],
      'accentColor': Color(0xFF1565C0),
      'icon': Icons.forest_rounded,
      'alignX': -0.45,
    },
    {
      'level': 3,
      'title': 'Cretaceous Period',
      'period': '145 - 66 Juta Tahun Lalu',
      'tagline': 'Puncak Keanekaragaman & Kepunahan',
      'imageAsset': 'assets/Creto.jpg',
      'summary':
          'Era puncak keanekaragaman dan spesialisasi bentuk dinosaurus tertinggi, sebelum diakhiri hantaman asteroid Chicxulub yang memicu kepunahan massal.',
      'collection': 'Tyrannosaurus, Spinosaurus, Triceratops, Velociraptor',
      'geography': 'Benua modern mulai terbentuk terpisah dengan laut dangkal yang luas.',
      'flora': 'Kemunculan dan dominasi tumbuhan berbunga (Angiospermae) pertama di bumi.',
      'climate': 'Iklim tropis meluas hingga ke daerah lintang tinggi kutub.',
      'landmarkEvent': 'Ledakan radiasi adaptif ceratopsian, hadrosaur, theropoda raksasa, dan benturan asteroid K-Pg.',
      'keyDinos': [
        EraDinoInfo(
          name: 'Tyrannosaurus Rex',
          role: 'Predator Terestrial Dominan',
          length: '12 Meter',
          diet: 'Carnivora',
          brief: 'Raja predator dengan gigitan penghancur tulang terkuat di daratan.',
        ),
        EraDinoInfo(
          name: 'Spinosaurus',
          role: 'Theropoda Semi-Akuatik',
          length: '15 Meter',
          diet: 'Carnivora',
          brief: 'Karnivora raksasa bersirip punggung pemburu ikan di rawa-rawa.',
        ),
        EraDinoInfo(
          name: 'Triceratops',
          role: 'Herbivora Bertanduk Tiga',
          length: '9 Meter',
          diet: 'Herbivora',
          brief: 'Herbivora kekar berpelindung leher masif dan tiga tanduk tempur.',
        ),
      ],
      'accentColor': Color(0xFF2E7D32),
      'icon': Icons.local_fire_department_rounded,
      'alignX': 0.40,
    },
  ];

  void _navigateToDetail(Map<String, dynamic> eraData) {
    final eraModel = EraDetailData(
      name: eraData['title'] as String,
      timeline: eraData['period'] as String,
      summary: eraData['summary'] as String,
      geography: eraData['geography'] as String,
      flora: eraData['flora'] as String,
      climate: eraData['climate'] as String,
      fauna: eraData['collection'] as String,
      landmarkEvent: eraData['landmarkEvent'] as String,
      keyDinos: (eraData['keyDinos'] as List<EraDinoInfo>),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EraDetailScreen(
          era: eraModel,
          themeColor: eraData['accentColor'] as Color,
          icon: eraData['icon'] as IconData,
        ),
      ),
    );
  }

  void _showEraBottomSheet(Map<String, dynamic> era) {
    final Color accent = era['accentColor'] as Color;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    era['imageAsset'] as String,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 48,
                      height: 48,
                      color: accent.withValues(alpha: 0.15),
                      child: Icon(era['icon'] as IconData, color: accent, size: 26),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        era['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        era['period'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    3,
                    (i) => const Icon(Icons.star, color: AppColors.primaryYellow, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              era['summary'] as String,
              style: const TextStyle(
                fontSize: 13,
                height: 1.45,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hub_outlined, size: 16, color: AppColors.natGeoGreen),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Koleksi: ${era['collection']}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.natGeoGreenDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.natGeoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.explore_outlined),
                label: const Text(
                  'MASUKI EKSPEDISI ERA INI',
                  style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  _navigateToDetail(era);
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7CB342),
      appBar: AppBar(
        title: const Text('MESOZOIC TRAIL ATLAS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Petunjuk Ekspedisi',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.natGeoGreenDark,
                  content: Text(
                    'Peta Mesozoikum: Ketuk level era geologis dari bawah ke atas untuk menjelajah!',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double mapHeight = constraints.maxHeight < 620 ? 620 : constraints.maxHeight;

            final double alignX1 = (_eras[0]['alignX'] as num).toDouble();
            final double alignX2 = (_eras[1]['alignX'] as num).toDouble();
            final double alignX3 = (_eras[2]['alignX'] as num).toDouble();

            return SingleChildScrollView(
              child: SizedBox(
                width: constraints.maxWidth,
                height: mapHeight,
                child: Stack(
                  children: [
                    // Jalur Peta Alam Berkelok
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _AdventurePathPainter(),
                      ),
                    ),

                    // Header Ekspedisi
                    Positioned(
                      top: 14,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryYellow,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.map_outlined,
                                color: AppColors.textDark,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EKSPEDISI 3 PERIODE GEOLOGI',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  Text(
                                    'Jelajahi jalur evolusi dari bawah (Triassic) ke puncak.',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Stage 3: Cretaceous Period
                    _buildLevelNode(
                      context,
                      era: _eras[2],
                      topOffset: mapHeight * 0.16,
                      alignX: alignX3,
                      isTop: true,
                    ),

                    // Jembatan Penyeberangan Sungai
                    Positioned(
                      top: mapHeight * 0.44,
                      left: constraints.maxWidth * 0.38,
                      child: _buildBridgeElement(),
                    ),

                    // Stage 2: Jurassic Period
                    _buildLevelNode(
                      context,
                      era: _eras[1],
                      topOffset: mapHeight * 0.48,
                      alignX: alignX2,
                    ),

                    // Stage 1: Triassic Period
                    _buildLevelNode(
                      context,
                      era: _eras[0],
                      topOffset: mapHeight * 0.74,
                      alignX: alignX1,
                      isStart: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBridgeElement() {
    return Container(
      width: 72,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFF8D6E63),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF5D4037), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) => Container(
            width: 8,
            decoration: BoxDecoration(
              color: index.isEven ? const Color(0xFF6D4C41) : const Color(0xFF795548),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelNode(
    BuildContext context, {
    required Map<String, dynamic> era,
    required double topOffset,
    required double alignX,
    bool isStart = false,
    bool isTop = false,
  }) {
    final int level = era['level'] as int;
    final String title = era['title'] as String;
    final String period = era['period'] as String;
    final String imageAsset = era['imageAsset'] as String;
    final Color accent = era['accentColor'] as Color;

    return Positioned(
      top: topOffset,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment(alignX, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStar(scale: 0.85),
                _buildStar(scale: 1.15),
                _buildStar(scale: 0.85),
              ],
            ),
            const SizedBox(height: 2),

            // Tombol 3D Berisi Gambar Ilustrasi Era
            GestureDetector(
              onTap: () => _showEraBottomSheet(era),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFE082),
                      Color(0xFFFFB300),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                  ),
                  child: ClipOval(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: accent,
                            child: Center(
                              child: Text(
                                '$level',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (isStart || isTop)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 1.5),
                              color: Colors.black.withValues(alpha: 0.65),
                              child: Text(
                                isStart ? 'START' : 'PEAK',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 7.5,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primaryYellow,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            // Tag Nama & Periode Waktu
            GestureDetector(
              onTap: () => _showEraBottomSheet(era),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: accent,
                        letterSpacing: 0.4,
                      ),
                    ),
                    Text(
                      period,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar({required double scale}) {
    return Transform.scale(
      scale: scale,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.star_rounded,
          color: AppColors.primaryYellow,
          size: 19,
        ),
      ),
    );
  }
}

class _AdventurePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF558B2F),
          Color(0xFF689F38),
          Color(0xFF7CB342),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final path = Path();
    path.moveTo(size.width * 0.68, size.height);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.80,
      size.width * 0.55,
      size.height * 0.68,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.55,
      size.width * 0.35,
      size.height * 0.42,
    );
    path.quadraticBezierTo(
      size.width * 0.50,
      size.height * 0.28,
      size.width * 0.65,
      size.height * 0.15,
    );
    path.quadraticBezierTo(
      size.width * 0.70,
      size.height * 0.05,
      size.width * 0.50,
      0,
    );

    final shadowPaint = Paint()
      ..color = const Color(0xFFC79267)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 64
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, shadowPaint);

    final trailPaint = Paint()
      ..color = const Color(0xFFE8A87C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 54
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, trailPaint);

    final pebblePaint = Paint()..color = const Color(0xFFD69466);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.60, size.height * 0.72), width: 12, height: 8), pebblePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.52, size.height * 0.76), width: 8, height: 6), pebblePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.38, size.height * 0.48), width: 14, height: 9), pebblePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.46, size.height * 0.32), width: 10, height: 7), pebblePaint);

    _drawPineTree(canvas, Offset(size.width * 0.10, size.height * 0.85), 32);
    _drawPineTree(canvas, Offset(size.width * 0.88, size.height * 0.65), 36);
    _drawPineTree(canvas, Offset(size.width * 0.12, size.height * 0.38), 38);
    _drawPineTree(canvas, Offset(size.width * 0.85, size.height * 0.28), 34);
    _drawPineTree(canvas, Offset(size.width * 0.20, size.height * 0.12), 40);

    _drawFlower(canvas, Offset(size.width * 0.25, size.height * 0.78));
    _drawFlower(canvas, Offset(size.width * 0.80, size.height * 0.82));
    _drawFlower(canvas, Offset(size.width * 0.22, size.height * 0.48));
    _drawFlower(canvas, Offset(size.width * 0.75, size.height * 0.38));
  }

  void _drawPineTree(Canvas canvas, Offset center, double radius) {
    final darkTree = Paint()..color = const Color(0xFF33691E);
    final lightTree = Paint()..color = const Color(0xFF43A047);

    final p1 = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx - radius * 0.7, center.dy + radius * 0.6)
      ..lineTo(center.dx + radius * 0.7, center.dy + radius * 0.6)
      ..close();
    canvas.drawPath(p1, darkTree);

    final p2 = Path()
      ..moveTo(center.dx, center.dy - radius * 0.8)
      ..lineTo(center.dx - radius * 0.5, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.5, center.dy + radius * 0.3)
      ..close();
    canvas.drawPath(p2, lightTree);
  }

  void _drawFlower(Canvas canvas, Offset center) {
    final yellow = Paint()..color = const Color(0xFFFFD54F);
    final white = Paint()..color = Colors.white;

    canvas.drawCircle(center, 4, yellow);
    canvas.drawCircle(Offset(center.dx - 3, center.dy), 2.5, white);
    canvas.drawCircle(Offset(center.dx + 3, center.dy), 2.5, white);
    canvas.drawCircle(Offset(center.dx, center.dy - 3), 2.5, white);
    canvas.drawCircle(Offset(center.dx, center.dy + 3), 2.5, white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}