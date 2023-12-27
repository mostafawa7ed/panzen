import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/providerLogin.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:untitled4/page/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProviderTransportationFee()),
        ChangeNotifierProvider(create: (context) => ProviderLogin()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
