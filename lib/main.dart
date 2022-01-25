import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixed_bids/external/lib/providers/place_provider.dart';
import 'package:fixed_bids/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'external/lib/providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PlaceProvider.of(context),
      ),
      ChangeNotifierProvider(
        create: (context) => SearchProvider(),
      )
    ],
    child: EasyLocalization(
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        path: 'language',
        fallbackLocale: Locale('en', ''),
        child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Data.locale = context.locale;
    return MaterialApp(
      title: 'Fixed Bids',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(),
      navigatorObservers: [Data.navigator, BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0x0ffF8F8F8),
    ),
      home: SplashScreen(),
    );
  }
}
