import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guild_leaderboard/models/result_entry.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';


class GoogleController extends GetxController {

  String? clientId = "932985464512-67ms6omv3kobn75rhm9dqhnv521k5grf.apps.googleusercontent.com";
  String? serverClientId = "932985464512-67ms6omv3kobn75rhm9dqhnv521k5grf.apps.googleusercontent.com";
  List<String> scopes = <String>[
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  String _errorMessage = '';
  String _serverAuthCode = '';

  Future<void> signIn() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    unawaited(
      signIn.initialize(clientId: clientId).then((
        _,
      ) {
        signIn.authenticationEvents
            .listen(_handleAuthenticationEvent)
            .onError(_handleAuthenticationError);

        /// This example always uses the stream-based approach to determining
        /// which UI state to show, rather than using the future returned here,
        /// if any, to conditionally skip directly to the signed-in state.
        signIn.attemptLightweightAuthentication();
      }),
    );
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    // #docregion CheckAuthorization
    final GoogleSignInAccount? user = // ...
    // #enddocregion CheckAuthorization
    switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    // Check for existing authorization.
    // #docregion CheckAuthorization
    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);
    // #enddocregion CheckAuthorization

    _currentUser = user;
    _isAuthorized = authorization != null;
    _errorMessage = '';

    // If the user has already granted access to the required scopes, call the
    // REST API.
    if (user != null && authorization != null) {
      unawaited(_handleGetContact(user));
    }
  }

  Future<void> _handleAuthenticationError(Object e) async {
    _currentUser = null;
    _isAuthorized = false;
    _errorMessage =
        e is GoogleSignInException
            ? 'Error ${e}'
            : 'Unknown error: $e';
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    // _contactText = 'Loading contact info...';
    // final Map<String, String>? headers = await user.authorizationClient
    //     .authorizationHeaders(scopes);
    // if (headers == null) {
    //   _contactText = '';
    //   _errorMessage = 'Failed to construct authorization headers.';
    //   return;
    // }
    // final http.Response response = await http.get(
    //   Uri.parse(
    //     'https://people.googleapis.com/v1/people/me/connections'
    //     '?requestMask.includeField=person.names',
    //   ),
    //   headers: headers,
    // );
    // if (response.statusCode != 200) {
    //   if (response.statusCode == 401 || response.statusCode == 403) {
    //       _isAuthorized = false;
    //       _errorMessage =
    //           'People API gave a ${response.statusCode} response. '
    //           'Please re-authorize access.';
    //   } else {
    //     print('People API ${response.statusCode} response: ${response.body}');
    //       _contactText =
    //           'People API gave a ${response.statusCode} '
    //           'response. Check logs for details.';
    //   }
    //   return;
    // }
    // final Map<String, dynamic> data =
    //     json.decode(response.body) as Map<String, dynamic>;
    // final String? namedContact = _pickFirstNamedContact(data);
    //   if (namedContact != null) {
    //     _contactText = 'I see you know $namedContact!';
    //   } else {
    //     _contactText = 'No contacts to display.';
    //   }
  }

  

  Future<List<ResultEntry>> loadInResults({bool secondTry = false}) async {
    List<ResultEntry> results = [];
    try {
      final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbxCb4QjN9es54URF1leSp3E2R-Yiu8DJwI7rXPzBgoFYFQ6k7bt2k2FAK9M66d9MklYMQ/exec"),
        // headers: headers,
      );

      if (response.statusCode == 200) {
        print("dinosaur 200");
        var data = json.decode(response.body);
        for (var result in data) {
          results.add(ResultEntry.fromJson(result));
        }
        results.sort((a, b) => a.color.compareTo(b.color));
      } else if (response.statusCode == 401) {
        print("failed");
      } else if (response.statusCode == 404) {
        print("404 Not Found");
        toastification.show(
          context: Get.context!,
          title: Text('Error 404: Resource not found.'),
          autoCloseDuration: const Duration(seconds: 5),
          type: ToastificationType.error,
        );
      } else {
        print("Error");
      }
    } catch (e) {
      print("Failed to load people: $e");
      toastification.show(
        context: Get.context!,
        title: Text('Error loading people: $e'),
        autoCloseDuration: const Duration(seconds: 5),
        type: ToastificationType.error,
      );
    }
    return results;
  }
}
