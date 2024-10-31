import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestScreenh extends StatefulWidget {
  const TestScreenh({super.key});

  @override
  State<TestScreenh> createState() => _TestScreenhState();
}

class _TestScreenhState extends State<TestScreenh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
          backgroundColor: AppColors.primary,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200.0,
                height: 100.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.red,
                  highlightColor: Colors.yellow,
                  child: Text(
                    'Shimmer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            Card(
              child: ListTile(
                title: Text('Item number 1 as title'),
                subtitle: Text('Subtitle here'),
                trailing: Skeleton.unite(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit, size: 32),
                      SizedBox(width: 8),
                      Icon(Icons.access_alarm, size: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
