import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:plant_safe/model/image_info_model.dart';

class ImageDatabase {
  static final Box<ImageInfoModel> _imageBox =
      Hive.box<ImageInfoModel>('imageInfoBox');

  static Future<void> openBox() async {
    await Hive.openBox<ImageInfoModel>('imageInfoBox');
  }

  /// **Add an Image Entry**
  static Future<void> addImage(
      String name, Uint8List imageBytes, String precaution) async {
    final imageInfo = ImageInfoModel(
        name: name, imageBytes: imageBytes, precaution: precaution);
    await _imageBox.add(imageInfo);
  }

  /// **Update an Existing Entry**
  static Future<void> updateImage(
      int index, String name, Uint8List imageBytes, String precaution) async {
    if (index < _imageBox.length) {
      final updatedImageInfo = ImageInfoModel(
          name: name, imageBytes: imageBytes, precaution: precaution);
      await _imageBox.putAt(index, updatedImageInfo);
    }
  }

  /// **Delete an Image Entry**
  static Future<void> deleteImage(int index) async {
    if (index < _imageBox.length) {
      await _imageBox.deleteAt(index);
    }
  }

  /// **Get All Stored Images**
  static List<ImageInfoModel> getAllImages() {
    return _imageBox.values.toList();
  }
}
