import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apitest/views/serch_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Search',
      theme: ThemeData(
          primaryColor: Colors.green,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF55C500),
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              )),
      home: const SearchScreen(),
    );
  }
}
