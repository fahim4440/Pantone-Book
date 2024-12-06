import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup/signup_bloc.dart';

class CompanyNameInput extends StatelessWidget {
  const CompanyNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (companyName) =>
              context.read<SignupBloc>().add(SignupCompanyNameChanged(companyName)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            errorText: !state.isValidCompanyName && state.companyName.isNotEmpty
                ? 'Give full company name'
                : null,
            prefixIcon: const Icon(Icons.work),
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
            labelText: "Company Name",
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