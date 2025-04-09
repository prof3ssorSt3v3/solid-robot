import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class People extends ChangeNotifier {
  //constructor
  People() {
    getPeople();
  }

  List<String>? _names;
  Map<String, dynamic>? _complex;
  //private members for storage

  List<String>? get names => _names;
  Map<String, dynamic>? get complex => _complex;
  //public getter for access

  //read from shared preferences
  Future<void> getPeople() async {
    SharedPreferencesAsync prefs =
        await SharedPreferencesAsync();

    List<String> starterData = [
      'Bob',
      'Tina',
      'Louise',
      'Teddy',
      'Gene',
      'Linda',
    ];
    await prefs.setStringList('listOfNames', starterData);
    _names = await prefs.getStringList('listOfNames');

    String str = jsonEncode({'name': 'Archer'});
    await prefs.setString('mapData', str);

    String dataStr = await prefs.getString('mapData') ?? '';
    _complex = jsonDecode(dataStr);

    notifyListeners();

    // String jsonStr = json.encode(items);
    // _names = json.decode(items)
  }
}
