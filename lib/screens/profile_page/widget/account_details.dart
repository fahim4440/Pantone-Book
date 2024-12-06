import 'package:flutter/material.dart';
import 'package:pantone_book/bloc/profile/profile_bloc.dart';

Column accountDetails(BuildContext context, ProfilePageEnterState state, bool isMobileMode) {
  return Column(
    mainAxisAlignment: isMobileMode ? MainAxisAlignment.start : MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isMobileMode ? const SizedBox(height: 20.0,) : SizedBox.shrink(),
      Text("Account Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
      SizedBox(height: 20),
      Text("Name: ${state.user.name}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      Text("Email: ${state.user.email}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      Text("Company: ${state.user.companyName}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
    ],
  );
}