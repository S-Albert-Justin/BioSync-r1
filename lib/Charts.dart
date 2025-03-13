
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';


const int baseRootColour = 0xff007bff;

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE8F0F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text(
          "Charts",
          style: TextStyle(color: Color(baseRootColour)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ECGGraph(),
              const SizedBox(height: 32,
                child: Center(child: Text("Basic ECG"),),),
              FirstChart(),
              const SizedBox(height: 32,
              child: Center(child: Text("SPO2"),),),
              const SecoundChart(),
              const SizedBox(height: 32,
                child: Center(child: Text("Gyro debug"),),),

            ],
          ),
        ),

      ),
    );
  }




}

class FirstChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        shape: NeumorphicShape.convex,
        // boxShape: Neumorphic.(BorderRadius.all(Radius.circular(20))),
        depth: 10,
        intensity: 0.8,
        color: Color(0xffE8F0F9),
      ),
      child: Container(
        width: 350,
        height: 300,
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            backgroundColor: const Color(0xff121833),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return customText('Sat');
                      case 1:
                        return customText('Sun', highlight: true);
                      case 2:
                        return customText('Mon');
                      case 3:
                        return customText('Tue');
                      case 4:
                        return customText('Wed');
                      case 5:
                        return customText('Thu');
                      case 6:
                        return customText('Fri');
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 1.5),
                  const FlSpot(1, 1.0),
                  const FlSpot(2, 1.5),
                  const FlSpot(3, 1.5),
                  const FlSpot(4, 1.5),
                  const FlSpot(5, 1.5),
                  const FlSpot(6, 1.5),
                ],
                isCurved: true,
                color: Colors.pinkAccent,
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: true, color: Colors.pink.withOpacity(0.3)),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: Colors.orange,
                    );
                  },
                ),
              ),
              // Average line (Green dashed)
              LineChartBarData(
                spots: List.generate(7, (index) => FlSpot(index.toDouble(), 2)),
                isCurved: false,
                color: Colors.green,
                barWidth: 2,
                isStrokeCapRound: false,
                dashArray: [6, 4], // Creates the dashed line effect
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    )
    ;

  }

}

Widget customText(String text, {bool highlight = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text(
      text,
      style: TextStyle(
        color: highlight ? Colors.orange : Colors.grey,
        fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
    ),
  );
}

class SecoundChart extends StatefulWidget {
  const SecoundChart({super.key});

  @override
  State<SecoundChart> createState() => _SecoundChartState();
}

class _SecoundChartState extends State<SecoundChart> {
  var baselineX = 0.0;
  var baselineY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.all(12),
      style: const NeumorphicStyle(
        
        shape: NeumorphicShape.convex,
        depth: 10,
        intensity: 0.8,

      ),

      child: Container(
        
        color: const Color(0xff1b2339),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              right: 18.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: Slider(
                          value: baselineY,
                          onChanged: (newValue) {
                            setState(() {
                              baselineY = newValue;
                            });
                          },
                          min: -10,
                          max: 10,
                        ),
                      ),
                      Expanded(
                        child: _Chart(
                          baselineX,
                          (20 - (baselineY + 10)) - 10,
                        ),
                      )
                    ],
                  ),
                ),
                Slider(
                  value: baselineX,
                  onChanged: (newValue) {
                    setState(() {
                      baselineX = newValue;
                    });
                  },
                  min: -10,
                  max: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final double baselineX;
  final double baselineY;

  const _Chart(this.baselineX, this.baselineY) : super();

  Widget getHorizontalTitles(value, TitleMeta meta) {
    TextStyle style;
    if ((value - baselineX).abs() <= 0.1) {
      style = const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
    } else {
      style = const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(meta.formattedValue, style: style),
    );
  }

  Widget getVerticalTitles(value, TitleMeta meta) {
    TextStyle style;
    if ((value - baselineY).abs() <= 0.1) {
      style = const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      );
    } else {
      style = const TextStyle(
        color: Colors.white60,
        fontSize: 10,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(meta.formattedValue, style: style),
    );
  }

  FlLine getHorizontalVerticalLine(double value) {
    if ((value - baselineY).abs() <= 0.1) {
      return const FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return const FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  FlLine getVerticalVerticalLine(double value) {
    if ((value - baselineX).abs() <= 0.1) {
      return const FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return const FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getVerticalTitles,
              reservedSize: 36,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getHorizontalTitles,
                reservedSize: 32),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getVerticalTitles,
              reservedSize: 36,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getHorizontalTitles,
                reservedSize: 32),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: getHorizontalVerticalLine,
          getDrawingVerticalLine: getVerticalVerticalLine,
        ),
        minY: -10,
        maxY: 10,
        baselineY: baselineY,
        minX: -10,
        maxX: 10,
        baselineX: baselineX,
      ),
      duration: Duration.zero,
    );
  }
}

final List<double> ecgSamples = [
  0.0, 0.2, 0.1, -0.1, -0.3, 0.8, 1.5, 2.2, 1.0, 0.5, 0.2, 0.1, 0.05, 0.0,
  -0.1, -0.2, -0.3, 0.6, 1.3, 2.8, 1.6, 0.9, 0.4, 0.2, 0.0, -0.1, -0.15
];

class ECGGraph extends StatefulWidget {
  @override
  _ECGGraphState createState() => _ECGGraphState();
}

class _ECGGraphState extends State<ECGGraph> {
  List<FlSpot> ecgData = [];
  int sampleIndex = 0;
  double time = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startECGSimulation();
  }

  void _startECGSimulation() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        time += 0.05;
        ecgData.add(FlSpot(time, ecgSamples[sampleIndex]));

        sampleIndex = (sampleIndex + 1) % ecgSamples.length; // Loop the data

        if (ecgData.length > 100) {
          ecgData.removeAt(0); // Keep a moving window of 100 points
          for (int i = 0; i < ecgData.length; i++) {
            ecgData[i] = FlSpot(ecgData[i].x - 0.05, ecgData[i].y);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.all(12),
      style: NeumorphicStyle(
        depth: 10,
        intensity: 0.8,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        color: const Color(0xffE8F0F9),
      ),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.transparent,
              gridData: const FlGridData(show: true, drawVerticalLine: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        "${value.toStringAsFixed(1)} mV",
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        "${value.toStringAsFixed(1)}s",
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: ecgData,
                  isCurved: true,
                  color: Colors.red,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false), // Removes dots
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


