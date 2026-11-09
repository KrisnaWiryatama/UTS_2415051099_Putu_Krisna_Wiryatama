import 'package:flutter/foundation.dart';
import '../models/dino_specimen.dart';
import '../repositories/dino_repository.dart';

class DinoCatalogProvider extends ChangeNotifier {
  final DinoRepository _repository = DinoRepository();
  // HAPUS 'const' agar list ini modifiable (bisa diubah indeksnya)
  List<DinoSpecimen> _specimens = [
    // --- CARNIVORA ---
    const DinoSpecimen(
      id: 'c1',
      name: 'Tyrannosaurus Rex',
      diet: 'Carnivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '12.3 meter',
      weight: '8.4 ton',
      description:
          'Predator puncak dengan kekuatan gigitan terkuat di antara hewan darat yang pernah hidup. Memiliki indra penciuman sangat tajam.',
      discoveredIn: 'Hell Creek Formation, Amerika Utara',
      likeCount: 1420,
    ),
    const DinoSpecimen(
      id: 'c2',
      name: 'Spinosaurus Aegyptiacus',
      diet: 'Carnivora',
      era: 'Late Cretaceous (99 - 93.5 Mya)',
      length: '14 - 15 meter',
      weight: '7.4 ton',
      description:
          'Dinosaurus theropoda terpanjang dengan layar punggung ikonik dan adaptasi semi-akuatik untuk berburu ikan raksasa.',
      discoveredIn: 'Gurun Sahara, Mesir & Maroko',
      likeCount: 1285,
    ),
    const DinoSpecimen(
      id: 'c3',
      name: 'Velociraptor Mongoliensis',
      diet: 'Carnivora',
      era: 'Late Cretaceous (75 - 71 Mya)',
      length: '2.0 meter',
      weight: '15 - 18 kg',
      description:
          'Theropoda gesit berbulu dengan cakar melengkung sabit di kaki belakang untuk mencengkeram mangsa secara lincah.',
      discoveredIn: 'Gurun Gobi, Mongolia',
      likeCount: 940,
    ),
    const DinoSpecimen(
      id: 'c4',
      name: 'Allosaurus Fragilis',
      diet: 'Carnivora',
      era: 'Late Jurassic (155 - 145 Mya)',
      length: '8.5 - 9.7 meter',
      weight: '2.3 ton',
      description:
          'Predator dominan era Jurassic dengan tengkorak berengsel fleksibel dan tanduk kecil di atas matanya.',
      discoveredIn: 'Morrison Formation, Amerika Serikat',
      likeCount: 620,
    ),

    // --- HERBIVORA ---
    const DinoSpecimen(
      id: 'h1',
      name: 'Brachiosaurus Altithorax',
      diet: 'Herbivora',
      era: 'Late Jurassic (154 - 153 Mya)',
      length: '21 - 22 meter',
      weight: '40 - 58 ton',
      description:
          'Sauropoda leher tegak dengan kaki depan lebih tinggi dari kaki belakang untuk menjangkau tajuk pohon tertinggi.',
      discoveredIn: 'Colorado, Amerika Serikat',
      likeCount: 1110,
    ),
    const DinoSpecimen(
      id: 'h2',
      name: 'Triceratops Horridus',
      diet: 'Herbivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '8.0 - 9.0 meter',
      weight: '6 - 12 ton',
      description:
          'Herbivora berkaki empat masif dengan tiga tanduk wajah tajam dan pelindung leher tulang padat.',
      discoveredIn: 'Amerika Utara bagian Barat',
      likeCount: 1350,
    ),
    const DinoSpecimen(
      id: 'h3',
      name: 'Stegosaurus Stenops',
      diet: 'Herbivora',
      era: 'Late Jurassic (155 - 150 Mya)',
      length: '9.0 meter',
      weight: '4.5 - 5.0 ton',
      description:
          'Dinosaurus bertubuh gempal yang dilengkapi barisan lempeng tulang di punggung dan 4 duri ekor mematikan.',
      discoveredIn: 'Morrison Formation, Amerika Serikat',
      likeCount: 890,
    ),
    const DinoSpecimen(
      id: 'h4',
      name: 'Ankylosaurus Magniventris',
      diet: 'Herbivora',
      era: 'Late Cretaceous (68 - 66 Mya)',
      length: '8.0 meter',
      weight: '6.0 ton',
      description:
          'Tank lapis baja prasejarah dengan punggung tebal berlapis osteoderm dan gada tulang keras di ujung ekor.',
      discoveredIn: 'Montana & Alberta, Amerika Utara',
      likeCount: 780,
    ),

    // --- OMNIVORA ---
    const DinoSpecimen(
      id: 'o1',
      name: 'Oviraptor Philoceratops',
      diet: 'Omnivora',
      era: 'Late Cretaceous (75 Mya)',
      length: '1.6 - 2.0 meter',
      weight: '33 - 40 kg',
      description:
          'Dinosaurus berparuh kuat tanpa gigi yang mengerami sarang telurnya. Memakan tanaman, moluska, dan vertebrata kecil.',
      discoveredIn: 'Djadokhta Formation, Mongolia',
      likeCount: 510,
    ),
    const DinoSpecimen(
      id: 'o2',
      name: 'Gallimimus Bullatus',
      diet: 'Omnivora',
      era: 'Late Cretaceous (70 Mya)',
      length: '6.0 meter',
      weight: '440 - 500 kg',
      description:
          'Ornithomimosaurus mirip burung unta tercepat, memanfaatkan paruh lamela untuk memfilter tanaman air dan biji.',
      discoveredIn: 'Nemegt Basin, Mongolia',
      likeCount: 460,
    ),
    const DinoSpecimen(
      id: 'o3',
      name: 'Therizinosaurus Cheloniformis',
      diet: 'Omnivora',
      era: 'Late Cretaceous (70 Mya)',
      length: '10.0 meter',
      weight: '5.0 ton',
      description:
          'Theropoda aneh bertubuh besar dengan cakar tangan terpanjang di dunia untuk merengkuh ranting dahan tinggi.',
      discoveredIn: 'Nemegt Formation, Mongolia',
      likeCount: 830,
    ),
  ];

