import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dino_news.dart';

class NewsService {
  static const String _endpoint =
      'https://jsonplaceholder.typicode.com/posts?_limit=8';

  static final _paleoMetadata = [
    {
      'title': 'Fosil Spinosaurus Semi-Akuatik Baru Ditemukan di Sahara Barat',
      'category': 'Ekspedisi Gurun',
      'source': 'National Geographic Society',
      'author': 'Dr. Nizar Ibrahim & Tim Ekspedisi Kem Kem',
      'date': '8 Nov 2026',
      'location': 'Kem Kem Beds, Maroko',
      'readTime': '4 min read',
      'summary':
          'Temuan tulang ekor berdayung pipih dan kepadatan tulang osteosklerotik membuktikan adaptasi perenang aktif Spinosaurus di sungai purba Sahara.',
      'content':
          'Ekspedisi gabungan internasional di lapisan Kem Kem Beds, perbatasan Maroko-Aljazair, berhasil mengekskavasi struktur vertebra ekor Spinosaurus aegyptiacus yang utuh. Struktur duri saraf memanjang membentuk sirip ekor vertikal menyerupai dayung amfibi modern.\n\nAnalisis tomografi densitas tulang menunjukkan fenomena pachyostosis dan osteosklerosis, yaitu pemadatan rongga tulang medula yang berfungsi sebagai ballast alami saat menyelam. Bukti anatomi ini membantah hipotesis lama bahwa Spinosaurus hanya pemburu di tepian air dangkal, melainkan predator perenang yang memburu ikan air tawar raksasa seperti Onchopristis dan Mawsonia.',
    },
    {
      'title': 'Analisis CT Scan Tengkorak T-Rex: Kekuatan Indra Sensorik Terkuak',
      'category': 'Riset Anatomi',
      'source': 'Journal of Vertebrate Paleontology',
      'author': 'Museum of the Rockies Research Group',
      'date': '6 Nov 2026',
      'location': 'Hell Creek Formation, Montana, AS',
      'readTime': '5 min read',
      'summary':
          'Pemindaian neuroanatomi 3D tengkorak T-Rex membuktikan proporsi lobus olfaktorius dan saraf trigeminal raksasa sebagai mesin pemburu tak tertandingi.',
      'content':
          'Studi rekonstruksi digital rongga tempurung otak (*endocast*) Tyrannosaurus rex menggunakan CT-Scan industri memperlihatkan bahwa bola penciuman (*olfactory bulbs*) menempati volume signifikan dari total volume otak. Ini mengonfirmasi daya endus T-Rex setara atau melampaui burung pembangkai modern.\n\nSelain itu, kanal saraf trigeminal di moncong memperlihatkan kepadatan jaringan sensor taktil yang amat sensitif di ujung rahang. Kombinasi mata binokular dengan sudut pandang stereoskopis 55 derajat dan kekuatan gigitan yang mencapai 35.000 hingga 57.000 Newton menjadikan dinosaurus ini predator aktif berdaya lacak dan berdaya hancur tertinggi.',
    },
    {
      'title': 'Sarang Telur Sauropoda Ditemukan Utuh di Formasi Djadokhta Mongolia',
      'category': 'Fosil Sarang',
      'source': 'Asian Paleontological Bulletin',
      'author': 'Mongolian Academy of Sciences',
      'date': '3 Nov 2026',
      'location': 'Gurun Gobi, Omnogovi, Mongolia',
      'readTime': '3 min read',
      'summary':
          'Ekskavasi mendalam menemukan formasi sarang telur berdiameter 2 meter dengan orientasi melingkar yang mengindikasikan perilaku koloni bertelur komunal.',
      'content':
          'Peneliti menemukan kluster 24 butir telur fosil sauropoda berbentuk bulat dengan cangkang berpori teratur di cekungan batu pasir merah Gurun Gobi. Cangkang telur memiliki pola mikrostruktur yang dirancang untuk difusi gas optimal di lingkungan pasir yang lembap.\n\nJarak antar sarang yang teratur dalam stratum geologi yang sama membuktikan bahwa dinosaurus herbivora raksasa ini kembali ke situs bersarang komunal yang sama selama beberapa generasi, menunjukkan perilaku sosial pengasuhan telur yang jauh lebih terorganisir dari perkiraan sebelumnya.',
    },
    {
      'title': 'Peta Mikrostruktur Bulu Velociraptor Menunjukkan Pigmen Warna Asli',
      'category': 'Teknologi Paleobiologi',
      'source': 'Prehistoric Science Review',
      'author': 'Institute of Vertebrate Paleontology, Beijing',
      'date': '1 Nov 2026',
      'location': 'Formasi Yixian, Liaoning',
      'readTime': '4 min read',
      'summary':
          'Mikroskop elektron pemindai mengungkap melanosom berbentuk rod dan bulat yang membuktikan gradasi pola warna gelap-terang pada bulu sayap theropoda.',
      'content':
          'Pemanfaatan Scanning Electron Microscopy (SEM) pada matriks karbon bulu di sekitar spesimen theropoda mengidentifikasi susunan organel sub-seluler pigmen melanosom. Bentuk eumelanosom silindris mengindikasikan warna hitam atau abu-abu gelap, sedangkan pheomelanosom bulat membuktikan rona merah-oranye.\n\nRekonstruksi warna ini menunjukkan bulu ekor dan sayap Velociraptor memiliki pola bergaris kontras yang kemungkinan besar digunakan sebagai sinyal komunikasi visual intraspesies, display kawin, atau kamuflase gurun pasir.',
    },
    {
      'title': 'Jejak Kaki Stegosaurus di Tebing Curam Mengonfirmasi Migrasi Berkelompok',
      'category': 'Jejak Fosil',
      'source': 'Global Geological Review',
      'author': 'European Association of Geoscientists',
      'date': '29 Okt 2026',
      'location': 'Semenanjung Iberia, Portugal',
      'readTime': '3 min read',
      'summary':
          'Trek fosil ichnology sejauh 80 meter menunjukkan formasi langkah kaki paralel antara spesimen dewasa dan anakan Stegosaurus.',
      'content':
          'Penelitian di tebing pantai batu pasir Jurassic Akhir mendokumentasikan lintasan jejak kaki dinosaurus (*trackway*) berukuran masif. Jejak menunjukkan cetakan kaki depan bertipe tapak semi-sirkular dan kaki belakang bertelapak tiga pendek.\n\nSusunan lintasan yang berjalan sejajar tanpa saling menimpa menandakan pergerakan kawanan herbivora terkoordinasi dalam mencari padang vegetasi paku dan konifer basah saat pergantian musim monsun Jurassic.',
    },
    {
      'title': 'Rekonstruksi Suara Dinosaurus Berdasarkan Tabung Rongga Udara Paruh Bebek',
      'category': 'Bioakustik Purba',
      'source': 'Nat Geo Sound Acoustics Lab',
      'author': 'Acoustic Paleobiology Consortium',
      'date': '25 Okt 2026',
      'location': 'Dinosaur Provincial Park, Alberta, Kanada',
      'readTime': '4 min read',
      'summary':
          'Simulasi resonansi fluida komputer pada jambul berongga Parasaurolophus menghasilkan vokalisasi frekuensi rendah infrasonik jarak jauh.',
      'content':
          'Model 3D saluran tabung jambul Parasaurolophus walkeri yang diekstraksi dari pemindaian digital diuji menggunakan simulasi dinamika fluida akustik. Tabung berliku sepanjang 1,8 meter ini berfungsi sebagai resonator akustik Helmholtz alami.\n\nFrekuensi resonansi dasar yang dihasilkan berada pada kisaran 30 hingga 120 Hertz. Gelombang suara bernada sangat rendah ini mampu merambat menembus tutupan kanopi hutan purba lebat sejauh bermil-mil tanpa teredam oleh vegetasi.',
    },
    {
      'title': 'Spesimen Ankylosaurus Terawetkan Sempurna Termasuk Lapisan Kulit Baju Besi',
      'category': 'Koleksi Museum',
      'source': 'Royal Tyrrell Museum of Palaeontology',
      'author': 'Dr. Caleb Brown & Konservasi Fosil',
      'date': '20 Okt 2026',
      'location': 'Millennium Mine, Fort McMurray, Kanada',
      'readTime': '5 min read',
      'summary':
          'Fosil "mumi" nodosaur Borealopelta ditemukan dalam wujud 3 dimensi utuh dengan lapisan keratin pelat pelindung dan sisa pigmen kamuflase perut.',
      'content':
          'Spesimen yang diawetkan melalui mineralisasi cepat di dasar laut kuno ini mempertahankan posisi orisinal tanpa gepeng (*uncompressed*). Sisik-sisik epidermal bertanduk masih melapisi lempeng osteoderm di bahu dan lehernya.\n\nPengujian kimia spektrometri massa pada lapisan luar mendeteksi konsentrasi pheomelanin di bagian dorsal tubuh namun absen di bagian ventral. Ini membuktikan pola pewarnaan *countershading* (punggung gelap, perut terang), membuktikan bahwa bahkan herbivora berlapis baja seberat 1,3 ton pun membutuhkan kamuflase untuk menghindari predator raksasa Late Cretaceous.',
    },
    {
      'title': 'Bukti Tabrakan Asteroid Chicxulub Ditemukan pada Partikel Kaca di Lapisan Tanah',
      'category': 'Transisi K-Pg',
      'source': 'Geological Horizons International',
      'author': 'International Continental Drilling Project',
      'date': '15 Okt 2026',
      'location': 'Situs Fosil Tanis, North Dakota, AS',
      'readTime': '6 min read',
      'summary':
          'Lapisan tektit mikroskopis dan anomali konsentrasi iridium mengonfirmasi gelombang seismik raksasa yang mengakhiri zaman dinosaurus 66 juta tahun lalu.',
      'content':
          'Deposit sedimen di situs Tanis mengungkap kronologi detik-detik pertama pasca tumbukan meteorit Chicxulub di Semenanjung Yucatán. Ditemukan tektit mikrosferul (butiran kaca batuan cair akibat suhu tabrakan yang memadat saat jatuh kembali dari stratosfer) yang terperangkap di insang fosil ikan purba Acipenseriformes.\n\nLapisan batuan ini bertepatan langsung dengan batas K-Pg (*Cretaceous-Paleogene Boundary*) yang kaya logam iridium langka, memberikan catatan waktu geologis paling presisi tentang peristiwa kepunahan massal yang menyapu 75% kehidupan di bumi.',
    },
  ];

  Future<List<DinoNews>> fetchNews() async {
    try {
      final response = await http
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> rawList = jsonDecode(response.body);

        return List<DinoNews>.generate(rawList.length, (index) {
          final post = rawList[index];
          final meta = _paleoMetadata[index % _paleoMetadata.length];

          return DinoNews(
            id: post['id'].toString(),
            title: meta['title']!,
            source: meta['source']!,
            author: meta['author']!,
            publishedAt: meta['date']!,
            location: meta['location']!,
            summary: meta['summary']!,
            content: meta['content']!,
            category: meta['category']!,
            readTime: meta['readTime']!,
          );
        });
      } else {
        throw Exception(
            'Gagal mengambil berita (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Kesalahan koneksi jaringan: $e');
    }
  }
}