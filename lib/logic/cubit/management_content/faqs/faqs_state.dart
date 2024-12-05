part of 'faqs_cubit.dart';

@immutable
sealed class FAQsState {}

final class FAQsInitial extends FAQsState {}
final class FAQsLoadingState extends FAQsState{}

final class FAQsSuccessState extends FAQsState{
  final List<FAQ> faqs;

  FAQsSuccessState({required this.faqs});
}

final class FAQsFailureState extends FAQsState{
  final String message;

  FAQsFailureState({required this.message});
}