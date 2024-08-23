// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartdataAdapter extends TypeAdapter<Cartdata> {
  @override
  final int typeId = 3;

  @override
  Cartdata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cartdata(
      product: fields[0] as Product,
      sellinfo: fields[1] as Sellinfo?,
    );
  }

  @override
  void write(BinaryWriter writer, Cartdata obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.sellinfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartdataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
