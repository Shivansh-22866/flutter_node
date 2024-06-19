import 'dart:convert';
import 'dart:developer';

import 'package:frontend/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://flutter-node-1.onrender.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var res = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(res.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var res = await http.delete(requestUri, body: note.toMap());
    var decoded = jsonDecode(res.body);
    log(decoded.toString());
  }
}
