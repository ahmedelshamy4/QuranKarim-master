import 'package:hive/hive.dart';
import 'package:quran_karim/model/ayah/ayah.dart';
part 'surah.g.dart';

@HiveType(typeId: 0)
class Surah extends HiveObject {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String revelationType;
  @HiveField(3)
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.revelationType,
    required this.ayahs,
  });
  factory Surah.formJson(Map<String, dynamic> json) => Surah(
        number: json['number'],
        name: json['name'],
        revelationType: json['revelationType'],
        ayahs: List<Ayah>.from(
          json['ayahs'].map(
            (map) => Ayah.formJson(map),
          ),
        ),
      );
}
