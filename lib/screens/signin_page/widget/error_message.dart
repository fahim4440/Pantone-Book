import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signin/signin_bloc.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
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