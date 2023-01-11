import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int time = 60 * 25;
  late Timer timer;

  late num minute = (time / 60) as int;
  late num second = time % 60;
  bool isRunning = false;

  void _timeDecrease() {
    minute = (time ~/ 60);
    second = time % 60;
  }

  void onTick(Timer timer) {
    setState(() {
      time--;
      // _timeDecrease를 호출하면 실행이 안 됨.
      //_timeDecrease()를 호출해야 원하는 값 나옴
      _timeDecrease();
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          // 비율을 정할 수 있어서 하드코딩 피할 수 있음
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                second < 10 ? "$minute:0$second" : "$minute:$second",
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 78,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_outline,
                ),
                iconSize: 120,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 57,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
