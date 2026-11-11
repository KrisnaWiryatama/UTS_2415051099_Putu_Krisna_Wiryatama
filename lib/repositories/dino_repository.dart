import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dino_specimen.dart';

class DinoRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // 1. Ambil Semua Spesimen dari Supabase
  Future<List<DinoSpecimen>> fetchSpecimens() async {
    final response = await _client
        .from('specimens')
        .select()
        .order('name', ascending: true);

    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) {
      return DinoSpecimen(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        diet: json['diet']?.toString() ?? 'Herbivora',
        era: json['era']?.toString() ?? '',
        length: json['length']?.toString() ?? '',
        weight: json['weight']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        discoveredIn: json['discovered_in']?.toString() ?? '',
        likeCount: json['like_count'] is int ? json['like_count'] : 0,
      );
    }).toList();
  }

  // 2. Tambah Spesimen Baru (CREATE)
  Future<void> insertSpecimen(DinoSpecimen dino) async {
    await _client.from('specimens').insert({
      'id': dino.id,
      'name': dino.name,
      'diet': dino.diet,
      'era': dino.era,
      'length': dino.length,
      'weight': dino.weight,
      'description': dino.description,
      'discovered_in': dino.discoveredIn,
      'like_count': dino.likeCount,
    });
  }

  // 3. Perbarui Spesimen (UPDATE)
  Future<void> updateSpecimen(DinoSpecimen specimen) async {
    await _client
        .from('specimens') // <-- Ganti sesuai nama tabel yang ada di get/fetchSpecimens
        .update({
          'name': specimen.name,
          'era': specimen.era,
          'diet': specimen.diet,
          'discovered_in': specimen.discoveredIn,
          'length': specimen.length,
          'weight': specimen.weight,
          'description': specimen.description,
          'image_url': specimen.imageUrl,
        })
        .eq('id', specimen.id);
  }

  Future<void> deleteSpecimen(String id) async {
    await _client.from('specimens').delete().eq('id', id);
  }

  // 4. Update Jumlah Suka
  Future<void> updateLikes(String id, int newLikes) async {
    await _client
        .from('specimens')
        .update({'like_count': newLikes})
        .eq('id', id);
  }
}