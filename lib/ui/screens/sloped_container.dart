import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class SlopedContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary // Change to your desired color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(size.width, 0); // Move to the top right corner
    path.lineTo(size.width, size.height * 0.6); // Move down to 75% height
    path.lineTo(0, size.height / 2.1); // Move to the bottom left corner
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated
  }
}

class SlopedContainer extends StatelessWidget {
  final double height;
  final Widget widget;

  const SlopedContainer({Key? key, this.height = 200, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height), // Full width and specified height
      painter: SlopedContainerPainter(),
      child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.topCenter,
          child: widget),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary // Change to your desired color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height); // Bottom right corner
    path.lineTo(0, size.height); // Bottom left corner
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated
  }
}

class TriangleContainer extends StatelessWidget {
  final double height;
  final Widget widget;
  const TriangleContainer({Key? key, this.height = 200, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height), // Full width and specified height
      painter: TrianglePainter(),
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: widget,
      ),
    );
  }
}


class WavyContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary // Change to your desired color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height * 0.5); // Start at the bottom left
    path.quadraticBezierTo(
      size.width / 2, size.height*0.7, // Control point
      size.width, size.height * 0.6, // End point
    );
    path.lineTo(size.width, 0); // Move to the top right
    path.lineTo(0, 0); // Move to the top left
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated
  }
}

class WavyContainer extends StatelessWidget {
  final double height;
  final Widget widget;

  const WavyContainer({Key? key, this.height = 200, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height), // Full width and specified height
      painter: WavyContainerPainter(),
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: widget
      ),
    );
  }
}