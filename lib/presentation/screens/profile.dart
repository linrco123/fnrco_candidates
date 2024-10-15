import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/screens/profile_editing.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/profile/info.dart';
import 'package:fnrco_candidates/presentation/widgets/profile/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const ProfilePic(image: "assets/images/person1.jpg"),
            Text(
              "Annette Black",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 16.0 * 2),
            const Info(
              infoKey: "User ID",
              info: "@annette.me",
            ),
            const Info(
              infoKey: "Location",
              info: "New York, NYC",
            ),
            const Info(
              infoKey: "Phone",
              info: "(239) 555-0108",
            ),
            const Info(
              infoKey: "Email Address",
              info: "demo@mail.com",
            ),
            const SizedBox(height: 16.0),

            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 160,
                child: CustomElevatedButton(fun: (){
                         Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
                }, background: AppColors.primary, text: 'Edit Profile')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
