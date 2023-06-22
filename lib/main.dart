import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turkish_party_app/features/pass/block/block.dart';
import 'package:turkish_party_app/repository/score_repository.dart';
import 'features/main/screen.dart';
import 'theme/theme.dart';

//
void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('appBox');
  GetIt.I.registerLazySingleton<PassBloc>(() => PassBloc(HiveRepository(box)));

  runApp(const TurkishPartyApp());
}

class TurkishPartyApp extends StatelessWidget {
  const TurkishPartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool darkMode = false;
    return MaterialApp(
      title: 'Turkish party',
      // darkTheme: ThemeData.dark(),
      theme: lightTheme,
      home: const Main(),
    );
  }
}
