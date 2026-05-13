import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guild_leaderboard/controllers/google_authenticator.dart';
import 'package:guild_leaderboard/models/result_entry.dart';
import 'package:guild_leaderboard/models/team.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';


class LeaderboardController extends GetxController {
  List<ResultEntry> entries = [];
  GoogleController googleController = Get.put(GoogleController());
  Map<String, Team> teams = {};
  RxList<Team> sortedTeams = <Team>[].obs;
  List<bool> bonusAsteroid = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> bonusMoonLander = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> bonusSpaceWalk = [false, false, false, false, false, false, false, false, false, false, false, false];

  Future<void> initialize() async {
    try {
      entries = await googleController.loadInResults();
      entries.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      await createLeaderboard();
      startUpdates();
    } catch (e) {
      print('Error loading results: $e');
    }
  }

  Future<void> createLeaderboard() async {
    bonusAsteroid = [false, false, false, false, false, false, false, false, false, false, false, false];
    bonusMoonLander = [false, false, false, false, false, false, false, false, false, false, false, false];
    bonusSpaceWalk = [false, false, false, false, false, false, false, false, false, false, false, false];
    for (var entry in entries) {
      String teamKey = "${entry.color}${entry.teamNumber}";
      if (!teams.containsKey(teamKey)) {
        teams[teamKey] = Team(
          key: teamKey,
          color: entry.color,
          teamNumber: entry.teamNumber,
          asteroidPoints: entry.asteroidPoints,
          moonLanderPoints: entry.moonLanderPoints,
          spaceWalkPoints: entry.spaceWalkPoints,
          spaceSuitPoints: entry.spaceSuitPoints,
          missionControlPoints: entry.missionControlPoints,
          totalPoints: ((entry.asteroidPoints ?? 0) + (entry.moonLanderPoints ?? 0) + (entry.spaceWalkPoints ?? 0) + (entry.spaceSuitPoints ?? 0) + (entry.missionControlPoints ?? 0)).toDouble(),
        );
      } else {
        updateExistingTeam(entry);
      }
      checkForBonuses(teams[teamKey]!);  
    }
    sortedTeams.clear();
    sortedTeams.addAll(teams.values.toList());
    sortedTeams.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
  }

  void updateExistingTeam(ResultEntry entry) {
    String teamKey = "${entry.color}${entry.teamNumber}";
    Team newTeam = teams[teamKey]!;
    if (entry.asteroidPoints != null && entry.asteroidPoints! > (newTeam.asteroidPoints ?? 0)) {
      newTeam.asteroidPoints = entry.asteroidPoints;
    }
    if (entry.moonLanderPoints != null && entry.moonLanderPoints! > (newTeam.moonLanderPoints ?? 0)) {
      newTeam.moonLanderPoints = entry.moonLanderPoints;
    }
    if (entry.spaceWalkPoints != null && entry.spaceWalkPoints! > (newTeam.spaceWalkPoints ?? 0)) {
      newTeam.spaceWalkPoints = entry.spaceWalkPoints;
    }
    if (entry.spaceSuitPoints != null && entry.spaceSuitPoints! > (newTeam.spaceSuitPoints ?? 0)) {
      newTeam.spaceSuitPoints = entry.spaceSuitPoints;
    }
    if (entry.missionControlPoints != null && entry.missionControlPoints! > (newTeam.missionControlPoints ?? 0)) {
      newTeam.missionControlPoints = entry.missionControlPoints;
    }
    newTeam.totalPoints = ((newTeam.asteroidPoints ?? 0) + (newTeam.moonLanderPoints ?? 0) + (newTeam.spaceWalkPoints ?? 0) + (newTeam.spaceSuitPoints ?? 0) + (newTeam.missionControlPoints ?? 0)).toDouble();
    teams[teamKey] = newTeam;
  }

