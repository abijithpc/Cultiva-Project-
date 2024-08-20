// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellinfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellinfoAdapter extends TypeAdapter<Sellinfo> {
  @override
  final int typeId = 2;

  @override
  Sellinfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sellinfo(
      customerName: fields[0] as String?,
      customerNumber: fields[1] as String?,
      product: fields[2] as String?,
      quantity: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Sellinfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.customerName)
      ..writeByte(1)
      ..write(obj.customerNumber)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellinfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
