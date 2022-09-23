import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:haztech_task/views/home_screen.dart';

class AuthController extends GetxController{


  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  var isUserLogin = false.obs;
  login(String email,String password)async{
    isUserLogin(true);
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password)
          .then((value){

           if(!value.user!.emailVerified){
             Get.snackbar('Warning', 'Please verify your email!');
             return;
           }


        Get.snackbar('Success', 'User loged in');
        Get.offAll(()=> HomeScreen());
      })
          .catchError((e)=> {
        Get.snackbar('Failed', '$e')
      });
    }catch(e){
      print("Something went wrong $e");
    }finally{
      isUserLogin(false);
    }
  }

  var isUserRegister = false.obs;
  register(String email,String password)async{
    isUserRegister(true);
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value)async{
        await value.user?.sendEmailVerification();
        Get.back();
        Get.snackbar('Verification Link sent', 'We have sent verification link to your email!');

      })
          .catchError((e)=> {
        Get.snackbar('Failed', '$e')
      });
    }catch(e){
      print("Something went wrong $e");
    }finally{
      isUserRegister(false);
    }
  }


  forgetPassword(String email){
    auth.sendPasswordResetEmail(email: email);
    Get.back();
    Get.snackbar('Link Sent', 'Please check your email to recover your password.');

  }


  var isPasswordChanging = false.obs;
  changePassword(String currentPassword, String newPassword)  {
    isPasswordChanging(true);
    try{
      User? user =  FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);

      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          Get.back();
          Get.snackbar('Password Changed', 'Password has been changed successfully.');
          //Success, do something
        }).catchError((error) {
          Get.snackbar('Password Incorrect', 'Password has been not been changed.');

          //Error, show something
        });
      }).catchError((err) {
        Get.snackbar('Password Incorrect', 'Password has been not been changed.');

      });
    }catch(e){
      Get.snackbar('Password Incorrect', 'Password has been not been changed.');

      print("Something went wrong! $e");
    }finally{
      isPasswordChanging(false);
    }

  }

}