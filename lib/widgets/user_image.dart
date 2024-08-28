import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.pickedImage});

  final void Function(File pickedImage) pickedImage;
  
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickImageFile;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 140,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (pickedImage == null) return;
    setState(() {
      _pickImageFile = File(pickedImage.path);
    });
    widget.pickedImage(_pickImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickImageFile == null ? null : FileImage(_pickImageFile!),
        ),
        TextButton.icon(
          // onPressed: _pickImage,
          onPressed: (){},
          label: Text('ADD IMAGE'),
        ),
      ],
    );
  }
}
