import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../signin_page/signin_page.dart';

Container logoutButton({required BuildContext context, required bool isMobileMode}) {
  return Container(
    color: isMobileMode ? const Color.fromARGB(255, 225, 237, 240) : null,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
                    (Route<dynamic> route) => false,
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
              MaterialButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(ProfileLoggedOutEvent());
                },
                color: Colors.white,
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.isFailure ?
            Padding(padding: const EdgeInsets.only(top: 8.0),
              child: Text(state.errorMessage,
                  style: const TextStyle(color: Colors.red)),
            ) : Container();
          },
        ),
      ],
    ),
  );
}