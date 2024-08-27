
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl;

  ApiClient(this._baseUrl);

  Future<http.Response> post(String path, Map<String, dynamic> body, {Map<String, String>? headers, File? file}) async {
    final url = Uri.parse('$_baseUrl$path');
    print('Posting to: $url');
    print('Request body: ${jsonEncode(body)}');
    if (file != null) {
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(body.map((key, value) => MapEntry(key, value.toString())))
        ..files.add(await http.MultipartFile.fromPath('registration_proof', file.path));

      var response = await request.send();
      return await http.Response.fromStream(response);
    } else {
      return await http.post(
        url,
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    }
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final url = Uri.parse('$_baseUrl$path');
    return await http.get(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
    );
  }

// You can add more methods like PUT, DELETE, etc. here
}
