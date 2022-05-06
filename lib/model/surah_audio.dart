class AyahAudio {
  AyahAudio({
    required this.audio,
  });

  final String audio;

  factory AyahAudio.fromJson(Map<String, dynamic> json) => AyahAudio(
        audio: json["audio"],
      );
}
