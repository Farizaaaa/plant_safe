import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plant_safe/model/image_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  //----------------- Load User Email -----------------//
  Future<void> _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/common.png",
                  ),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<ImageInfoModel>('imageInfoBox').listenable(),
              builder: (context, Box<ImageInfoModel> box, _) {
                if (userEmail == null) {
                  return const Center(
                    child:
                        CircularProgressIndicator(), // Show loading while email is fetched
                  );
                }

                //----------------- Get User Images -----------------//
                final userImages = box.keys
                    .where((key) => key.toString().startsWith("$userEmail - "))
                    .map((key) => box.get(key)!)
                    .toList();

                if (userImages.isEmpty) {
                  return const Center(
                    child: Text("No images saved yet",
                        style: TextStyle(fontSize: 18)),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: userImages.length,
                  itemBuilder: (context, index) {
                    final imageInfo = userImages[index];

                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      elevation: 4,
                      surfaceTintColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          // **Image at the top**
                          Positioned.fill(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: Image.memory(
                                      imageInfo.imageBytes,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        imageInfo.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        imageInfo.precaution,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //----------------- Delete Image -----------------//
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await box
                                    .delete("$userEmail - ${imageInfo.name}");
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Image deleted!")),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
