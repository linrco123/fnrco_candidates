// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/models/management_content/faqs_model.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/data/api_provider/management_content/faqs.dart';

part 'faqs_state.dart';

class FAQsCubit extends Cubit<FAQsState> {
  FaqsProvider faqsProvider;
  FAQsCubit(
    this.faqsProvider,
  ) : super(FAQsInitial());

  void getFAQs() {
    emit(FAQsLoadingState());
    faqsProvider.getFAQs().then((value) {
      value.faq;
      emit(FAQsSuccessState(faqs:value.faq!));

    }).catchError((error) {

      emit(FAQsFailureState(message: error.failure.message));

    });
  }
}
