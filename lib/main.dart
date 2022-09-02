import 'package:flutter/material.dart';
import 'page/user_page.dart';
import 'utils/user_simple_preferences.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await UserSimplePrefernces.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Shared Preferences';

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    home: UserPage(),
  );
}
  