/*
Copyright (c) 2022 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/slide_selector.dart';
import 'components/week_summary.dart';
import 'components/chart_labels.dart';
import 'laughing_data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
  ));
  runApp(const LOLTrackerApp());
}

class LOLTrackerApp extends StatelessWidget {
  const LOLTrackerApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LOLTracker',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  int activeWeek = 2;
  static const leftPadding = 60.0;
  static const rightPadding = 60.0;


  double chartHeight = 240;
  late List<ChartDataPoint> chartData;

  @override
  void initState() {
    super.initState();
    setState(() {
      chartData = normalizeData(hourData[activeWeek - 1]);
    });
  }

  List<ChartDataPoint> normalizeData(WeekData weekData) {
    final maxDay = weekData.days.reduce((DayData dayA, DayData dayB) {
      return dayA.laughs > dayB.laughs ? dayA : dayB;
    });
    final normalizedList = <ChartDataPoint>[];
    weekData.days.forEach((element) {
      normalizedList.add(ChartDataPoint(
          value: maxDay.laughs == 0 ? 0 : element.laughs / maxDay.laughs));
    });
    return normalizedList;
  }

  void changeWeek(int week) {
    setState(() {
      activeWeek = week;
      chartData = normalizeData(hourData[week - 1]);

    });
  }

  Path drawPath(bool closePath) {
    final width = MediaQuery.of(context).size.width;
    final height = chartHeight;
    final path = Path();
    final segmentWidth =
        (width - leftPadding - rightPadding) / ((chartData.length - 1) * 3);

    path.moveTo(0, height - chartData[0].value * height);
    path.lineTo(leftPadding, height - chartData[0].value * height);
// curved line
    for (var i = 1; i < chartData.length; i++) {
      path.cubicTo(
          (3 * (i - 1) + 1) * segmentWidth + leftPadding,
          height - chartData[i - 1].value * height,
          (3 * (i - 1) + 2) * segmentWidth + leftPadding,
          height - chartData[i].value * height,
          (3 * (i - 1) + 3) * segmentWidth + leftPadding,
          height - chartData[i].value * height);
    }
    path.lineTo(width, height - chartData[chartData.length - 1].value * height);
// for the gradient fill, we want to close the path
    if (closePath) {
      path.lineTo(width, height);
      path.lineTo(0, height);
    }

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DashboardBackground(),
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(top: 60),
              alignment: Alignment.center,
              child: const Text(
                'LOL 😆 Tracker',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SlideSelector(
                defaultSelectedIndex: activeWeek - 2,
                items: <SlideSelectorItem>[
                  SlideSelectorItem(
                    text: '오전',
                    onTap: () {
                      changeWeek(1);
                    },
                  ),
                  SlideSelectorItem(
                    text: '오후',
                    onTap: () {
                      changeWeek(2);
                    },
                  ),

                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: chartHeight + 80,
              color: const Color(0xFF158443),
              child: Stack(
                children: [
                  //아침데이터
                  ChartLaughLabels(
                    chartHeight: chartHeight,
                    topPadding: 40,
                    leftPadding: leftPadding,
                    rightPadding: rightPadding,
                    weekData: hourData[activeWeek - 1],
                  ),



                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ChartDayLabels(
                      leftPadding: leftPadding,
                      rightPadding: rightPadding,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: CustomPaint(
                        size: Size(
                            MediaQuery.of(context).size.width, chartHeight),
                        painter: PathPainter(
                          path: drawPath(false),
                          fillPath: drawPath(true),
                        )),
                  )
                ],
              ),
            ),

          ],
        ),
      ],
    );
  }
}

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xFF158443),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  Path path;
  Path fillPath;
  PathPainter({required this.path, required this.fillPath});

  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
    // paint the gradient fill
    paint.style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
      Offset.zero,
      Offset(0.0, size.height),
      [
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.85),
      ],
    );
    canvas.drawPath(fillPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ChartDataPoint {
  double value;
  ChartDataPoint({required this.value});
}
