import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app/features/presentation/auth/widgets/custom_buttom.dart';
import 'package:note_app/features/presentation/auth/widgets/custum_form_field.dart';
import 'package:note_app/vallidator.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _image;

  void pickImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorStyle.surface,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                profilePic(),
                CustomFormField(
                  controller: namecontroller,
                  validator: (value) => MyValidators.namevalidator(value),
                  labelText: 'your Name',
                  labelStyle: textStyle.labelMedium,
                  fillColor:colorStyle.primary,
                ),
                CustomButton(name: namecontroller.text, imagePath: _image?.path,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profilePic() {
    return InkWell(
      onTap: pickImage,

      child: Stack(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.083,
            backgroundColor: Color(0xff000000),

            child: CircleAvatar(
              backgroundImage: _image != null ? FileImage(_image!) : null,
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: MediaQuery.of(context).size.height * 0.08,
              child: _image == null
                  ? Icon(
                      Icons.add_photo_alternate_rounded,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: MediaQuery.of(context).size.height * 0.08,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
