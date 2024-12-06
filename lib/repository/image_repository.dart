import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/color_picker_from_image.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {
  Future<void> pickImageFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File compressedImage = await compressAndResizeImage(image);
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => ColorPickerFromImage(compressedImage),));
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File compressedImage = await compressAndResizeImage(image);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ColorPickerFromImage(compressedImage)));
    }
  }

  Future<File> compressAndResizeImage(File file) async {
    img.Image? image = img.decodeImage(file.readAsBytesSync());

    // Resize the image to have the longer side be 800 pixels
    int width;
    int height;

    if (image!.width > image.height) {
      width = 800;
      height = (image.height / image.width * 800).round();
    } else {
      height = 800;
      width = (image.width / image.height * 800).round();
    }

    img.Image resizedImage = img.copyResize(image, width: width, height: height);

    // Compress the image with JPEG format
    List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);  // Adjust quality as needed

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();
    final compressedFilePath = '${tempDir.path}/compressed_image.jpg';

    // Save the compressed image to a file
    File compressedFile = File(compressedFilePath);
    compressedFile.writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = preferences.getBool('loggedIn');
    if (isLoggedIn == null) {
      return false;
    } else {
      return isLoggedIn;
    }
  }

  Future<String?> getUserNameFromSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');
    return name;
  }

  Future<void> launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ahmadul244@gmail.com',
    );
    await launchUrl(emailUri);
  }

  Future<void> launchLinkedIn() async {
    const url = 'https://www.linkedin.com/in/ahmadul-ferdous';
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  Future<void> launchFacebook() async {
    const url = 'https://www.facebook.com/ahmadul.fahim';
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}