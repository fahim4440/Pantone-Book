import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/bloc/homepage/homepage_bloc.dart';
import 'package:pantone_book/bloc/search_color/color_search_bloc.dart';
import 'package:pantone_book/bloc/signin/signin_bloc.dart';
import 'screens/homepage/homepage.dart';
import 'bloc/color_picker/color_picker_bloc.dart';
import 'screens/signin_page/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'bloc/signup/signup_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/check_logged_in/check_logged_in_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => ColorPickerBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => HomepageBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => SignupBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => SigninBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => ProfileBloc()..add(ProfilePageEnterEvent()),
      ),
    ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CheckLoggedInBloc()..add(const CheckLoggedInEvent()),
        child: BlocBuilder<CheckLoggedInBloc, CheckLoggedInState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return Homepage(name: state.name,);
            } else if (state is LoggedOutState) {
              return const SigninPage();
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}


// import 'dart:io';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// void main() {
//   // Load the Excel file
//   File file = File('assets/Pantone_RGB.xlsx');
//   List<int> fileBytes = file.readAsBytesSync();
//
//   // Encrypt the Excel file
//   final key = encrypt.Key.fromUtf8('e7f8G2J9xA3mW5nK8dQ1rT6vB4yP0zZ2');  // AES-256 requires a 32-character key
//   final iv = encrypt.IV.fromLength(16);  // Initialization vector
//
//   final encrypter = encrypt.Encrypter(encrypt.AES(key));
//   final encrypted = encrypter.encryptBytes(fileBytes, iv: iv);
//
//   // Save the encrypted file
//   File('assets/encrypted_excel.enc').writeAsBytesSync(encrypted.bytes);
//   print('done');
// }

