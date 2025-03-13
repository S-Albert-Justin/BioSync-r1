import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'partsOfHomeScreen.dart';


const int baseRootColour = 0xff007bff;

class HomeStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffE8F0F9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "BIOSYNC",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(baseRootColour),
                  ),
                ),
                AboutPageButton(),
              ],
            ),

            // Circular Percent Indicators
            const Center(child: HeartRateInBpm(initialPercent: 0.86)),
            const Center(child: SensorSpO2Indicator(initialPercent: 0.95)),
            const StepProgressBar(currentStep: 3000, totalSteps: 1200),
            // Bottom Navigation Bar
            BaseButtons(),
          ],
        ),
      ),
    );
  }
}
