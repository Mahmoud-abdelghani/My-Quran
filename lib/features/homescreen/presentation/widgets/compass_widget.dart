import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_direction/qibla_direction.dart';

class CompassWidget extends StatefulWidget {
  const CompassWidget({super.key});

  @override
  State<CompassWidget> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<CompassWidget> {
  double? qiblaAngle;
  bool setStateOption = true;

  @override
  void initState() {
    super.initState();
    getQiblaDirection();
  }

  Future<void> getQiblaDirection() async {
    final position = await Geolocator.getCurrentPosition();
    Coordinate user = Coordinate(position.latitude, position.longitude);
    if (setStateOption) {
      setState(() {
        qiblaAngle = QiblaDirection.find(user);
      });
    }
  }

  @override
  void dispose() async {
    super.dispose();
    setStateOption = !setStateOption;
  }

  @override
  Widget build(BuildContext context) {
    return qiblaAngle == null
        ? Expanded(child: Center(child: CircularProgressIndicator()))
        : Expanded(
            child: Center(
              child: StreamBuilder(
                stream: FlutterCompass.events,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.heading == null) {
                    return SizedBox();
                  }

                  double deviceAngle = snapshot.data!.heading!;
                  double angle = (qiblaAngle! - deviceAngle) * pi / 180;

                  return Center(
                    child: CustomPaint(
                      painter: _CompassPainter(angle, context),
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: Center(
                          child: Text(
                            "${deviceAngle.toStringAsFixed(0)}°",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class _CompassPainter extends CustomPainter {
  final double angle;
  BuildContext context;

  _CompassPainter(this.angle, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.43;

    final paintCircle = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final paintBorder = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    // Draw Qibla arrow
    final paintArrow = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.fill;

    double arrowLength = radius * 0.8;

    final arrowPath = Path();
    arrowPath.moveTo(center.dx, center.dy - arrowLength);
    arrowPath.lineTo(center.dx - 12, center.dy);
    arrowPath.lineTo(center.dx + 12, center.dy);
    arrowPath.close();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawPath(arrowPath, paintArrow);

    canvas.restore();

    // Draw North indicator
    final northPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;

    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy - radius + 20),
      northPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
