import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';

import 'page/page_tansportation_fee.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Add your ProviderTransportationFee here
        ChangeNotifierProvider(
            create: (context) => ProviderTransportationFee()),
        // You can add more providers here if needed
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
    return Scaffold(
        body: Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 100)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                  );
                },
                child: Text("اضافة حمولة منقولة")),
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(
                    1,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                  );
                },
                child: Text("next")),
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(
                    2,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                  );
                },
                child: Text("next")),
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(
                    3,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                  );
                },
                child: Text("next")),
          ],
        ),
        CustomPageView(
          controller: controller,
        ),
      ],
    ));
  }
}

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return Expanded(
      child: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: <Widget>[
          TransportationFee(),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}
