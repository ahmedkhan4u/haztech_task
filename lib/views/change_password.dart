import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haztech_task/controllers/auth_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

 AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (String? input){
                  if(input!.isEmpty){
                    return '*required';
                  }


                  return null;
                },
                controller: oldPassword,
                decoration: InputDecoration(
                  hintText: 'Old Password',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (String? input){
                  if(input!.isEmpty){
                    return '*required';
                  }


                  return null;
                },
                controller: newPassword,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 20.0,),


              Obx(()=> authController.isPasswordChanging.value? Center(child: CircularProgressIndicator(),): MaterialButton(
                child: Text('Change Password'),
                color: Color(0xffEE7B23),
                onPressed: (){
                  if(!formKey.currentState!.validate()){
                    return;
                  }
                  authController.changePassword(oldPassword.text.trim(), newPassword.text.trim());
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
