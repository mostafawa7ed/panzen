import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/page/login.dart';
import 'package:untitled4/page/signup.dart';

import 'package:untitled4/page/tansportationfee.dart';
import 'package:untitled4/page/transportationFeeDataTable.dart';

import '../controller/provider_timer.dart';
import '../data/langaue.dart';
import 'changePassword.dart';
import 'driver.dart';
import 'provider.dart';
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

  @override
  void initState() {
    final ProviderTimer providerTimer =
        Provider.of<ProviderTimer>(listen: false, context);
    providerTimer.resetTimer(context, widget.language);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          Language: widget.language,
                        )),
              );
            },
            icon: Icon(Icons.logout),
          ),
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
              child: Selector<ProviderTimer, String>(
                selector: (context, providerTimer) => providerTimer.time,
                builder: (context, timer, child) {
                  return Text(timer);
                },

                // child: Consumer<ProviderTimer>(
                //   builder: (context, providerTimer, _) =>
                //       Text(providerTimer.time),
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
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/packground.png"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child: null /* add child content here */,
            // ),
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
                            child: Text(getLanguage(context, 'Formreport'))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: indexPage == 6
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
                                indexPage = 6;
                              });
                              widget.controller.animateToPage(
                                6,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child:
                                Text(getLanguage(context, 'changePassword'))),
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
          ProviderTab(user: user, language: language),
          TransportationFee(user: user, language: language),
          const ReportTap(),
          TransportationFeeDataTable(user: user, language: language),
          ChangePassword(user: user, Language: language),
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
