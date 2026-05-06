// this file contains the functions that are needed to work with email.json to save emails

import 'dart:convert';
import 'dart:io';

const String _emailsListPath = 'lib/data/emails.json';

// this function will return the json file as a list 
Future<List<dynamic>> readEmails() async {
  final file = File(_emailsListPath);
  if (!await file.exists()) return [];

  try {
    String content = await file.readAsString();
    return content.isEmpty ? [] : jsonDecode(content);
  } catch (e) {
    return [];
  }
}

// this function will write the list as a string in the json file
Future<void> saveEmails(List<dynamic> emails) async {
  final file = File(_emailsListPath);
  String jsonString = JsonEncoder.withIndent('  ').convert(emails);
  await file.writeAsString(jsonString);
}


// the functions that are used to manage the emails list in email.json
void add(dynamic input) async {
  List<dynamic> emails = await readEmails();
  List<String> toAdd = [];

  if (input is Iterable) {
    toAdd.addAll(input.map((e) => e.toString()));
  } else {
    toAdd.add(input.toString());
  }

  bool changed = false;
  for (var email in toAdd) {
    if (!emails.contains(email)) {
      emails.add(email);
      print("Added '$email' to the list");
      changed = true;
    } else {
      print("Email '$email' already exists in the list");
    }
  }

  if (changed) {
    await saveEmails(emails);
  }
}

void remove(dynamic input) async {
  List<dynamic> emails = await readEmails();

  if (input == '*all') {
    await saveEmails([]);
    print("The emails list is now empty");
    return;
  }

  List<String> toRemove = [];
  if (input is Iterable) {
    toRemove.addAll(input.map((e) => e.toString()));
  } else {
    toRemove.add(input.toString());
  }

  bool changed = false;
  for (var email in toRemove) {
    if (emails.contains(email)) {
      emails.remove(email);
      print("Removed '$email' from the list");
      changed = true;
    } else {
      print("The email '$email' does not exist in the list to be removed");
    }
  }

  if (changed) {
    await saveEmails(emails);
  }
}
void list() async {
    List<dynamic> emails = await readEmails();
    print(emails.isEmpty ? "" : emails);
}
void listFilter(String query) async {
  List<dynamic> emails = await readEmails();
  var matches = emails.where((email) => email.toString().toLowerCase().contains(query.toLowerCase())).toList();
  if(matches.isEmpty) 
    print("");
  else {
    for(var match in matches) {
      print(match);
    }
  }
}
// ---