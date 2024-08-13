import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:socorre_app/screens/splash/splash_page.dart';
import 'package:socorre_app/services/store/user_store.dart';
import 'package:socorre_app/theme/my_app_themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'].toString(),
    anonKey: dotenv.env['SUPABASE_ANOM'].toString(),
  );
  GetIt.I.registerSingleton<UserStore>(UserStore());
  initializeDateFormatting('pt_BR', null)
      .then((value) => runApp(const MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: ThemeMode.dark, //alterar aqui posteriormente para sistema
      home: const SplashPage(),
    );
  }
}