  void checkForBonuses(Team team) {
    if (team.asteroidPoints != null && team.asteroidPoints! == 11) {
      if (!bonusAsteroid[0]) {
        bonusAsteroid[0] = true;
        team.asteroidTimePoints = 3;
      } else if (!bonusAsteroid[1]) {
        bonusAsteroid[1] = true;
        team.asteroidTimePoints = 2.75;
      } else if (!bonusAsteroid[2]) {
        bonusAsteroid[2] = true;
        team.asteroidTimePoints = 2.5;
      } else if (!bonusAsteroid[3]) {
        bonusAsteroid[3] = true;
        team.asteroidTimePoints = 2.25;
      } else if (!bonusAsteroid[4]) {
        bonusAsteroid[4] = true;
        team.asteroidTimePoints = 2;
      } else if (!bonusAsteroid[5]) {
        bonusAsteroid[5] = true;
        team.asteroidTimePoints = 1.75;
      } else if (!bonusAsteroid[6]) {
        bonusAsteroid[6] = true;
        team.asteroidTimePoints = 1.5;
      } else if (!bonusAsteroid[7]) {
        bonusAsteroid[7] = true;
        team.asteroidTimePoints = 1.25;
      } else if (!bonusAsteroid[8]) {
        bonusAsteroid[8] = true;
        team.asteroidTimePoints = 1;
      } else if (!bonusAsteroid[9]) {
        bonusAsteroid[9] = true;
        team.asteroidTimePoints = 0.75;
      } else if (!bonusAsteroid[10]) {
        bonusAsteroid[10] = true;
        team.asteroidTimePoints = 0.5;
      } else if (!bonusAsteroid[11]) {
        bonusAsteroid[11] = true;
        team.asteroidTimePoints = 0.25;
      }
      team.totalPoints += team.asteroidTimePoints ?? 0;
      teams[team.key] = team;
    }

    if (team.moonLanderPoints != null && team.moonLanderPoints! == 20) {
      if (!bonusMoonLander[0]) {
        bonusMoonLander[0] = true;
        team.moonLanderTimePoints = 3;
      } else if (!bonusMoonLander[1]) {
        bonusMoonLander[1] = true;
        team.moonLanderTimePoints = 2.75;
      } else if (!bonusMoonLander[2]) {
        bonusMoonLander[2] = true;
        team.moonLanderTimePoints = 2.5;
      } else if (!bonusMoonLander[3]) {
        bonusMoonLander[3] = true;
        team.moonLanderTimePoints = 2.25;
      } else if (!bonusMoonLander[4]) {
        bonusMoonLander[4] = true;
        team.moonLanderTimePoints = 2;
      } else if (!bonusMoonLander[5]) {
        bonusMoonLander[5] = true;
        team.moonLanderTimePoints = 1.75;
      } else if (!bonusMoonLander[6]) {
        bonusMoonLander[6] = true;
        team.moonLanderTimePoints = 1.5;
      } else if (!bonusMoonLander[7]) {
        bonusMoonLander[7] = true;
        team.moonLanderTimePoints = 1.25;
      } else if (!bonusMoonLander[8]) {
        bonusMoonLander[8] = true;
        team.moonLanderTimePoints = 1;
      } else if (!bonusMoonLander[9]) {
        bonusMoonLander[9] = true;
        team.moonLanderTimePoints = 0.75;
      } else if (!bonusMoonLander[10]) {
        bonusMoonLander[10] = true;
        team.moonLanderTimePoints = 0.5;
      } else if (!bonusMoonLander[11]) {
        bonusMoonLander[11] = true;
        team.moonLanderTimePoints = 0.25;
      }
      team.totalPoints += team.moonLanderTimePoints ?? 0;
      teams[team.key] = team;
    }

    if (team.spaceWalkPoints != null && team.spaceWalkPoints! == 24) {
      if (!bonusSpaceWalk[0]) {
        print("3 pts");
        bonusSpaceWalk[0] = true;
        team.spaceWalkTimePoints = 3;
        print(bonusSpaceWalk);
      } else if (!bonusSpaceWalk[1]) {
        print("2.75 pts");
        bonusSpaceWalk[1] = true;
        team.spaceWalkTimePoints = 2.75;
        print(bonusSpaceWalk);
      } else if (!bonusSpaceWalk[2]) {
        print("2.5 pts");
        bonusSpaceWalk[2] = true;
        team.spaceWalkTimePoints = 2.5;
        print(bonusSpaceWalk);
      } else if (!bonusSpaceWalk[3]) {
        print("2.25 pts");
        bonusSpaceWalk[3] = true;
        team.spaceWalkTimePoints = 2.25;
        print(bonusSpaceWalk);
      } else if (!bonusSpaceWalk[4]) {
        bonusSpaceWalk[4] = true;
        team.spaceWalkTimePoints = 2;
      } else if (!bonusSpaceWalk[5]) {
        bonusSpaceWalk[5] = true;
        team.spaceWalkTimePoints = 1.75;
      } else if (!bonusSpaceWalk[6]) {
        bonusSpaceWalk[6] = true;
        team.spaceWalkTimePoints = 1.5;
      } else if (!bonusSpaceWalk[7]) {
        bonusSpaceWalk[7] = true;
        team.spaceWalkTimePoints = 1.25;
      } else if (!bonusSpaceWalk[8]) {
        bonusSpaceWalk[8] = true;
        team.spaceWalkTimePoints = 1;
      } else if (!bonusSpaceWalk[9]) {
        bonusSpaceWalk[9] = true;
        team.spaceWalkTimePoints = 0.75;
      } else if (!bonusSpaceWalk[10]) {
        bonusSpaceWalk[10] = true;
        team.spaceWalkTimePoints = 0.5;
      } else if (!bonusSpaceWalk[11]) {
        bonusSpaceWalk[11] = true;
        team.spaceWalkTimePoints = 0.25;
      }
      team.totalPoints += team.spaceWalkTimePoints ?? 0;
      teams[team.key] = team;
    }
  }

  void startUpdates() {
    Future.delayed(Duration(seconds: 30), () async {
      try {
        List<ResultEntry> newEntries = await googleController.loadInResults();
        if (newEntries.length != entries.length) {
          entries = newEntries;
          entries.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
          await createLeaderboard();
        }
      } catch (e) {
        print('Error loading results: $e');
      }
      startUpdates();
    });
  }
}
