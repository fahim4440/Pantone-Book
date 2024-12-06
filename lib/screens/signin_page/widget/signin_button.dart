import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signin/signin_bloc.dart';
import '../../homepage/homepage.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (state.isEmailVerified) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Homepage(name: state.email,)),
                  (Route<dynamic> route) => false,
            );
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Email is not verified.',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          context.read<SigninBloc>().add(SigninResendEmailVerificationEvent());
                          Navigator.of(context).pop();
                        },
                        child: const Text('Resend Email'),
                      ),
                    ],
                  );
                }
            );
          }
        }
      },
      child: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
          MaterialButton(
            onPressed: () async {
              context.read<SigninBloc>().add(SigninSubmitted());
            },
            color: Colors.blueGrey,
            child: const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}