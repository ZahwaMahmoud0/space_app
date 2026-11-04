import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet.dart';

class PlanetsService {
  static const _url =
      'https://docs.google.com/spreadsheets/d/1orEbD314Q0TBNlGAtd1f6ja0JFLhuwgjDVe2wJvcFNQ/export?format=csv';

  Future<List<Planet>> fetchPlanets() async {
    final res = await http.get(Uri.parse(_url));
    if (res.statusCode != 200) {
      throw Exception('Failed to load data (${res.statusCode})');
    }
    final rows = _parseCsv(utf8.decode(res.bodyBytes));
    return rows
        .skip(1) 
        .where((r) => r.length >= 12 && r[0].trim().isNotEmpty)
        .map(Planet.fromRow)
        .toList();
  }

  
  List<List<String>> _parseCsv(String text) {
    final rows = <List<String>>[];
    var row = <String>[];
    final field = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < text.length; i++) {
      final c = text[i];
      if (inQuotes) {
        if (c == '"') {
          if (i + 1 < text.length && text[i + 1] == '"') {
            field.write('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          field.write(c);
        }
      } else {
        if (c == '"') {
          inQuotes = true;
        } else if (c == ',') {
          row.add(field.toString());
          field.clear();
        } else if (c == '\n' || c == '\r') {
          if (c == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
          row.add(field.toString());
          field.clear();
          rows.add(row);
          row = [];
        } else {
          field.write(c);
        }
      }
    }
    if (field.isNotEmpty || row.isNotEmpty) {
      row.add(field.toString());
      rows.add(row);
    }
    return rows;
  }
}