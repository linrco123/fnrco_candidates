import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_contacts_state.dart';

class GetContactsCubit extends Cubit<GetContactsState> {
  GetContactsCubit() : super(GetContactsInitial());
}
