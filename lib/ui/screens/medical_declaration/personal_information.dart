import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import '../../../logic/cubit/medical_declare/medical_declare_cubit.dart';

class PersonalInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MedicalDeclareCubit>(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                
                CustomTitle(title: 'user_id'),
                CustomInputField(
                    enabled: false,
                    hint: CacheHelper.getID().toString(),
                    validate: cubit.validateName),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTitle(title: 'full_name'),
                CustomInputField(
                    enabled: false,
                    hint: CacheHelper.getName(),
                    validate: cubit.validateName),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTitle(title: 'email'),
                CustomInputField(
                    enabled: false,
                    hint: CacheHelper.getEmail(),
                    validate: cubit.validateName),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
