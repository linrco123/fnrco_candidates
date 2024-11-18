import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unregistered_state.dart';

class UnregisteredCubit extends Cubit<UnregisteredState> {
  UnregisteredCubit() : super(UnregisteredInitial());
}
