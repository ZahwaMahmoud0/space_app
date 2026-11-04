class Planet {
  final String name, png, model, title, about;
  final String distance, day, orbit, radius, mass, gravity, area;

  const Planet({
    required this.name,
    required this.png,
    required this.model,
    required this.title,
    required this.about,
    required this.distance,
    required this.day,
    required this.orbit,
    required this.radius,
    required this.mass,
    required this.gravity,
    required this.area,
  });


  factory Planet.fromRow(List<String> r) {
    String v(int i) => r[i].trim();
    return Planet(
      name: v(0),
      png: v(1),
      model: v(2),
      title: v(3),
      about: v(4),
      distance: v(5),
      day: v(6),
      orbit: v(7),
      radius: v(8),
      mass: v(9),
      gravity: v(10),
      area: v(11),
    );
  }

  String get imagePath => 'assets/images/$png';
  String get modelPath => 'assets/models/$model';
}