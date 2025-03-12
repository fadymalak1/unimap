class ClassModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String videoPath;
  bool isFavorite;

  ClassModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.videoPath,
    this.isFavorite = false,
  });

  factory ClassModel.fromMap(String id, Map<String, dynamic> data) {
    return ClassModel(
      id: id,
      nameEn: data['name_en'] ?? '',
      nameAr: data['name_ar'] ?? '',
      videoPath: data['video_path'] ?? '',
      isFavorite: data['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name_en': nameEn,
      'name_ar': nameAr,
      'video_path': videoPath,
      'is_favorite': isFavorite,
    };
  }
}
