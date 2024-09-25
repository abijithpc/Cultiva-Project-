// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

part of 'dashboard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class dashboardDataAdapter extends TypeAdapter<dashboardData> {
  @override
  final int typeId = 5;

  @override
  dashboardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return dashboardData()..totalProduct = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, dashboardData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.totalProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is dashboardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
