import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';
import '../../signin_page/signin_page.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Verification email is sent. Verify the email before sign in.',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninPage()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              }
          );
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
          MaterialButton(
            onPressed: () {
              context.read<SignupBloc>().add(SignupSubmitted());
            },
            color: Colors.blueGrey,
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white,),
            ),
          );
        },
      ),
    );
  }
}
