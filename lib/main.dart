import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import "package:path_provider/path_provider.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/module/auth/screen/auth_screen.dart';
import 'app/module/auth/screen/splash_screen.dart';
import 'app/utils/difenece_colors.dart';
import 'app/utils/difenece_text_style.dart';
import 'app_binding.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color
      statusBarIconBrightness: Brightness.dark, // Android icons (white)
      statusBarBrightness: Brightness.dark, // iOS icons (white)
    ),
  );

  runApp(const MyApp(),
  );
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNotificationInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase messaging listeners after the app is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_isNotificationInitialized) {
        _isNotificationInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      color: DifeneceColors.WhiteColor,
      themeMode: ThemeMode.light,
      initialBinding: AppBinding(),
      theme: ThemeData(
        primaryColor: DifeneceColors.PBlueColor,
        textTheme: GoogleFonts.interTextTheme(),

        appBarTheme: const AppBarTheme(
          backgroundColor: DifeneceColors.WhiteColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: DifeneceColors.PBlueColor,
            foregroundColor: Colors.white,
            textStyle: DifeneceTextStyle.KH_1.copyWith(color: Colors.white),
            elevation: 2,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}