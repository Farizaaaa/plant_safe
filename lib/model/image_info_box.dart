import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:plant_safe/model/image_info_model.dart';

class ImageDatabase {
  static final Box<ImageInfoModel> _imageBox =
      Hive.box<ImageInfoModel>('imageInfoBox');

  static Future<void> openBox() async {
    await Hive.openBox<ImageInfoModel>('imageInfoBox');
  }

  /// **Add an Image Entry using "email - imagename" as the Key**
  static Future<void> addImage(
      String email, String name, Uint8List imageBytes,
      String precaution) async {
    final key = "$email - $name"; // Unique key for each image
    final imageInfo = ImageInfoModel(
        name: name, imageBytes: imageBytes, precaution: precaution);
    await _imageBox.put(key, imageInfo);
  }

  /// **Update an Existing Entry**
  static Future<void> updateImage(
      String email, String name,
      Uint8List imageBytes, String precaution) async {
    final key = "$email - $name"; // Ensure update is for the correct image
    if (_imageBox.containsKey(key)) {
      final updatedImageInfo = ImageInfoModel(
          name: name, imageBytes: imageBytes, precaution: precaution);
      await _imageBox.put(key, updatedImageInfo);
    }
  }

  /// **Delete an Image Entry**
  static Future<void> deleteImage(String email, String name) async {
    final key = "$email - $name";
    if (_imageBox.containsKey(key)) {
      await _imageBox.delete(key);
    }
  }

  /// **Get All Stored Images**
  static List<ImageInfoModel> getAllImages() {
    return _imageBox.values.toList();
  }

  /// **Get Images for a Specific User**
  static List<ImageInfoModel> getUserImages(String email) {
    return _imageBox.keys
        .where((key) => key.startsWith("$email - ")) // Filter by user email
        .map((key) => _imageBox.get(key)!)
        .toList();
  }
}
