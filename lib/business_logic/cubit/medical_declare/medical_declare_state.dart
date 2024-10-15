part of 'medical_declare_cubit.dart';

@immutable
sealed class MedicalDeclareState {}

final class MedicalDeclareInitial extends MedicalDeclareState {}

final class MedicalDeclarePickListRadionItemState extends MedicalDeclareState {}
