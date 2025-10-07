import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';
import 'package:note_app/features/presentation/auth/widgets/custum_form_field.dart';
import 'package:note_app/vallidator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _image;
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorStyle.surface,
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              context.go('/home');
            } else if (state is UserError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is UserLoading;

            return Center(
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.1,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 35,
                    children: [
                      _buildProfilePic(),
                      CustomFormField(
                        controller: nameController,
                        validator: (value) => MyValidators.namevalidator(value),
                        labelText: 'Your Name',
                        labelStyle: textStyle.labelMedium,
                        fillColor: colorStyle.primary,
                      ),
                      _buildGetStartedButton(
                        context,
                        isLoading,
                        textStyle,
                        colorStyle,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfilePic() {
    return InkWell(
      onTap: pickImage,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.083,
        backgroundColor: const Color(0xff000000),
        child: CircleAvatar(
          backgroundImage: _image != null ? FileImage(_image!) : null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: MediaQuery.of(context).size.height * 0.08,
          child: _image == null
              ? Icon(
                  Icons.add_photo_alternate_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  size: MediaQuery.of(context).size.height * 0.08,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(
    BuildContext context,
    bool isLoading,
    TextTheme textStyle,
    ColorScheme colorStyle,
  ) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () async {
              // التحقق من صحة النموذج
              if (_formKey.currentState?.validate() ?? false) {
                // قراءة القيمة عند الضغط على الزر
                final name = nameController.text.trim();

                if (name.isNotEmpty) {
                  await context.read<UserCubit>().loginUser(
                    name: name,
                    profilPic: _image?.path,
                  );
                }
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: colorStyle.primaryContainer,
        minimumSize: const Size(330, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(width: 2),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text('Get Started', style: textStyle.bodyLarge),
    );
  }
}
