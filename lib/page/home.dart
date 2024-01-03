import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:untitled4/model/user_model.dart';

import 'package:untitled4/page/tansportationfee.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.controller,
    required this.user,
  });
  final User user;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 50),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text("اضافة حمولة منقولة")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 50),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text("next")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 50),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text("next")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.animateToPage(
                          3,
                          duration: const Duration(milliseconds: 50),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text("next")),
                ),
              ],
            ),
            CustomPageView(
              user: user,
              controller: controller,
            ),
          ],
        ),
      ],
    ));
  }
}

class CustomPageView extends StatelessWidget {
  const CustomPageView(
      {super.key, required this.controller, required this.user});
  final User user;
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
          TransportationFee(user: user),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          ),
          Center(
            child: Text('Four Page'),
          ),
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
