import 'package:http/http.dart' as http;

class AudioRepository {
  Future<String> fetchAudioFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return url;
      } else {
        throw Exception('Failed to load audio');
      }
    } catch (e) {
      throw Exception('Error fetching audio: $e');
    }
  }
}
