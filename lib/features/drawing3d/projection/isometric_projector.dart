import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../models/point3d.dart';

// Oda köşelerinden hangisinden bakıldığını belirleyen 4 sabit preset.
// theta değeri, modelin ekrana izdüşümden önce döndürüleceği açı (derece).
enum IsoCameraPreset {
  onSol(45),
  onSag(135),
  arkaSol(315),
  arkaSag(225);

  final double thetaDeg;
  const IsoCameraPreset(this.thetaDeg);
}

// 3D (mm) koordinatları 2D ekran koordinatına (piksel) çeviren
// standart izometrik izdüşüm. Sahneyi hiç döndürmeyiz — sadece
// 4 sabit preset arasında geçiş yaparız (theta değiştirerek).
class IsometricProjector {
  final IsoCameraPreset preset;
  final double scale; // mm -> px ölçek çarpanı
  final Offset screenOrigin; // ekranda (0,0,0) noktasının düşeceği piksel

  IsometricProjector({
    required this.preset,
    required this.scale,
    required this.screenOrigin,
  });

  static const double _isoAngle = 30 * math.pi / 180;

  Offset project(Point3D p) {
    final thetaRad = preset.thetaDeg * math.pi / 180;

    // 1) Yatay düzlemde (x, y) döndürme — hangi köşeden bakıldığını belirler
    final xr = p.x * math.cos(thetaRad) - p.y * math.sin(thetaRad);
    final yr = p.x * math.sin(thetaRad) + p.y * math.cos(thetaRad);

    // 2) Standart izometrik izdüşüm (30°) — 2D ekran koordinatına çevirir
    final isoX = (xr - yr) * math.cos(_isoAngle);
    final isoY = (xr + yr) * math.sin(_isoAngle) - p.z;

    return Offset(
      screenOrigin.dx + isoX * scale,
      screenOrigin.dy + isoY * scale,
    );
  }
}