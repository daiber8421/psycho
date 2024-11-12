import '../imports.dart';

class ParticleStelaBackground extends StatefulWidget {
  const ParticleStelaBackground({super.key});

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleStelaBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();
  List<Particle> particles = [];

  static const int numParticles = 15; // Número de partículas
  static const Color bluishGrey = Colours.lightNavyBlue; // Color de las partículas
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
            (random.nextDouble() * 2 - 1) * 2,
            (random.nextDouble() * 2 - 1) * 2,
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
      painter: ParticlePainter(particles),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;
  List<Offset> trail = []; // Almacenar las posiciones anteriores para la estela

  Particle({required this.position, required this.velocity});

  void updatePosition() {
    // Agregar la posición actual a la lista de estela
    trail.add(position);
    if (trail.length > 8) { // Limitar la longitud de la estela
      trail.removeAt(0);
    }
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

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colours.lightNavyBlue // Color bluishGrey para las partículas
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      // Dibujar la estela para cada partícula
      for (int i = 0; i < particle.trail.length; i++) {
        // Ajustar la opacidad de la estela según su antigüedad
        double opacity = (i + 1) / particle.trail.length;
        paint.color = Colours.lightNavyBlue.withOpacity(opacity);
        canvas.drawCircle(particle.trail[i], 3, paint);
      }

      // Dibujar la partícula actual
      paint.color = Colours.lightNavyBlue; // Restaurar color completo
      canvas.drawCircle(particle.position, 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}