class PrayModel {
  final String name;
  final String time;
  PrayModel({required this.name, required this.time});
  factory PrayModel.fromJson(Map<String, dynamic> json) {
    return PrayModel(name: json.keys.first, time: json[json.keys.first]);
  }
}
