part of 'locale_cubit.dart';

@immutable
sealed class LocaleState {
  final Locale locale;

  LocaleState({required this.locale});
}

final class ChangeLocaleState extends LocaleState {
  ChangeLocaleState({required Locale locale}) : super(locale: locale);
}
