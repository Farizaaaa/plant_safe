import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_safe/components/loginpage_text_field.dart';
import 'package:plant_safe/model/image_info_box.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
                tileColor: Theme.of(context).colorScheme.secondary,
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text('Open Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                tileColor: Theme.of(context).colorScheme.inversePrimary,
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

//----------------- Get User Email -----------------//
  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }


  //----------------- Save Image and Name to Hive -----------------//
  Future<void> _saveToHive() async {
    if (_image == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
            content: Text(
          'Please select an image and enter a name',
          style: TextStyle(color: Colors.white),
        )),
      );
      return;
    }

    Uint8List imageBytes = await _image!.readAsBytes();
    String email = await getUserEmail() ?? "";
    await ImageDatabase.addImage(email, _nameController.text, imageBytes, "");

    setState(() {
      _image = null;
      _nameController.clear();
    });

    
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
        'Image and Name Saved!',
        style: TextStyle(color: Colors.white),
      )),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/common.png",
                    ),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: size.width / 1.5,
                      height: size.height / 3.5,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10)),
                      child: _image != null
                          ? Image.file(_image!,
                            
                            fit: BoxFit.cover)
                          : const Icon(Icons.image,
                              size: 100, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    LoginpageTextField(
                      controller: _nameController,
                      hintText: "Enter name",
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: size.height / 13,
                          width: size.width / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: _openImagePicker,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Pick Image',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                const Icon(Icons.photo_library,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 13,
                          width: size.width / 4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: _saveToHive,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                               
                                const Icon(Icons.save_alt_sharp,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: size.height / 6,
                    width: size.width / 2,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Plant Safe",
                          style: GoogleFonts.lilitaOne(
                            shadows: [
                              const Shadow(
                                blurRadius: 10.0,
                                color: Color.fromARGB(255, 74, 202, 39),
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 14, 120, 8),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 18, // **Relative Scaling**
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
