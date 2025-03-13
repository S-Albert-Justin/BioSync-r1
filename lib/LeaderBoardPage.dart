import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
const int baseRootColour = 0xff007bff;

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text("Leader Board",style: TextStyle(color: Color(baseRootColour)),),
      ),
      body: Container(
        color: const Color(0xffE8F0F9),
        child: const Column(
          children: [
            LeaderboardTile(avatarUrl: "assets/Carlotta.png", name: "Carlotta", steps: 3000, position: 1),
            SizedBox(height: 12,),
            LeaderboardTile(avatarUrl: "assets/T_IconRoleHead150_27_UI.png", name: "ZheZhi", steps: 2345, position: 2),
            SizedBox(height: 12,),
            LeaderboardTile(avatarUrl: "assets/Rover.png", name: "Rover", steps: 2245, position: 3),
            SizedBox(height: 12,),
            LeaderboardTile(avatarUrl: "assets/Jiyan.png", name: "Jiyan", steps: 1890, position: 4),
            SizedBox(height: 12,),
            LeaderboardTile(avatarUrl: "assets/Changli.png", name: "Changli", steps: 1800, position: 5),
            SizedBox(height: 12,),
            LeaderboardTile(avatarUrl: "assets/Phoebe.png", name: "Phoebe", steps: 1700, position: 6)
          ],
        ),
        ),
      );
  }
}

//assets/Carlotta_Full_Sprite2.png









class LeaderboardTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int steps;
  final int position;

  const LeaderboardTile({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.steps,
    required this.position,
  }) : super(key: key);

  Color _getBorderColor() {
    switch (position) {
      case 1:
        return Colors.amberAccent; // Gold
      case 2:
        return Colors.grey; // Silver
      case 3:
        return Colors.brown; // Bronze
      default:
        return Colors.transparent; // No border for others
    }
  }

  String _getPositionEmoji() {
    switch (position) {
      case 1:
        return "🥇";
      case 2:
        return "🥈";
      case 3:
        return "🥉";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      style: const NeumorphicStyle(
        border: NeumorphicBorder(color: Color(baseRootColour), width: 2,),
        depth: 5,
        intensity: 0.8,
        color: const Color(0x4ce8f0f9),
        shape: NeumorphicShape.flat,
      ),
      child: Container(


        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            // Avatar with border
            Container(
              padding: EdgeInsets.all(position <= 3 ? 4 : 0), // Padding only for top 3
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getBorderColor(),
                  width: position <= 3 ? 3 : 0,
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(avatarUrl),
                backgroundColor: Colors.transparent,
              ),
            ),

            const SizedBox(width: 15),

            // Name & Steps Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_getPositionEmoji()} $name",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "$steps steps",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Position Number on Right Side
            Text(
              "#$position",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _getBorderColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


