import 'point3d.dart';

// Duvar segmenti — 4 köşe noktasıyla (alt-üst × başlangıç-bitiş) tanımlı.
// Bu yapı sayesinde düz dikey duvar, açılı duvar ve çatı eğimi gibi
// yatık duvarların hepsi aynı veri yapısıyla ifade edilebiliyor.
// Dikey bir duvarda topStart, bottomStart'ın tam üstündedir;
// eğik bir duvarda (çatı arası gibi) x/y değerleri kayar.
class WallSegment {
  final String id;
  final Point3D bottomStart;
  final Point3D bottomEnd;
  final Point3D topStart;
  final Point3D topEnd;
  final double thickness; // mm

  const WallSegment({
    required this.id,
    required this.bottomStart,
    required this.bottomEnd,
    required this.topStart,
    required this.topEnd,
    required this.thickness,
  });

  // Düz dikey duvar için kolaylık constructor'ı —
  // sadece taban çizgisi ve yükseklik vererek duvar oluşturur.
  factory WallSegment.vertical({
    required String id,
    required Point3D bottomStart,
    required Point3D bottomEnd,
    required double height,
    required double thickness,
  }) {
    return WallSegment(
      id: id,
      bottomStart: bottomStart,
      bottomEnd: bottomEnd,
      topStart: bottomStart.copyWith(z: bottomStart.z + height),
      topEnd: bottomEnd.copyWith(z: bottomEnd.z + height),
      thickness: thickness,
    );
  }

  WallSegment copyWith({
    Point3D? bottomStart,
    Point3D? bottomEnd,
    Point3D? topStart,
    Point3D? topEnd,
    double? thickness,
  }) {
    return WallSegment(
      id: id,
      bottomStart: bottomStart ?? this.bottomStart,
      bottomEnd: bottomEnd ?? this.bottomEnd,
      topStart: topStart ?? this.topStart,
      topEnd: topEnd ?? this.topEnd,
      thickness: thickness ?? this.thickness,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'bottomStart': bottomStart.toJson(),
    'bottomEnd': bottomEnd.toJson(),
    'topStart': topStart.toJson(),
    'topEnd': topEnd.toJson(),
    'thickness': thickness,
  };

  factory WallSegment.fromJson(Map<String, dynamic> json) {
    return WallSegment(
      id: json['id'],
      bottomStart: Point3D.fromJson(json['bottomStart']),
      bottomEnd: Point3D.fromJson(json['bottomEnd']),
      topStart: Point3D.fromJson(json['topStart']),
      topEnd: Point3D.fromJson(json['topEnd']),
      thickness: (json['thickness'] as num).toDouble(),
    );
  }
}