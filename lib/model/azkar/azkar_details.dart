class AzkarDetails {
  final int category_id;
  final String count, description, reference, content;

  const AzkarDetails({
    required this.category_id,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory AzkarDetails.fromJson(Map<String, dynamic> json) {
    return AzkarDetails(
      category_id: json['category_id'],
      count: json['count'],
      description: json['description'],
      reference: json['reference'],
      content: json['content'],
    );
  }
}
