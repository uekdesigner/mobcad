import 'wall_segment.dart';
import 'furniture_piece.dart';

// Bir çizimin tamamı: duvarlar + yerleştirilmiş dolap/mobilya parçaları.
class Room {
  final String id;
  final List<WallSegment> walls;
  final List<FurniturePiece> pieces;

  const Room({
    required this.id,
    this.walls = const [],
    this.pieces = const [],
  });

  Room copyWith({List<WallSegment>? walls, List<FurniturePiece>? pieces}) {
    return Room(
      id: id,
      walls: walls ?? this.walls,
      pieces: pieces ?? this.pieces,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'walls': walls.map((w) => w.toJson()).toList(),
    'pieces': pieces.map((p) => p.toJson()).toList(),
  };

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      walls: (json['walls'] as List? ?? [])
          .map((w) => WallSegment.fromJson(w))
          .toList(),
      pieces: (json['pieces'] as List? ?? [])
          .map((p) => FurniturePiece.fromJson(p))
          .toList(),
    );
  }
}