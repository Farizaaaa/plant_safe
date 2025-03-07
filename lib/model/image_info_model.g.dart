// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageInfoModelAdapter extends TypeAdapter<ImageInfoModel> {
  @override
  final int typeId = 1;

  @override
  ImageInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageInfoModel(
      name: fields[0] as String,
      imageBytes: fields[1] as Uint8List,
      precaution: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageInfoModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageBytes)
      ..writeByte(2)
      ..write(obj.precaution);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
