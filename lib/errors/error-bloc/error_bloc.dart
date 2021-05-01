import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/errors/error-bloc/error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(null);

  @override
  Stream<ErrorState> mapEventToState(ErrorEvent event) async* {
    if (event is NewError) {
      yield DisplayError(errorMessage: event.errorMessage);
    } else {
      yield NoError();
    }
  }
}
