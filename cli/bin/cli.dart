// import 'package:cli/cli.dart' as cli;
// import 'package:cli/scanner.dart' as test;
import 'package:args/args.dart';
import 'dart:io' show exit;

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag("help", abbr: 'h', help: "this command shows how to use the app", negatable: false)
    ..addOption("add", abbr: 'a', help: "provide an email you want to check breaches for.")
    ..addOption("remove", abbr: 'r', help: "remove an email you have saved on the list.")
    ..addOption("list", abbr: 'l', help: "lists the emails you have saved to be checked.")
    ..addFlag("notify-test", help: "sends a test notification to your other devices that are linked with ntfy.sh (probably)", negatable: false);

  final args = parser.parse(arguments);

  if(args.wasParsed('help')) {
    print('help');
    exit(0);
  }

  if(args.wasParsed("add")) {
    print("you added the email => ${args['add']}");
  } 
  else if(args.wasParsed("remove")) {
    print("you removed the email => ${args['remove']}");
  } 
  else if(args.wasParsed("list")) {
    print("your emails list");
  }
  else if(args.wasParsed("notify-test")) {
    print("notification test");
  }
}
