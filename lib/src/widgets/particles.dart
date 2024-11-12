import '../imports.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();
  List<Particle> particles = [];

  static const int numParticles = 20; // Número de partículas
  static const Color bluishGrey = Colours.secondary; // Color de las partículas
  static const Color whiteSmoke = Color(0xfff5f5f5); // Fondo

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    // Definir partículas distribuidas por toda la pantalla cuando el tamaño esté disponible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size screenSize = MediaQuery.of(context).size;
      _initializeParticles(screenSize);
    });

    _controller.addListener(() {
      setState(() {
        // Actualizar la posición de las partículas y hacerlas rebotar en los bordes
        for (var particle in particles) {
          particle.updatePosition();
          particle.checkBounds(
              Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
        }
      });
    });
  }

  void _initializeParticles(Size screenSize) {
    particles = [];
    for (int i = 0; i < numParticles; i++) {
      particles.add(
        Particle(
          // Posición inicial aleatoria en toda la pantalla
          position: Offset(
            random.nextDouble() * screenSize.width,
            random.nextDouble() * screenSize.height,
          ),
          // Velocidad aleatoria en ambas direcciones
          velocity: Offset(
            (random.nextDouble() * 2 - 1) * 3,
            (random.nextDouble() * 2 - 1) * 3,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainterSteal(particles),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});

  void updatePosition() {
    position += velocity;
  }

  // Verificar si las partículas están dentro de los límites de la pantalla y rebotarlas
  void checkBounds(Size screenSize) {
    if (position.dx <= 0 || position.dx >= screenSize.width) {
      velocity = Offset(-velocity.dx, velocity.dy); // Invertir la dirección en X
    }
    if (position.dy <= 0 || position.dy >= screenSize.height) {
      velocity = Offset(velocity.dx, -velocity.dy); // Invertir la dirección en Y
    }
  }
}

class ParticlePainterSteal extends CustomPainter {
  final List<Particle> particles;
  ParticlePainterSteal(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colours.main // Color bluishGrey para las partículas
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      canvas.drawCircle(particle.position, 4, paint); // Dibujar cada partícula
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}