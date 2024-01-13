import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/page/login.dart';
import 'package:untitled4/page/signup.dart';

import 'package:untitled4/page/tansportationfee.dart';
import 'package:untitled4/page/transportationFeeDataTable.dart';

import '../data/langaue.dart';
import 'driver.dart';
import 'reportPage.dart';
import 'vehicle.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.controller,
    required this.user,
    required this.language,
  });
  final User user;
  final PageController controller;
  final String language;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int indexPage = 0;
  late Timer _timer;
  int _seconds = 60 * 60 * 2;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds == 0) {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage(
                        Language: widget.language,
                      )),
            );
            timer.cancel();
          });
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    Timer.periodic(const Duration(hours: 2), (timer) {
      print(DateTime.now());
    });
    startTimer();
    super.initState();
  }

  String getTimerText() {
    int hours = (_seconds ~/ 3600);
    int minutes = (_seconds % 3600) ~/ 60;
    int seconds = _seconds % 60;

    String hoursStr = (hours < 10) ? '0$hours' : '$hours';
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';

    return '$hoursStr:$minutesStr:$secondsStr            ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                style: const TextStyle(fontSize: 20.0),
                widget.user.name ?? "",
              ),
            ),
            Visibility(
              visible: widget.user.userName == 'admin',
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp(
                                user: widget.user,
                                pageController: widget.controller,
                                language: widget.language,
                              )),
                    );
                  },
                  child: Text(getLanguage(context, 'addNewUser'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTimerText(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                padding: const EdgeInsets.only(bottom: 450),
                color: Colors.blue.withOpacity(.8),
                height: 220,
                alignment: Alignment.center,
              ),
            ),
            ClipPath(
              clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
              child: Container(
                padding: const EdgeInsets.only(bottom: 50),
                color: Colors.blue.withOpacity(.3),
                height: 180,
                alignment: Alignment.center,
              ),
            ),
            Column(
              children: [
                Center(child: Consumer<ProviderTransportationFee>(
                    builder: (context, providerTransportationData, child) {
                  return providerTransportationData.message;
                })),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: indexPage == 0
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange[300],
                                  elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              : null,
                          onPressed: () {
                            setState(() {
                              indexPage = 0;
                            });
                            widget.controller.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(
                            getLanguage(context, 'addDriver'),
                          ), //addDriver
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 1
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              setState(() {
                                indexPage = 1;
                              });

                              widget.controller.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(getLanguage(context, 'addvehicle'))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 2
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              setState(() {
                                indexPage = 2;
                              });
                              widget.controller.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(getLanguage(context, 'addprovider'))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 3
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              setState(() {
                                indexPage = 3;
                              });
                              widget.controller.animateToPage(
                                3,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(
                                getLanguage(context, 'addTransportationFee'))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 4
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              setState(() {
                                indexPage = 4;
                              });
                              widget.controller.animateToPage(
                                4,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(getLanguage(context, 'report'))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 5
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              setState(() {
                                indexPage = 5;
                              });
                              widget.controller.animateToPage(
                                5,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(getLanguage(context, 'report'))),
                      ),
                    ),
                  ],
                ),
                CustomPageView(
                  user: widget.user,
                  controller: widget.controller,
                  language: widget.language,
                ),
              ],
            ),
          ],
        ));
  }
}

class CustomPageView extends StatelessWidget {
  const CustomPageView(
      {super.key,
      required this.controller,
      required this.user,
      required this.language});
  final User user;
  final PageController controller;
  final String language;

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return Expanded(
      child: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: <Widget>[
          DriverTab(
            language: language,
            user: user,
          ),
          VehicleTab(user: user, language: language),
          const Center(
            child: Text('thid Page'),
          ),
          TransportationFee(user: user, language: language),
          const ReportTap(),
          TransportationFeeDataTable(user: user, language: language),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double waveDeep;
  final double waveDeep2;

  WaveClipper({this.waveDeep = 100, this.waveDeep2 = 0});
  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;

    final Offset controlPoint1 = Offset(sw * .25, sh - waveDeep2 * 2);
    final Offset destinationPoint1 = Offset(sw * .5, sh - waveDeep - waveDeep2);

    final Offset controlPoint2 = Offset(sw * .75, sh - waveDeep * 2);
    final Offset destinationPoint2 = Offset(sw, sh - waveDeep);

    final Path path = Path()
      ..lineTo(0, size.height - waveDeep2)
      ..quadraticBezierTo(controlPoint1.dx, controlPoint1.dy,
          destinationPoint1.dx, destinationPoint1.dy)
      ..quadraticBezierTo(controlPoint2.dx, controlPoint2.dy,
          destinationPoint2.dx, destinationPoint2.dy)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
