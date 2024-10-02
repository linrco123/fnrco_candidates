import 'package:flutter/material.dart';
import 'package:fnrco_candidates/app_router.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(const FnrcoCandidates());
}

class FnrcoCandidates extends StatelessWidget {
  const FnrcoCandidates({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FNRCO CANDIDATES',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.routeTo,
      initialRoute: AppPagesNames.INITIAL,
    );
  }
}
