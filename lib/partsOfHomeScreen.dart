import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'dart:async';
import 'dart:math';

import 'AboutUsPage.dart';
import 'package:heartrate2/HomePage.dart';
import 'package:heartrate2/LeaderBoardPage.dart';
import 'package:heartrate2/Charts.dart';

const int baseRootColour = 0xff007bff;

class AboutPageButton extends StatefulWidget {
  @override
  _AboutPageButtonState createState() => _AboutPageButtonState();
}

class _AboutPageButtonState extends State<AboutPageButton> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        setState(() {
          isOn = !isOn; // Toggle the state if needed
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutUsPage()),
        );
      },
      child: const Text("About Us"),
      style: const NeumorphicStyle(
        color: Color(0xffE8F0F9),
      ),
    );
  }
}

class HeartRateInBpm extends StatefulWidget {
  final double initialPercent;

  const HeartRateInBpm({Key? key, required this.initialPercent})
      : super(key: key);

  @override
  _HeartRateInBpmState createState() => _HeartRateInBpmState();
}

class _HeartRateInBpmState extends State<HeartRateInBpm> {
  double currentPercent = 0.73; // Default value
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    currentPercent = widget.initialPercent;

    // Start updating BPM every 1 second
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        int newBpm = _random.nextInt(41) + 50; // Random BPM between 65-105
        currentPercent = (newBpm / 100);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 10,
        intensity: 0.8,
        color: Color(0xffE8F0F9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CircularPercentIndicator(
          radius: 80,
          lineWidth: 20,
          percent:
              currentPercent.clamp(0.65, 1.00) / 1.2, // Ensure within range
          center: Text(
            " ${(currentPercent * 100).toInt()}\nBpm",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(baseRootColour),
            ),
          ),
          progressColor: const Color(baseRootColour),
          backgroundColor: const Color(0xffC4D9FF),
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ),
    );
  }
}

class SensorSpO2Indicator extends StatefulWidget {
  final double initialPercent;

  const SensorSpO2Indicator({Key? key, required this.initialPercent})
      : super(key: key);

  @override
  _SensorSpO2IndicatorState createState() => _SensorSpO2IndicatorState();
}

class _SensorSpO2IndicatorState extends State<SensorSpO2Indicator> {
  double currentPercent = 0.95; // Default value
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    currentPercent = widget.initialPercent;

    // Start updating SpO2 every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        int newSpO2 = _random.nextInt(6) + 95; // Random SpO2 between 95 - 100
        currentPercent =
            (newSpO2 / 100).clamp(0.95, 1.0); // ✅ Ensures valid range
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 10,
        intensity: 0.8,
        color: Color(0xffE8F0F9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CircularPercentIndicator(
          radius: 80,
          lineWidth: 20,
          percent: currentPercent, // No need to clamp here
          center: Text(
            " ${(currentPercent * 100).toInt()}%\nSpO2",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(baseRootColour),
            ),
          ),
          progressColor: const Color(baseRootColour),
          backgroundColor: const Color(0xffC4D9FF),
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ),
    );
  }
}

class StepProgressBar extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar(
      {Key? key, required this.currentStep, required this.totalSteps})
      : super(key: key);

  @override
  _StepProgressBarState createState() => _StepProgressBarState();
}

class _StepProgressBarState extends State<StepProgressBar> {
  late int totalSteps;

  @override
  void initState() {
    super.initState();
    totalSteps = widget.totalSteps; // Initialize with provided total steps
  }

  // Function to show popup and update total steps
  void _updateTotalSteps() {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return AlertDialog(
              title: const Text("Set New Step Goal"),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight *
                      0.3, // Limits height to avoid overflow
                  maxWidth: constraints.maxWidth * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Enter total steps"),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    int? newTotal = int.tryParse(_controller.text);
                    if (newTotal != null && newTotal > 0) {
                      setState(() {
                        totalSteps = newTotal;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        (widget.currentStep / totalSteps).clamp(0.0, 1.0); // Ensure valid range

    return Neumorphic(
      style: const NeumorphicStyle(
        depth: 4,
        intensity: 0.8,
        shape: NeumorphicShape.flat,
        color: Color(0xffE8F0F9),
      ),
      child: SizedBox(
        height: 100, // Increased for title space
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title "Steps"
              const Text(
                "Steps",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8), // Space between title and progress bar

              // Progress Bar with Clickable Steps Count
              Row(
                children: [
                  // Progress Bar
                  Expanded(
                    child: NeumorphicProgress(
                      percent: progress,
                      height: 10,
                      style: const ProgressStyle(
                        depth: 6,
                        accent: Color(baseRootColour),
                        variant: Color(0xff9999e3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Clickable Steps Count
                  GestureDetector(
                    onTap: _updateTotalSteps,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: 3,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        color: const Color(0xffE8F0F9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        "${widget.currentStep} / $totalSteps",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Navigation function
void _navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

// Reusable Neumorphic Icon Button
Widget _buildIconButton(
    {required IconData icon, required VoidCallback onPressed}) {
  return NeumorphicButton(
    onPressed: onPressed,
    style: const NeumorphicStyle(
      shape: NeumorphicShape.convex,
      depth: 5,
      boxShape: NeumorphicBoxShape.circle(),
      color: Color(0xffE8F0F9),
    ),
    child: Icon(icon, color: Colors.black54, size: 30),
  );
}

class BaseButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(
          icon: Icons.medical_information_rounded,
          onPressed: () => _navigateToPage(context, ProfilePage()),
        ),
        _buildIconButton(
          icon: Icons.leaderboard,
          onPressed: () => _navigateToPage(context, LeaderBoardPage()),
        ),
        _buildIconButton(
          icon: Icons.auto_graph,
          onPressed: () => _navigateToPage(context, Charts()),
        ),
      ],
    );
  }
}
