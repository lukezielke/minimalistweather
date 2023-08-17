import 'package:flutter/material.dart';
import 'screens/details.dart';
import 'screens/forecast.dart';
import 'screens/start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 20,
    stiffness: 30,
    damping: 0.5,
  );
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: PageView(
        physics: CustomPageViewScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          Start(),
          Details(),
          Forecast(),
        ],
      ),
    );
  }
}