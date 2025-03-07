import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_safe/model/image_info_box.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();


  //----------------- Open Image Picker -----------------//
  Future<void> _openImagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                tileColor: Colors.green,
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text('Open Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                tileColor: Colors.green,
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text('Open Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //----------------- Pick Image -----------------//
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //----------------- Save Image and Name to Hive -----------------//
  Future<void> _saveToHive() async {
    if (_image == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select an image and enter a name')),
      );
      return;
    }

    Uint8List imageBytes = await _image!.readAsBytes();

    await ImageDatabase.addImage(_nameController.text, imageBytes, "dhjjhuhg");

    setState(() {
      _image = null;
      _nameController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image and Name Saved!')),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Home Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common.png"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              _image != null
                  ? Image.file(_image!,
                      width: size.width / 2,
                      height: size.height / 3,
                      fit: BoxFit.cover)
                  : const Icon(Icons.image, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
          
                 
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
          
            
              ElevatedButton(
                onPressed: _openImagePicker,
                child: const Text('Pick Image (Camera/Gallery)'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveToHive,
                child: const Text('Save to Hive'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
