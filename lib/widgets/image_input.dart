import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectedImage});

  final void Function(File image) onSelectedImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    // final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
    _selectedImage = File(pickedImage.path);      
    });
    widget.onSelectedImage(_selectedImage!);
  }

  void _chooseImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
    _selectedImage = File(pickedImage.path);      
    });
    widget.onSelectedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(Icons.camera),
          label: const Text("Take Picture"),
        ),
         Text("OR", style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
         ),),
        TextButton.icon(
          onPressed: _chooseImage,
          icon: const Icon(Icons.folder),
          label: const Text("Choose from Galary"),
        ),
      ],
    );

    if (_selectedImage != null) {
      content = Stack(
        children: [
          Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          bottom: 8,
          right: 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer),
            onPressed: () {
            setState(() {
              _selectedImage = null;
            });
          }, child: const Text("Cancel"),
          ),
        ),
        ],
        
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
