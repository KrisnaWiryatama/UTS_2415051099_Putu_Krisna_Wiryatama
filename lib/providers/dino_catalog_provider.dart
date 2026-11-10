import 'package:flutter/foundation.dart';
import '../models/dino_specimen.dart';
import '../repositories/dino_repository.dart';

class DinoCatalogProvider extends ChangeNotifier {
  final DinoRepository _repository = DinoRepository();

  List<DinoSpecimen> _specimens = [];
  final Set<String> _bookmarkedIds = {};
  final Set<String> _likedIds = {};

  bool _isLoading = true;
  String? _errorMessage;

  String _searchQuery = '';
  String _selectedDiet = 'Semua';

  List<DinoSpecimen> get specimens => _specimens;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedDiet => _selectedDiet;

  DinoCatalogProvider() {
    loadDataFromSupabase();
  }

  Future<void> loadDataFromSupabase() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _specimens = await _repository.fetchSpecimens();
    } catch (e) {
      _errorMessage = 'Gagal memuat data dari Supabase: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cek apakah spesimen buatan sendiri
  bool isMySpecimen(String id) {
    return id.startsWith('sp_');
  }

  // Filter & Search
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedDiet(String diet) {
    _selectedDiet = diet;
    notifyListeners();
  }

  List<DinoSpecimen> get filteredSpecimens {
    return _specimens.where((dino) {
      final matchesDiet =
          _selectedDiet == 'Semua' || dino.diet == _selectedDiet;
      final matchesSearch =
          dino.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dino.era.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dino.discoveredIn.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDiet && matchesSearch;
    }).toList();
  }

  // Popular / Leaderboard
  List<DinoSpecimen> get popularSpecimens {
    final list = List<DinoSpecimen>.from(_specimens);
    list.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    return list;
  }

  // Favorites / Bookmarks
  List<DinoSpecimen> get bookmarkedSpecimens {
    return _specimens.where((d) => _bookmarkedIds.contains(d.id)).toList();
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }

  // Likes Handling
  bool isLiked(String id) => _likedIds.contains(id);

  Future<void> toggleLike(String dinoId) async {
    final index = _specimens.indexWhere((d) => d.id == dinoId);
    if (index == -1) return;

    int newLikes = _specimens[index].likeCount;
    if (_likedIds.contains(dinoId)) {
      _likedIds.remove(dinoId);
      newLikes = (newLikes > 0) ? newLikes - 1 : 0;
    } else {
      _likedIds.add(dinoId);
      newLikes += 1;
    }

    _specimens[index] = _specimens[index].copyWith(likeCount: newLikes);
    notifyListeners();

    try {
      await _repository.updateLikes(dinoId, newLikes);
    } catch (e) {
      debugPrint('Gagal sync like ke Supabase: $e');
    }
  }

  Future<void> incrementLike(String dinoId) async {
    await toggleLike(dinoId);
  }

  // CRUD Supabase
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

  Future<void> updateSpecimen(DinoSpecimen updatedDino) async {
    try {
      await _repository.updateSpecimen(updatedDino);
      final index = _specimens.indexWhere((d) => d.id == updatedDino.id);
      if (index != -1) {
        _specimens[index] = updatedDino;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Gagal mengupdate spesimen: $e');
      rethrow;
    }
  }

  Future<void> deleteSpecimen(String id) async {
    try {
      await _repository.deleteSpecimen(id);
      _specimens.removeWhere((d) => d.id == id);
      _bookmarkedIds.remove(id);
      _likedIds.remove(id);
      notifyListeners();
    } catch (e) {
      debugPrint('Gagal menghapus spesimen: $e');
      rethrow;
    }
  }
}