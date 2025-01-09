import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../logic/cubit/medical_declare/medical_declare_cubit.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/date_picker_widget.dart';

class MedicalQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MedicalDeclareCubit>(context);
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                CacheHelper.getLang() == 'en'
                    ? cubit.mQuestions[cubit.currentQuestion].nameEn!
                    : cubit.mQuestions[cubit.currentQuestion].nameAr!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ],
        ),
        CustomDivider(),
        const SizedBox(
          height: 15.0,
        ),
        _getSuitableAnswerForm(
            context, cubit.mQuestions[cubit.currentQuestion].type!, cubit),
      ]),
    );
  }

  Widget _getSuitableAnswerForm(context, String type, dynamic cubit) {
    Widget widget = SizedBox();
    switch (type) {
      case 'text':
        widget = CustomInputField(
            hint: 'Enter your answer',
            linesNum: 5,
            autovalidateMode: true,
            controller: cubit.answerCntroller,
            inputType: TextInputType.text,
            validate: cubit.validateAnswer);
        break;

      case 'date':
        widget = CustomDatePicker(
            onTap: () {
              cubit.selectDate(context);
            },
            text: cubit.date.isEmpty ? 'Choose Date' : cubit.date);
        break;

      case 'radio':
        widget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile.adaptive(
                title: Text(
                  'yes',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                value: 'Yes',
                groupValue: cubit.switchAnswer,
                shape: Border.all(color: AppColors.primary),
                splashRadius: 10,
                onChanged: (value) => cubit.changeYesOrNo(value.toString())),
            const SizedBox(
              height: 20,
            ),
            RadioListTile.adaptive(
                title: Text(
                  'No',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                shape: Border.all(color: AppColors.primary),
                value: 'No',
                groupValue: cubit.switchAnswer,
                onChanged: (value) => cubit.changeYesOrNo(value.toString())),
          ],
        );
        break;
      default:
        widget = CustomInputField(
            hint: 'Enter your answer',
            linesNum: 5,
            autovalidateMode: true,
            controller: cubit.answerCntroller,
            inputType: TextInputType.text,
            validate: cubit.validateAnswer);
    }

    return widget;
  }
}
