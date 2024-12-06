import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';


class ErrorMessageSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return state.isFailure
            ? Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(state.errorMessage,
              style: const TextStyle(color: Colors.red)),
        )
            : Container();
      },
    );
  }
}