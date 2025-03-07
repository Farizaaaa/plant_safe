import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plant_safe/model/image_info_model.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Saved Images")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ImageInfoModel>('imageInfoBox').listenable(),
        builder: (context, Box<ImageInfoModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child:
                  Text("No images saved yet", style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final imageInfo = box.getAt(index)!;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  tileColor: Theme.of(context).primaryColor,
                  leading: Image.memory(imageInfo.imageBytes,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(imageInfo.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Text(imageInfo.precaution,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await box.deleteAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Image deleted!")),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
