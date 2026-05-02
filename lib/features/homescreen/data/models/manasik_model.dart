class ManasikModel {
  final String title;
  final String location;
  final String description;
  final List<String> steps;
  final String image;
  final String duaArabic;
  ManasikModel({
    required this.title,
    required this.location,
    required this.description,
    required this.steps,
    required this.image,
    required this.duaArabic,
  });
  factory ManasikModel.fromJson(Map<String, dynamic> json) {
    return ManasikModel(
      title: json['title'],
      location: json['location'],
      description: json['short_description'],
      steps: List<String>.from(json['steps']),
      image: json['image'],
      duaArabic: json['dua']['arabic'],
    );
  }
}
