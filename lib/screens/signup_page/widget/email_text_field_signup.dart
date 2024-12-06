import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';

class EmailInputSignup extends StatelessWidget {
  const EmailInputSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return TextField(
        onChanged: (email) =>
            context.read<SignupBloc>().add(SignupEmailChanged(email)),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorText: !state.isValidEmail && state.email.isNotEmpty
              ? 'Email is not valid'
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
              topLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
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
    });
  }
}