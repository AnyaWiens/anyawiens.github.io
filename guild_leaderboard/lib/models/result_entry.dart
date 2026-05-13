import 'package:json_annotation/json_annotation.dart';

part 'result_entry.g.dart';

@JsonSerializable()
class ResultEntry{
  final String color;
  final int teamNumber;
  final String mission;
  final int? asteroidPoints;
  final int? moonLanderPoints;
  final int? spaceWalkPoints;
  final int? spaceSuitPoints;
  final int? missionControlPoints;
  final DateTime? timestamp;
  
  ResultEntry(
    {required this.color,
      required this.teamNumber,
      required this.mission,
      this.asteroidPoints,
      this.moonLanderPoints,
      this.spaceWalkPoints,
      this.spaceSuitPoints,
      this.missionControlPoints,
      this.timestamp,
    }
  );

  factory ResultEntry.fromJson(Map<String, dynamic> json) => _$ResultEntryFromJson(json);
  Map<String, dynamic> toJson() => _$ResultEntryToJson(this);
}