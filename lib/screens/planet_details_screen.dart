import 'package:flutter/material.dart';
import '../core/app_text_styles.dart';
import '../models/planet.dart';
import '../widgets/action_circle_button.dart';
import '../widgets/planet_model_viewer.dart';
import '../widgets/space_app_bar.dart';

class PlanetDetailsScreen extends StatelessWidget {
  final Planet planet;
  const PlanetDetailsScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final stats = <MapEntry<String, String>>[
      MapEntry('Distance from Sun (km)', planet.distance),
      MapEntry('Length of Day (hours)', planet.day),
      MapEntry('Orbital Period (Earth years)', planet.orbit),
      MapEntry('Radius (km)', planet.radius),
      MapEntry('Mass (kg)', planet.mass),
      MapEntry('Gravity (m/s²)', planet.gravity),
      MapEntry('Surface Area (km²)', planet.area),
    ];

    return Scaffold(
      body: Column(
        children: [
          SpaceAppBar(
            height: 220,
            topTitle: planet.name,
            bottomTitle: planet.title,
            leading: ActionCircleButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlanetModelViewer(planet: planet),
                  const SizedBox(height: 16),
                  Text('About', style: AppText.heading),
                  const SizedBox(height: 8),
                  Text(planet.about, style: AppText.bodyLight),
                  const SizedBox(height: 16),
                  for (final s in stats)
                    Text('${s.key} : ${s.value}', style: AppText.stat),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}