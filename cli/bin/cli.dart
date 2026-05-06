import 'package:args/args.dart';
import 'dart:io';
import '../lib/emailManagement.dart' as email;

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag("help", abbr: 'h', help: "this command shows how to use the app", negatable: false)
    ..addCommand("add")
    ..addCommand("remove")
    ..addCommand("list")
    ..addFlag("notify-test", help: "sends a test notification to your other devices that are linked with ntfy.sh (probably)", negatable: false)
    ..addOption("list-filter", abbr: 'f', help: "lists your emails depending on a certain query")
    ..addFlag("all", abbr: 'a', help: "deletes every saved email on the list");

  final args = parser.parse(arguments);

  if(args.wasParsed('help')) {
    print('help');
    exit(0);
  }

  final command = args.command;

  if (command != null) {
    switch (command.name) {
      case 'add':
        email.add(command.rest);
        break;
      case 'remove':
        if (args.wasParsed("all")) {
          print("[!] Are you sure you want to remove all of your saved emails? (N/y) ");
          String? confirm = stdin.readLineSync();
          if (confirm?.toLowerCase() == 'y') {
            email.remove('*all');
          } else {
            print("Operation cancelled");
          }
        } else {
          email.remove(command.rest);
        }
        break;
      case 'list':
        if(args.wasParsed("list-filter")) 
          email.listFilter(args['list-filter']);
        else
          email.list();
        break;
    }
  } 
}
