import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';

class PasswordInputSignup extends StatefulWidget {
  const PasswordInputSignup({super.key});

  @override
  State<PasswordInputSignup> createState() => PasswordInputSignupState();
}

class PasswordInputSignupState extends State<PasswordInputSignup> {
  bool _showPassword = false;

  _toggleObscured() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return TextField(
        onChanged: (password) =>
            context.read<SignupBloc>().add(SignupPasswordChanged(password)),
        obscureText: !_showPassword,
        decoration: InputDecoration(
          errorText: !state.isValidPassword && state.password.isNotEmpty
              ? 'Password length must be at least 7'
              : null,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _showPassword ? Icons.visibility_rounded : Icons.visibility_off,
                size: 24,
              ),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 6.0),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          focusColor: Colors.blueGrey,
          labelText: "Password",
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