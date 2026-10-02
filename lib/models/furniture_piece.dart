import 'package:flutter/material.dart';

// Dolap/mobilya parçası.
// topCornerHeights: üst yüzeyin 4 köşesi için ayrı yükseklik (opsiyonel).
// null ise 4 köşe de `height` kullanır (düz üst yüzey).
// Sıra: [solÖn, sağÖn, solArka, sağArka] — parçanın kendi yerel eksenine
// göre, rotationDeg uygulanmadan önceki haliyle.
// Çatı eğimine göre kesilen üst dolaplarda kullanılır.
// Yan yüzeyler asla kesilmez/açılı olmaz — sadece üst yüzey.
class FurniturePiece {
  final String id;
  final String typeKey; // "alt-dolap", "üst-dolap", "tezgah" gibi
  final double width; // mm (x ekseni)
  final double depth; // mm (y ekseni)
  final double height; // mm, nominal/varsayılan yükseklik
  final List<double>? topCornerHeights; // 4 eleman, null = düz üst yüzey

  final Offset position; // taban düzlemindeki konumu (x, y), mm
  final double elevation; // zeminden yükseklik (z), mm
  final double rotationDeg;
  final String? snappedWallId; // yapıştığı duvar, yoksa null (serbest/ada)

  const FurniturePiece({
    required this.id,
    required this.typeKey,
    required this.width,
    required this.depth,
    required this.height,
    this.topCornerHeights,
    required this.position,
    this.elevation = 0,
    this.rotationDeg = 0,
    this.snappedWallId,
  }) : assert(
         topCornerHeights == null || topCornerHeights.length == 4,
         'topCornerHeights tam olarak 4 eleman içermeli',
       );

  FurniturePiece copyWith({
    String? typeKey,
    double? width,
    double? depth,
    double? height,
    List<double>? topCornerHeights,
    bool clearTopCornerHeights = false,
    Offset? position,
    double? elevation,
    double? rotationDeg,
    String? snappedWallId,
    bool clearSnappedWallId = false,
  }) {
    return FurniturePiece(
      id: id,
      typeKey: typeKey ?? this.typeKey,
      width: width ?? this.width,
      depth: depth ?? this.depth,
      height: height ?? this.height,
      topCornerHeights: clearTopCornerHeights
          ? null
          : (topCornerHeights ?? this.topCornerHeights),
      position: position ?? this.position,
      elevation: elevation ?? this.elevation,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      snappedWallId: clearSnappedWallId
          ? null
          : (snappedWallId ?? this.snappedWallId),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'typeKey': typeKey,
    'width': width,
    'depth': depth,
    'height': height,
    'topCornerHeights': topCornerHeights,
    'position': {'x': position.dx, 'y': position.dy},
    'elevation': elevation,
    'rotationDeg': rotationDeg,
    'snappedWallId': snappedWallId,
  };

  factory FurniturePiece.fromJson(Map<String, dynamic> json) {
    return FurniturePiece(
      id: json['id'],
      typeKey: json['typeKey'],
      width: (json['width'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      topCornerHeights: (json['topCornerHeights'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      position: Offset(
        (json['position']['x'] as num).toDouble(),
        (json['position']['y'] as num).toDouble(),
      ),
      elevation: (json['elevation'] as num?)?.toDouble() ?? 0,
      rotationDeg: (json['rotationDeg'] as num?)?.toDouble() ?? 0,
      snappedWallId: json['snappedWallId'],
    );
  }
}