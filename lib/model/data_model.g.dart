// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentformAdapter extends TypeAdapter<Studentform> {
  @override
  final int typeId = 1;

  @override
  Studentform read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentform(
      name: fields[1] as String?,
      number: fields[2] as String?,
      age: fields[3] as String?,
      mark: fields[4] as String?,
      profile: fields[5] as String?,
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, Studentform obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.mark)
      ..writeByte(5)
      ..write(obj.profile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentformAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
