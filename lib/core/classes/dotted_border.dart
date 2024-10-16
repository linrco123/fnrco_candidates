import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class DottedBorderPainter extends CustomPainter {
      @override
      void paint(Canvas canvas, Size size) {
        final paint = Paint()
          ..color = AppColors.primary
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
    
        final double dashWidth = 5; // Width of each dash
        final double dashSpace = 5; // Space between each dash
    
        double startX = 0;
        while (startX < size.width) {
          canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
          startX += dashWidth + dashSpace;
        }
    
        // Draw right border
        double startY = 0;
        while (startY < size.height) {
          canvas.drawLine(
            Offset(size.width, startY),
            Offset(size.width, startY + dashWidth),
            paint,
          );
          startY += dashWidth + dashSpace;
        }
    
        // Draw bottom border
        startX = 0;
        while (startX < size.width) {
          canvas.drawLine(
            Offset(startX, size.height),
            Offset(startX + dashWidth, size.height),
            paint,
          );
          startX += dashWidth + dashSpace;
        }
    
        // Draw left border
        startY = 0;
        while (startY < size.height) {
          canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
          startY += dashWidth + dashSpace;
        }
        
    
      }
      
        @override
        bool shouldRepaint(covariant CustomPainter oldDelegate) {
          return true;
        }

}



// class DottedBorderPainter extends CustomPainter {
//   final double radius;
//   final double dashLength;
//   final double dashSpace;
//   final Color color;

//   DottedBorderPainter({
//     required this.radius,
//     required this.dashLength,
//     required this.dashSpace,
//     required this.color,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     // Create a path with rounded corners
//     final path = Path()
//       ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)));

//     // Draw the dotted border
//     double totalLength = 0.0;
//     while (totalLength < path.computeMetrics().first.length) {
//       path.computeMetrics().first.extractPath(totalLength, totalLength + dashLength).forEach((segment) {
//         canvas.drawPath(segment, paint);
//       });
//       totalLength += dashLength + dashSpace;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// extension on Path {
//   void forEach(Null Function(dynamic segment) param0) {}
// }