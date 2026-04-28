/// library that checks for data breaches with input data
library;

import 'package:http/http.dart' as http;

Future<void> checkForBreaches(String args) async {
  // Make individual requests for every email in the arguments list

  print("Checking the following emails in xposed or not: $args");
  print("Checking $args");
  await queryXposedOrNot(args);
}

Future<void> queryXposedOrNot(String email) async {
  final url = Uri.https(
    'api.xposedornot.com',
    '/v1/check-email/$email',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    print('Success checking XposedOrNot');
    print(response.body);
  } else {
    print('Error checking XposedOrNot');
  }
}
