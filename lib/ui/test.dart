import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TestScreen',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            Text('test' , key: UniqueKey()),
            
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  setState(() {
                    final item = items.removeAt(oldIndex);
                    items.insert(newIndex, item);
                  });
                },
                children: items.map((item) {
                  return ListTile(
                    key: Key('$item'),
                    title: Text(item),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
