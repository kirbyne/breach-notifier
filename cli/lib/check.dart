/// library that checks for data breaches with input data
library;

import 'dart:io';

import 'package:http/http.dart' as http;

String xposedOrNotAPI = "api.xposedornot.com";
Future<void> checkForBreaches(String args) async {
  // Make individual requests for every email in the arguments list

  print("Input arguments: $args");

  switch (args) {
    case "email":
      print("Enter an email:");
      String input = stdin.readLineSync() ?? "test@example.com";
      await queryXposedOrNotEmail(input);
  }
}

Future<void> queryXposedOrNotEmail(String email) async {
  final url = Uri.https(xposedOrNotAPI, '/v1/check-email/$email');

  final response = await http.get(url);

  switch (response.statusCode) {
    case 200:
      {
        print('Success checking XposedOrNot');
        if (response.body.contains('"Error":"Not found"')) {
          print("Your email was not found in any breaches");
          break;
        } else {
          print(
            "Your email has been found in the following breaches:\n${response.body}}",
          );
          break;
        }
      }
    case 500:
      {
        print("There has been a server error");
      }
    default:
      {
        print("Error checking XposedOrNot");
      }
      break;
  }
}

Future<void> queryXposedOrNotPassword(String passwordHash) async {
  final Uri url = Uri.https(xposedOrNotAPI, '/v1/pass/anon/$passwordHash');

  final response = await http.get(url);

  switch (response.statusCode) {
    case 200:
      {
        print('Success checking XposedOrNot');
        if (response.body.contains('{"Error":"Not found"}')) {
          print("Your password was not found in any breaches");
          break;
        } else {
          print(
            "Your password has been found in the following breaches:\n${response.body}}",
          );
          break;
        }
      }
    case 500:
      {
        print("There has been a server error");
      }
    default:
      {
        print("Error checking XposedOrNot");
      }
      break;
  }
}

String getPasswordHash(String password) {
  return "lol";
}
