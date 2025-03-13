import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:heartrate2/Charts.dart';


class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [IconButton(onPressed: (){_navigateToPage(context, CreditsPage());}, icon: const Icon(Icons.menu))],
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text("About Us", style: TextStyle(color: Color(baseRootColour)),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffE8F0F9),
          child: Center(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    margin: EdgeInsets.all(13),
                    style: const NeumorphicStyle(
                      

                    ),
                      child: Container(child: Image.asset("assets/app_icon2.png", fit: BoxFit.cover,),)
                  ),
                ),
                TeamIntroduction()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeamIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16, color: Colors.black),
          children: [
            const TextSpan(
              text: "We are a passionate team of innovators dedicated to bridging the gap between biomedical technology and modern applications. Our team consists of three core members, each specializing in different aspects of the project to ensure a seamless blend of hardware and software.\n\n",
            ),
            _buildBoldText("🔹 Albert Justin S – "),
            const TextSpan(text: "The driving force behind our software development, Albert specializes in app development and UI design, ensuring our applications are not only functional but also intuitive and visually appealing. He also leads embedded programming, making sure our ESP32 and sensor integration work flawlessly.\n\n"),
            _buildBoldText("🔹 Rudhra Kumar – "),
            const TextSpan(text: "A creative mind, Rudhra focuses on designing compelling presentations and posters, effectively communicating our project's vision and technical aspects to audiences. His expertise in visualization helps bring our ideas to life.\n\n"),
            _buildBoldText("🔹 Krishna Kumar – "),
            const TextSpan(text: "Our hardware specialist, Krishna takes charge of acquiring and managing the components necessary for our development. His understanding of sensors and electronics ensures that we have the right tools to bring our project to reality.\n\n"),
            const TextSpan(
              text: "Together, we combine our unique skill sets to develop innovative solutions that push the boundaries of biomedical technology and IoT. Our collaborative effort is what makes our project a success!\n\n",
            ),
            _buildTitle("Our Vision\n"),
            const TextSpan(
              text: "We aim to develop affordable, accessible, and accurate health-monitoring solutions that empower individuals to take control of their well-being. By leveraging IoT, AI, and biomedical sensing, we strive to bridge the gap between cutting-edge research and real-world applications.\n\n",
            ),
            _buildTitle("What We Do\n"),
            _buildCheckmarkText("Real-time stress monitoring and accident alert using ESP32, MAX30102, and MPU6050\n"),
            _buildCheckmarkText("Flutter mobile app for live data visualization\n"),
            _buildCheckmarkText("Bluetooth Low Energy (BLE) integration for seamless connectivity\n"),
            _buildCheckmarkText("Innovative biomedical signal processing to enhance data accuracy\n\n"),
            const TextSpan(text: "With dedication and teamwork, we are bringing technology-driven healthcare solutions to life. 🚀"),
          ],
        ),
      ),
    );
  }

  TextSpan _buildBoldText(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700),
    );
  }

  TextSpan _buildTitle(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade700),
    );
  }

  TextSpan _buildCheckmarkText(String text) {
    return TextSpan(
      text: "✔️ $text",
      style: const TextStyle(fontWeight: FontWeight.w500, color: Color(baseRootColour)),
    );
  }
}

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text("Credits", style: TextStyle(color: Color(baseRootColour)),),
      ),
      body: SingleChildScrollView(

        child: Container(
          color: const Color(0xffE8F0F9),
          child: Column(
            children: [
              const SizedBox( height: 24,),
              Center(
                child: Neumorphic(child: Image.asset("assets/download.png")),
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CreditsText(),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class CreditsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        children: [
          const TextSpan(
            text: "Credits\n\n",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text: "We extend our heartfelt gratitude to everyone who has contributed to the success of our project.\n\n",
          ),
          _buildBullet("Institution: ", "Sethu Institute of Technology, Pulloor", true),
          _buildIndented("for providing us with the platform and resources to explore innovation.\n\n"),
          _buildBullet("Guides:\n", "", true),
          _buildBoldText("🔹 Mrs. Lathifa Banu,\n Assistant professor (Class Teacher) - "),
          _buildIndented(" for her constant encouragement and guidance.\n"),
          _buildBoldText("🔹 Dr. Ravethy,\n Associate professor (HOD, Physics) - "),
          _buildIndented(" for her valuable insights and support.\n\n"),
          _buildBullet("Online Resources:\n", "", true),
          _buildIndented("- Arduino & ESP32 Documentation – for technical references.\n"),
          _buildIndented("- Flutter & Dart Docs – for building a seamless mobile interface.\n"),
          _buildIndented("- SparkFun & Adafruit – for sensor integration knowledge.\n"),
          _buildIndented("- GitHub & Stack Overflow – for troubleshooting and development insights.\n"),
          _buildIndented("- Google Scholar & Research Papers – for biomedical-related study materials.\n\n"),
          const TextSpan(
            text: "We sincerely appreciate all the support and knowledge that have helped shape our project into reality!",
          ),
        ],
      ),
    );
  }

  TextSpan _buildBullet(String title, String content, bool bold) {
    return TextSpan(
      children: [
        TextSpan(
          text: "🔹 $title",
          style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: Color(baseRootColour)),
        ),
        TextSpan(text: content),
      ],
    );
  }

  TextSpan _buildIndented(String text) {
    return TextSpan(
      text: "   $text",
    );
  }
  TextSpan _buildBoldText(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700),
    );
  }

  TextSpan _buildTitle(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade700),
    );
  }

  TextSpan _buildCheckmarkText(String text) {
    return TextSpan(
      text: "✔️ $text",
      style: const TextStyle(fontWeight: FontWeight.w500, color: Color(baseRootColour)),
    );
  }
}


void _navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
