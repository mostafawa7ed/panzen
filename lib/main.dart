import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/providerLogin.dart';
import 'package:untitled4/controller/provider_report.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/page/login.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'controller/provider_provider.dart';
import 'controller/provider_providerDetails.dart';
import 'controller/provider_timer.dart';
import 'controller/provider_vehicle.dart';
import 'controller/provider_driver.dart';
import 'page/transportationFeeDataTable.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String language = prefs.getString('language') ?? 'ar';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProviderTransportationFee()),
        ChangeNotifierProvider(create: (context) => ProviderLogin()),
        ChangeNotifierProvider(create: (context) => ProviderReportData()),
        ChangeNotifierProvider(create: (context) => ProviderVehicle()),
        ChangeNotifierProvider(create: (context) => ProviderDriver()),
        ChangeNotifierProvider(create: (context) => ProviderProvider()),
        ChangeNotifierProvider(create: (context) => ProviderProviderDetails()),
        ChangeNotifierProvider(create: (context) => ProviderTimer()),
      ],
      child: MyApp(Language: language),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.Language});
  final String Language;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Language == 'ar' ? const Locale("ar") : const Locale("en"),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(Language: Language, title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.Language});

  final String title;
  final String Language;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final PageController _pageController = PageController();
  final User user = User();
  @override
  Widget build(BuildContext context) {
    // return HomePage(
    //   controller: _pageController,
    //   user: User(),
    // );
    return LoginPage(Language: widget.Language);
    // User user = User();
    // return SignUp(
    //   user: user,
    // );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'jDs55BiCSBk',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // some widgets if needed
            player,
            //some widgets if needed
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
