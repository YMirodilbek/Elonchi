import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_messages_event.dart';
part 'all_messages_state.dart';

class AllMessagesBloc extends Bloc<AllMessagesEvent, AllMessagesState> {
  AllMessagesBloc() : super(AllMessagesState(index: 0)) {
    on<ChangeMainIndex>(_onChangeMainIndex);
  }

  void _onChangeMainIndex(ChangeMainIndex event, Emitter<AllMessagesState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
