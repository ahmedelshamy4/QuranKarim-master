class Elder {
  const Elder({
    required this.identifier,
    required this.name,
  });

  final String identifier;
  final String name;

  factory Elder.fromJson(Map<String, dynamic> json) => Elder(
        identifier: json["identifier"],
        name: json["name"],
      );
}