  late List<DinoSpecimen> _cachedPopular;
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedDiet = 'Carnivora';
  String _searchQuery = '';

  final Set<String> _userLikedIds = {};
  final Set<String> _bookmarkedDinoIds = {};

  DinoCatalogProvider() {
    _updatePopularCache();
  }

  List<DinoSpecimen> get specimens => _specimens;
  List<DinoSpecimen> get popularSpecimens => _cachedPopular;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedDiet => _selectedDiet;
  String get searchQuery => _searchQuery;

  List<DinoSpecimen> get filteredSpecimens {
    final query = _searchQuery.trim().toLowerCase();
    final dietFilter = _selectedDiet.toLowerCase();

    return _specimens.where((dino) {
      final matchesDiet = dino.diet.toLowerCase() == dietFilter;
      if (!matchesDiet) return false;
      if (query.isEmpty) return true;
      return dino.name.toLowerCase().contains(query) ||
          dino.era.toLowerCase().contains(query);
    }).toList();
  }

  List<DinoSpecimen> get bookmarkedSpecimens {
    if (_bookmarkedDinoIds.isEmpty) return [];
    return _specimens
        .where((dino) => _bookmarkedDinoIds.contains(dino.id))
        .toList();
  }

  bool isLiked(String id) => _userLikedIds.contains(id);
  bool isBookmarked(String id) => _bookmarkedDinoIds.contains(id);

  int getLikeCount(String id) {
    for (int i = 0; i < _specimens.length; i++) {
      if (_specimens[i].id == id) return _specimens[i].likeCount;
    }
    return 0;
  }

  void _updatePopularCache() {
    _cachedPopular = List<DinoSpecimen>.from(_specimens)
      ..sort((a, b) => b.likeCount.compareTo(a.likeCount));
  }

  void setSpecimens(List<DinoSpecimen> data) {
    _specimens = List<DinoSpecimen>.from(data);
    _updatePopularCache();
    notifyListeners();
  }

  void setDiet(String diet) {
    if (_selectedDiet == diet) return;
    _selectedDiet = diet;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void toggleLike(String id) {
    final index = _specimens.indexWhere((item) => item.id == id);
    if (index == -1) return;

    if (_userLikedIds.contains(id)) {
      _userLikedIds.remove(id);
      _specimens[index] = _specimens[index].copyWith(
        likeCount: (_specimens[index].likeCount - 1).clamp(0, 999999),
      );
    } else {
      _userLikedIds.add(id);
      _specimens[index] = _specimens[index].copyWith(
        likeCount: _specimens[index].likeCount + 1,
      );
    }

    _updatePopularCache();
    notifyListeners(); // Sekarang berhasil karena list tidak lagi immutable
  }

  void toggleBookmark(String id) {
    if (_bookmarkedDinoIds.contains(id)) {
      _bookmarkedDinoIds.remove(id);
    } else {
      _bookmarkedDinoIds.add(id);
    }
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> addSpecimen(DinoSpecimen dino) async {
    try {
      await _repository.insertSpecimen(dino);
      _specimens = await _repository.fetchSpecimens();
      notifyListeners();
    } catch (e) {
      debugPrint('Gagal menambah spesimen: $e');
      rethrow;
    }
  }
}