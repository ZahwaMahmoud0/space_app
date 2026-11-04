import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/planet.dart';
import '../services/planets_service.dart';
import '../widgets/action_circle_button.dart';
import '../widgets/red_button.dart';
import '../widgets/space_app_bar.dart';
import 'planet_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Planet>> _future = PlanetsService().fetchPlanets();

  void _retry() =>
      setState(() => _future = PlanetsService().fetchPlanets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Planet>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(color: kRed));
          }
          if (snap.hasError || snap.data == null || snap.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Failed to load planets',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    RedButton(title: 'Retry', onPressed: _retry),
                  ],
                ),
              ),
            );
          }
          return _PlanetsView(planets: snap.data!);
        },
      ),
    );
  }
}

class _PlanetsView extends StatefulWidget {
  final List<Planet> planets;
  const _PlanetsView({required this.planets});

  @override
  State<_PlanetsView> createState() => _PlanetsViewState();
}

class _PlanetsViewState extends State<_PlanetsView> {
  final _controller = PageController(viewportFraction: 0.55);
  int _index = 0;

  void _go(int i) {
    if (i < 0 || i >= widget.planets.length) return;
    _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planets = widget.planets;
    final planet = planets[_index];
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SpaceAppBar(
          topTitle: 'Explore',
          bottomTitle: 'Which planet\nwould you like to explore?',
        ),
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: planets.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double page = _index.toDouble();
                  if (_controller.hasClients &&
                      _controller.position.haveDimensions) {
                    page = _controller.page ?? page;
                  }
                  // 1 = في المنتصف (focus) ، 0 = بعيد
                  final t = (1 - (page - i).abs()).clamp(0.0, 1.0);
                  final scale = 0.7 + t * 0.55; // 0.7 → 1.25
                  final opacity = 0.5 + t * 0.5; // 0.5 → 1.0
                  return Center(
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.scale(scale: scale, child: child),
                    ),
                  );
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    planets[i].imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionCircleButton(
                icon: Icons.arrow_back,
                onPressed: () => _go(_index - 1),
              ),
              Text(planet.name, style: textTheme.titleLarge),
              ActionCircleButton(
                icon: Icons.arrow_forward,
                onPressed: () => _go(_index + 1),
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: RedButton(
              title: 'Explore ${planet.name}',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PlanetDetailsScreen(planet: planet),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}