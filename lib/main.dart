import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/watchlist/data/models/watchlist_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadEnvVariables();

  await prepareHive();

  runApp(const MyApp());
}

Future<void> prepareHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WatchlistItemMoodelAdapter());
  await Hive.openBox<WatchlistItemMoodel>('items');
}

Future<void> loadEnvVariables() async {
  await dotenv.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
