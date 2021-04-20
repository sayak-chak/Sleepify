import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/errors/error-bloc/error_state.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  ErrorDialog({@required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ErrorBloc>(context),
      builder: (BuildContext context, ErrorState state) {
        if (state is DisplayError) {
          return Container(
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(errorMessage),
            ),
          );
        }
        return Container();
      },
    );
  }
}
