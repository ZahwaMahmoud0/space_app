import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import '../core/constants.dart';
import '../models/planet.dart';

class PlanetModelViewer extends StatefulWidget {
  final Planet planet;
  const PlanetModelViewer({super.key, required this.planet});

  @override
  State<PlanetModelViewer> createState() => _PlanetModelViewerState();
}

class _PlanetModelViewerState extends State<PlanetModelViewer> {
  final _controller = Flutter3DController();
  bool _loaded = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Flutter3DViewer(
            controller: _controller,
            src: widget.planet.modelPath,
            activeGestureInterceptor: true,
            progressBarColor: kRed,
            onLoad: (_) {
              if (mounted) setState(() => _loaded = true);
            },
            onError: (e) {
              debugPrint('3D error: $e');
              if (mounted) setState(() => _error = e);
            },
          ),
          
          if (!_loaded)
            IgnorePointer(
              child: Container(
                color: kBlack,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Image.asset(
                        widget.planet.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '3D failed: $_error',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: kRed, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}