import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signin/signin_bloc.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<SigninBloc>().add(SigninEmailChanged(email: email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorText: !state.isValidEmail && state.email.isNotEmpty
                ? 'Invalid Email'
                : null,
            prefixIcon: const Icon(Icons.email_outlined),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 6.0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            focusColor: Colors.blueGrey,
            labelText: "Email",
            labelStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}