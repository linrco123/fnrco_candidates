// // import 'package:flutter/material.dart';
// // import '../constants/app_colors.dart';

// // class TestScreen extends StatefulWidget {
// //   const TestScreen({super.key});

// //   @override
// //   State<TestScreen> createState() => _TestScreenState();
// // }

// // class _TestScreenState extends State<TestScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     List<String> items = ['Item 1', 'Item 2', 'Item 3'];
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'TestScreen',
// //           style: Theme.of(context).textTheme.headlineLarge,
// //         ),
// //         backgroundColor: AppColors.white,
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Column(
// //           children: [

// //             Text('test' , key: UniqueKey()),
            
// //             Expanded(
// //               child: ReorderableListView(
// //                 onReorder: (oldIndex, newIndex) {
// //                   if (newIndex > oldIndex) {
// //                     newIndex -= 1;
// //                   }
// //                   setState(() {
// //                     final item = items.removeAt(oldIndex);
// //                     items.insert(newIndex, item);
// //                   });
// //                 },
// //                 children: items.map((item) {
// //                   return ListTile(
// //                     key: Key('$item'),
// //                     title: Text(item),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({required Key key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     )..repeat();
//   }

//   Animatable<Color> background = TweenSequence<Color>([
//     TweenSequenceItem(
//       weight: 1.0,
//       tween: ColorTween(
//         begin: Colors.red,
//         end: Colors.green,
//       ),
//     ),
//     TweenSequenceItem(
//       weight: 1.0,
//       tween: ColorTween(
//         begin: Colors.green,
//         end: Colors.blue,
//       ),
//     ),
//     TweenSequenceItem(
//       weight: 1.0,
//       tween: ColorTween(
//         begin: Colors.blue,
//         end: Colors.pink,
//       ),
//     ),
//   ]);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Scaffold(
//             body: Container(
//               color: background.evaluate(AlwaysStoppedAnimation(_controller.value)),
//             ),
//           );
//         });
//   }
// }