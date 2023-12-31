// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopModelAdapter extends TypeAdapter<ShopModel> {
  @override
  final int typeId = 0;

  @override
  ShopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopModel(
      id: fields[0] as String,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShopModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
