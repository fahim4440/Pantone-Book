import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';


class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (username) =>
              context.read<SignupBloc>().add(SignupUsernameChanged(username)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            errorText: !state.isValidName && state.username.isNotEmpty
                ? 'Give full name'
                : null,
            prefixIcon: const Icon(Icons.person),
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
            labelText: "Full Name",
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