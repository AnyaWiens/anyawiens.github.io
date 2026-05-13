class Team {
  
  final String color;
  final int teamNumber;
  final String key;
  int? asteroidPoints;
  double? asteroidTimePoints;
  int? moonLanderPoints;
  double? moonLanderTimePoints;
  int? spaceWalkPoints;
  double? spaceWalkTimePoints;
  int? spaceSuitPoints;
  int? missionControlPoints;
  double totalPoints = 0;
  
  Team(
      {required this.color,
      required this.teamNumber,
      required this.key,
      this.asteroidPoints,
      this.asteroidTimePoints,
      this.moonLanderPoints,
      this.moonLanderTimePoints,
      this.spaceWalkPoints,
      this.spaceWalkTimePoints,
      this.spaceSuitPoints,
      this.missionControlPoints,
      this.totalPoints = 0,
      });
}