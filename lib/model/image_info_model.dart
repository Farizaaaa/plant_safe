import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'image_info_model.g.dart';

@HiveType(typeId: 1)
class ImageInfoModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  Uint8List imageBytes;

  @HiveField(2)
  String precaution;

  ImageInfoModel({
    required this.name,
    required this.imageBytes,
    required this.precaution,
  });
}
