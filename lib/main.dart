import 'package:flutter/material.dart';
import 'package:interviews/src/constant/links.dart';
import 'package:interviews/src/my_aap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Links.link, anonKey: Links.key);
  runApp(
    const MyApp(),
  );
}
