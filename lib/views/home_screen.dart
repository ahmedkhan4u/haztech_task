import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:haztech_task/controllers/data_controller.dart';
import 'package:haztech_task/views/brewery_details_screen.dart';
import 'package:haztech_task/views/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'change_password.dart';

class HomeScreen extends StatelessWidget {
  final picker = ImagePicker();

  String scannedText = '';
  var textscanning = false.obs;
  pickImage(ImageSource source, context) async {
    XFile? selectedImage = await picker.pickImage(source: source);

    if (selectedImage == null) {
      return;
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    File file = File(croppedFile!.path);

    textscanning(true);

    getRecognisedText(file);
  }

  openMap() async {
    String url =
        'https://www.google.com/maps/place/Shaheen+town+BRT+Station/@33.9994582,71.4905993,17z/data=!4m5!3m4!1s0x38d917dc2b237c07:0xe6ac95b4e5ceffa8!8m2!3d33.9994538!4d71.4948265';
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void getRecognisedText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textscanning(false);
    Get.back();

    Get.defaultDialog(
        title: "Recognized Text is",
        content: Text(scannedText),
        actions: [
          MaterialButton(
            onPressed: () {
              Get.back();
            },
            child: Text("OK"),
          )
        ]);
  }

  DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    dataController.getBreweries();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Select option",
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          pickImage(ImageSource.camera, context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pickImage(ImageSource.gallery, context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            icon: Icon(Icons.camera_alt),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  openMap();
                },
                child: Text(
                  "Open Map",
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
                onPressed: () {
                  Get.to(() => ChangePasswordScreen());
                },
                child: Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white),
                )),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(() => LoginScreen());
                },
                icon: Icon(
                  Icons.logout,
                ))
          ],
        ),
        body: Obx(() => dataController.isBreweryLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  String name = dataController.breweries[i].name!;
                  String type = dataController.breweries[i].breweryType!;
                  return ListTile(
                    onTap: () {
                      Get.to(() => BreweryDetails(dataController.breweries[i]));
                    },
                    title: Text(name),
                    subtitle: Text(type),
                  );
                },
                itemCount: dataController.breweries.length,
              )));
  }
}
