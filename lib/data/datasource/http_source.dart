import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For contentType
import 'package:mime/mime.dart'; // Opt

class HTTPHandler {
    Future<void> sendBlobToServer(Uint8List blobData, String fileName,String url) async {
    final uri = Uri.parse(url);

    // Detect the MIME type (optional)
    final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
    final mimeParts = mimeType.split('/');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file', // Field name on server
          blobData,
          filename: fileName,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ),
      );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print("Upload successful!");
      } else {
        print("Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }
}
