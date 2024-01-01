import 'package:flutter/material.dart';

import 'package:untitled4/page/tansportationfee.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final PageController controller;

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
