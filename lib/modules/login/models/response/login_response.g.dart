// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      roleId: fields[1] as int?,
      name: fields[2] as String?,
      phone: fields[3] as String?,
      address: fields[4] as String?,
      birthDate: fields[5] as String?,
      gender: fields[6] as String?,
      email: fields[7] as String?,
      username: fields[8] as String?,
      emailVerifiedAt: fields[9] as dynamic,
      createdAt: fields[10] as String?,
      updatedAt: fields[11] as String?,
      employeeId: fields[12] as int?,
      patientId: fields[13] as int?,
      accessCode: fields[14] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roleId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.birthDate)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.emailVerifiedAt)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.employeeId)
      ..writeByte(13)
      ..write(obj.patientId)
      ..writeByte(14)
      ..write(obj.accessCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
