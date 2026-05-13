// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultEntry _$ResultEntryFromJson(Map<String, dynamic> json) => ResultEntry(
  color: json['Color'] as String,
  teamNumber: (json['Number'] as num).toInt(),
  mission: json['Mission'] as String,
  asteroidPoints: (json['Asteroid Points'] is num) ? (json['Asteroid Points'] as num).toInt() : null,
  moonLanderPoints: (json['Moon Lander Points'] is num) ? (json['Moon Lander Points'] as num).toInt() : null,
  spaceWalkPoints: (json['Space Walk Points'] is num) ? (json['Space Walk Points'] as num).toInt() : null,
  spaceSuitPoints: (json['Space Suit Points'] is num) ? (json['Space Suit Points'] as num).toInt() : null,
  missionControlPoints: (json['Mission Control Points'] is num) ? (json['Mission Control Points'] as num).toInt() : null,
  timestamp: json['Time'] != null ? DateTime.parse(json['Time'] as String) : null,
);

Map<String, dynamic> _$ResultEntryToJson(ResultEntry instance) =>
    <String, dynamic>{
      'color': instance.color,
      'teamNumber': instance.teamNumber,
      'mission': instance.mission,
      'asteroidPoints': instance.asteroidPoints,
      'moonLanderPoints': instance.moonLanderPoints,
      'spaceWalkPoints': instance.spaceWalkPoints,
      'spaceSuitPoints': instance.spaceSuitPoints,
      'missionControlPoints': instance.missionControlPoints,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
