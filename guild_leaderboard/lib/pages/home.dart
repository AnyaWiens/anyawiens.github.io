
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:guild_leaderboard/controllers/google_authenticator.dart';
import 'package:guild_leaderboard/controllers/leaderboard_controller.dart';
import 'package:guild_leaderboard/models/team.dart';
import 'package:guild_leaderboard/style/app_colors.dart';
import 'package:guild_leaderboard/style/screen_size.dart';
import 'package:guild_leaderboard/style/spacing.dart';
import 'package:toastification/toastification.dart';
import 'package:data_table_2/data_table_2.dart';


class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    LeaderboardController leaderboardController = Get.put(LeaderboardController());
    double headingTextMultiplier = 0.008;
    double textMultiplier = 0.007;
    return SafeArea(
      child: FutureBuilder(
        future: leaderboardController.initialize(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Obx(() => Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SizedBox(  
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Star
                              Icon(Icons.rocket_launch, color: selectedColor, size: screenHeight(context) * 0.05),
                              horizontalSpaceMedium,
                              Text(
                                "SAVE THE ASTRONAUTS LEADERBOARD",
                                style: TextStyle(fontWeight: FontWeight.bold, color: lightGrey, fontSize: screenHeight(context) * 0.04, shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: selectedColor,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                              ),
                              horizontalSpaceMedium,
                              //Star
                              Icon(Icons.rocket_launch, color: selectedColor, size: screenHeight(context) * 0.05),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05, vertical: screenHeight(context) * 0.02),
                        child: Container(
                          height: screenHeight(context) * 0.85,
                          child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: DataTable2(
                                  headingRowHeight: screenWidth(context) * headingTextMultiplier * 4.3,
                                  headingRowColor: WidgetStateProperty.all<Color>(lightGrey),
                                  border: TableBorder.symmetric(outside: BorderSide(color: lightGrey, width: 5)),
                                  dataRowColor: WidgetStateProperty.all<Color>(textPrimaryColor.withValues(alpha: 0.1)),
                                  columnSpacing: screenWidth(context) * 0.02,
                                  columns: [
                                    DataColumn2(label: Text(''), size: ColumnSize.S, numeric: true),
                                    DataColumn(label: Text('Team', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier))),
                                    DataColumn(label: Text('Asteroid Points', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier))),
                                    DataColumn(label: Text('Time Bonus', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier))),
                                    DataColumn(label: Text('Moon Lander \nPoints', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier), textAlign: TextAlign.center)),
                                    DataColumn(label: Text('Time Bonus', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier))),
                                    DataColumn(label: Text('Space Walk \nPoints', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier), textAlign: TextAlign.center)),
                                    DataColumn(label: Text('Time Bonus', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier))),
                                    DataColumn(label: Text('Space Suit \nPoints', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier), textAlign: TextAlign.center)),
                                    DataColumn(label: Text('Mission Control \nPoints', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier), textAlign: TextAlign.center)),
                                    DataColumn2(label: Text('Total Points', style: TextStyle(fontWeight: FontWeight.bold, color: textPrimaryColor, fontSize: screenWidth(context) * headingTextMultiplier)), size: ColumnSize.S),
                                    // Add more columns as needed
                                  ],
                                  rows: leaderboardController.sortedTeams.map((team) => DataRow(
                                    cells: [
                                      DataCell(Text("${leaderboardController.sortedTeams.indexOf(team) + 1}.", style: TextStyle(fontWeight: FontWeight.bold, color: lightGrey, fontSize: screenWidth(context) * headingTextMultiplier))),
                                      DataCell(Text("${team.color}-${team.teamNumber}", style: TextStyle(fontWeight: FontWeight.bold, color: lightGrey, fontSize: screenWidth(context) * headingTextMultiplier))),
                                      DataCell(Text(team.asteroidPoints != null ? team.asteroidPoints.toString() : "0", style: TextStyle(color: team.asteroidPoints != null && team.asteroidPoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.asteroidTimePoints != null ? team.asteroidTimePoints.toString() : "0", style: TextStyle(color: team.asteroidTimePoints != null && team.asteroidTimePoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.moonLanderPoints != null ? team.moonLanderPoints.toString() : "0", style: TextStyle(color: team.moonLanderPoints != null && team.moonLanderPoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.moonLanderTimePoints != null ? team.moonLanderTimePoints.toString() : "0", style: TextStyle(color: team.moonLanderTimePoints != null && team.moonLanderTimePoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.spaceWalkPoints != null ? team.spaceWalkPoints.toString() : "0", style: TextStyle(color: team.spaceWalkPoints != null && team.spaceWalkPoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.spaceWalkTimePoints != null ? team.spaceWalkTimePoints.toString() : "0", style: TextStyle(color: team.spaceWalkTimePoints != null && team.spaceWalkTimePoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.spaceSuitPoints != null ? team.spaceSuitPoints.toString() : "0", style: TextStyle(color: team.spaceSuitPoints != null && team.spaceSuitPoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * textMultiplier))),
                                      DataCell(Text(team.missionControlPoints != null ? team.missionControlPoints.toString() : "0", style: TextStyle(color: team.missionControlPoints != null && team.missionControlPoints! > 0 ? selectedColor : mediumGrey, fontSize: screenWidth(context) * headingTextMultiplier))),
                                      DataCell(Text(
                                        team.totalPoints.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, color: selectedColor, fontSize: screenWidth(context) * headingTextMultiplier),
                                      )),
                                      // Add more cells as needed
                                    ],
                                  )).toList(),
                                ),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          );
        }
      ),
    );
  }
}