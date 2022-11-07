// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenresAdapter extends TypeAdapter<Genres> {
  @override
  final int typeId = 0;

  @override
  Genres read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Genres(
      genres: (fields[0] as List?)?.cast<Genre>(),
    );
  }

  @override
  void write(BinaryWriter writer, Genres obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
    };
