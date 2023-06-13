import 'package:molkky_match/utils/imports.dart';

class Player {
  int id;
  String name;

  Player({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
