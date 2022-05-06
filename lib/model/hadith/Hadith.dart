class Hadith {
  final int id;
  final String reference, hadith, searchTerm;

  const Hadith(
      {required this.id,
      required this.reference,
      required this.hadith,
      required this.searchTerm});

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
        id: json['id'],
        reference: json['reference'],
        hadith: json['hadith'],
        searchTerm: json['searchTerm']);
  }
}
