import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePick;

  UserImagePicker(this.onImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    final PickedFile? pickedFile;

    try {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile!.path);
        });
        widget.onImagePick(_image!);
      } else {
        print('Nenhuma imagem selecionada');
      }
    } on PlatformException catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Adicionar imagem'),
        )
      ],
    );
  }
}
