// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardDataAdapter extends TypeAdapter<DashboardData> {
  @override
  final int typeId = 5;

  @override
  DashboardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardData(
      totalProduct: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DashboardData obj) {
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
      other is DashboardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
