// 3 boyutlu nokta — mm cinsinden x, y, z koordinatları.
// x, y: taban düzlemi (plan görünümü), z: yükseklik (zeminden itibaren).
class Point3D {
  final double x;
  final double y;
  final double z;

  const Point3D({required this.x, required this.y, required this.z});

  Point3D copyWith({double? x, double? y, double? z}) {
    return Point3D(x: x ?? this.x, y: y ?? this.y, z: z ?? this.z);
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};

  factory Point3D.fromJson(Map<String, dynamic> json) {
    return Point3D(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      z: (json['z'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'Point3D($x, $y, $z)';
}