import 'package:hive/hive.dart';
part 'ayah.g.dart';

@HiveType(typeId: 1)
class Ayah extends HiveObject {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final int numberInSurah;

  Ayah({required this.text, required this.numberInSurah});
  factory Ayah.formJson(Map<String, dynamic> json) => Ayah(
        text: json['text'],
        numberInSurah: json['numberInSurah'],
      );
}
