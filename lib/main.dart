import 'package:flutter/material.dart';

void main() {
  runApp(const ProjectLWikiApp());
}

class ChampionStats {
  final int range;
  final int power;
  final int vitality;
  final int mobility;
  final int easeOfUse;

  // Simple constructor to keep the mock data clean
  const ChampionStats({
    required this.range, 
    required this.power, 
    required this.vitality, 
    required this.mobility, 
    required this.easeOfUse,
  });
}

class Champion {
  final String name;
  final String title;
  final String playstyle;
  final String icon;
  final String bio;
  final String profileImage; // Optional: Add a profile image URL or asset path
  final ChampionStats stats; // All 5 stats grouped into 1 object

  Champion({
    required this.name,
    required this.title,
    required this.playstyle,
    required this.icon,
    required this.bio,
    required this.profileImage,
    required this.stats,
  });
}

// --- Data ---
final List<Champion> roster = [
  Champion(name: 'Ahri', title: 'The Nine-Tailed Fox', playstyle: 'Rushdown', icon: '🦊',
            bio: 'Ahri is a fox-like vastaya who consumes the emotions of her opponent. She\s a highly mobile mage who pressures foes with an arsenal of dashes, charms, and foxfire attacks.', 
            profileImage: 'assets/Ahri-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 5, easeOfUse: 3)),
  Champion(name: 'Akali', title: 'The Rogue Assassin', playstyle: 'Mix Up', icon: '🗡️', 
            bio: 'The former prodigy of the Kinkou Order, Akali was trained from childhood in the arts of stealth and assassination but now follows her own path of justice. She employs a variety of tricky movements and gast projectiles to slip into the close range, then traps her opponents in clouds of smoke that enhance her special moves and allow her to crush their defenses.', 
            profileImage: 'assets/Akali-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 5, easeOfUse: 2)),
  Champion(name: 'Blitzcrank', title: 'The Great Steam Golem', playstyle: 'Grappler', icon: '🤖', 
            bio: 'Though this big, metal golem was originally made for waste disposal, Blitzcrank now uses their mechanical powers to help people in other ways. Using rocket fists to pull opponents close, Blitz then unleashes their grappler fury with potent grabs and energy bursts.', 
            profileImage: 'assets/Blitzcrank-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Braum', title: 'The Heart of The Freljord', playstyle: 'Bruiser', icon: '🛡️', 
            bio: 'Braum roams the frostbitten wilds of the Freljord, lending his shield to those in need. He deploys a wide range of defensive utility, massive close-range attacks, and a small army of poros to protect his allies and freeze his enemies in their tracks.', 
            profileImage: 'assets/Braum-2XKO-Profile.png',
            stats: const ChampionStats(range: 2, power: 5, vitality: 5, mobility: 2, easeOfUse: 4)),
  Champion(name: 'Caitlyn', title: 'The Sheriff of Piltover', playstyle: 'Zoner', icon: '🎯', 
            bio: 'As sheriff of Piltover, Caitlyn Kiramman sets her rifle sight on the city\'s criminals, taking them down with expert precision. She uses a variety of traps to limit enemy movement before finishing them with perfectly-aimed rifle shots.', 
            profileImage: 'assets/Caitlyn-2XKO-Profile.png',
            stats: const ChampionStats(range: 5, power: 3, vitality: 2, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Darius', title: 'The Hand of Noxus', playstyle: 'All Rounder', icon: '🪓', 
            bio: 'Ever loyal to Noxus, Darius embodies the strength of the empire. He conquers his opponents from mid-range, swinging his axe with all his might from variety of angles.', 
            profileImage: 'assets/Darius-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 5)),
  Champion(name: 'Ekko', title: 'The Boy Who Shattered Time', playstyle: 'Mix Up', icon: '⏳', 
            bio: 'A young genius from Zaun, Ekko uses his knowledge of hextech science to find a victorious timeline. He baffles opponents with an arsenal of invented gadgets, thriving in pressure mixups and burst mobility.', 
            profileImage: 'assets/Ekko-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 4, easeOfUse: 3)),
  Champion(name: 'Illaoi', title: 'The Kraken Priestess', playstyle: 'Bruiser', icon: '🦑', 
            bio: 'The Truth-Bearer of Nagakabouros, Illaoi wields a massive totem to summon spectral tentacles and test the will of her opponents. She\'s a high damage lockdown bruiser who overwhelms enemies with pressure as immense as her faith.', 
            profileImage: 'assets/Illaoi-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Jinx', title: 'The Loose Cannon', playstyle: 'Zoner', icon: '🚀', 
            bio: 'With an arsenal of custom guns, traps, and explosives, Jinx unleashes mayhem wherever she goes. She excels at zoning enemies, overwhelming them with colorful destruction from afar.', 
            profileImage: 'assets/Jinx-2XKO-Profile.png',
            stats: const ChampionStats(range: 4, power: 3, vitality: 2, mobility: 2, easeOfUse: 4)),
  Champion(name: 'Teemo', title: 'The Swift Scout', playstyle: 'Trap', icon: '🍄', 
            bio: 'A proud Bandle Scout, Teemo never misses an opportunity to earn a merit badge. Armed with his trusty scout utensils, this yordle is a deceptive ranged fighter with a knapsack full of tricks.', 
            profileImage: 'assets/Teemo-2XKO-Profile.png',
            stats: const ChampionStats(range: 4, power: 1, vitality: 2, mobility: 3, easeOfUse: 3)),
  Champion(name: 'Vi', title: 'The Piltover Enforcer', playstyle: 'Rushdown', icon: '🧤', 
            bio: 'Vi is an impetuous power-puncher who lives to throw hands. Armed with hextech gauntlets and slick boxing footwork, she excels at closing the distance and clobbering foes with haymakers.', 
            profileImage: 'assets/Vi-2XKO-Profile.png',
            stats: const ChampionStats(range: 1, power: 4, vitality: 3, mobility: 4, easeOfUse: 4)),
  Champion(name: 'Warwick', title: 'The Uncaged Wrath of Zaun', playstyle: 'Rushdown', icon: '🦁', 
            bio: 'An infamous and vicious hunter from the depths of Zaun, Warwick\'s howl strikes fear into the hearts of his opponents. Using powerful teeth and claws, and a relentless rushdown approach, Warwick mauls opponents with varied and unpredictable angles of attack.', 
            profileImage: 'assets/Warwick-2XKO-Profile.png',
            stats: const ChampionStats(range: 2, power: 4, vitality: 3, mobility: 3, easeOfUse: 4)),
  Champion(name: 'Yasuo', title: 'The Unforgiven', playstyle: 'All Rounder', icon: '🌪️', 
            bio: 'An Ionian of deep resolve, Yasuo is an agile swordsman who wields the air itself against his enemies. He excels at mid-range, using the power of the wind to dash through opponents and block projectiles.', 
            profileImage: 'assets/Yasuo-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 3, vitality: 3, mobility: 3, easeOfUse: 3)),

];

// --- Fuse Data Model ---
class Fuse {
  final String name;
  final String description;
  final IconData icon;
  final bool isRecommended;

  const Fuse({required this.name, required this.description, required this.icon, this.isRecommended = false,});
}

// --- Fuse List ---
const List<Fuse> fuses = [
  Fuse(
    name: 'Double Down', 
    description: 'Combine your Super Attacks with your Assist\'s!',
    icon: Icons.bolt, // Lightning bolt for power
    isRecommended: true, // Highlight this as a recommended fuse
  ),
  Fuse(
    name: 'Freestyle', 
    description: 'Handshake tag twice in one sequence!',
    icon: Icons.sync, // Sync icon for swapping/tagging
  ),
  Fuse(
    name: 'Sidekick', 
    description: 'Assist cannot be KO\'d or tagged to and has unique tools to help the Point!',
    icon: Icons.group_add, // Group icon for assists
  ),
  Fuse(
    name: 'Juggernaut', 
    description: 'Fight as a single champion with enhanced powers!',
    icon: Icons.security, // Shield icon for defense
  ),
  Fuse(
    name: '2X Assist', 
    description: 'Empower your partner with multiple Assist Actions!',
    icon: Icons.control_point_duplicate, // Duplicate icon for 2X
  ),
];

class PlaystyleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double gap = 6.0;    // The width of the "dent" or empty space
    double stripeWidth = 10.0; // How wide the small left piece is

    // --- PIECE 1: THE LEFT STRIPE ---
    path.moveTo(20, 0); // Top left of stripe
    path.lineTo(20 + stripeWidth, 0); // Top right of stripe
    path.lineTo(stripeWidth, size.height); // Bottom right of stripe
    path.lineTo(0, size.height); // Bottom left of stripe
    path.close();

    // --- PIECE 2: THE MAIN BODY ---
    // We start after the stripe + the gap
    double startMain = stripeWidth + gap;
    
    path.moveTo(20 + startMain, 0); // Top left
    path.lineTo(size.width, 0); // Top right
    path.lineTo(size.width - 20, size.height); // Bottom right
    path.lineTo(startMain, size.height); // Bottom left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProjectLWikiApp extends StatelessWidget {
  const ProjectLWikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyanAccent,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
      ),
      home: const HomePage(),
    );
  }
}

// --- Page 1: Home ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Change this line:
          title: const Text('2XKO HANDBOOK', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
          bottom: const TabBar(
            indicatorColor: Colors.cyanAccent,
            tabs: [
              Tab(text: "ROSTER"),
              Tab(text: "FUSES"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RosterListView(),
            MechanicsGridView(),
          ],
        ),
      ),
    );
  }
}

class RosterListView extends StatelessWidget {
  const RosterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: roster.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => ChampionTile(champion: roster[index]),
    );
  }
}

class ChampionTile extends StatelessWidget {
  final Champion champion;
  const ChampionTile({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChampionDetailPage(champion: champion)),
        ),
        child: ListTile(
          leading: Text(champion.icon, style: const TextStyle(fontSize: 28)),
          title: Text(champion.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(champion.playstyle, style: const TextStyle(color: Colors.cyanAccent)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}

// --- Page 2: Champion Detail ---
class ChampionDetailPage extends StatelessWidget {
  final Champion champion;
  const ChampionDetailPage({super.key, required this.champion});

  // Helper to build the 1-5 Stat Bar from your image
  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index < value ? Colors.greenAccent : Colors.white10,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(champion.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Rounds the corners
                child: Image.asset(
                  champion.profileImage, // Points to "assets/Ahri-2XKO-Profile.png"
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover, // Crops image to fill the container nicely
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback: If image fails to load, show the emoji icon instead
                    return Text(champion.icon, style: const TextStyle(fontSize: 100));
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(champion.title, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey)),
            ),
            const Divider(height: 40, color: Colors.white24),
            ClipPath(
              clipper: PlaystyleClipper(),
              child: Container(
                // Increase left padding (e.g., 45) to move text past the stripe and gap
                padding: const EdgeInsets.fromLTRB(45, 5, 30, 5), 
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Text(
                  champion.playstyle.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            //Text(champion.playstyle, style: const TextStyle(fontSize: 20, height: 1.5)),
            const SizedBox(height: 15),
            _buildStatRow("Range", champion.stats.range),
            _buildStatRow("Power", champion.stats.power),
            _buildStatRow("Vitality", champion.stats.vitality),
            _buildStatRow("Mobility", champion.stats.mobility),
            _buildStatRow("Ease of Use", champion.stats.easeOfUse),
            const SizedBox(height: 30),
            const Text("BIO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
            const SizedBox(height: 10),
            Text(champion.bio, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class MechanicsGridView extends StatelessWidget {
  const MechanicsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, 
        childAspectRatio: 3.5, 
        mainAxisSpacing: 12,
      ),
      itemCount: fuses.length,
      itemBuilder: (context, index) {
        final fuse = fuses[index];
        return Card(
          elevation: 4,
          color: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.cyanAccent, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              // 1. INSTANTLY CLEAR THE PREVIOUS MESSAGE
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              // 2. SHOW NEW MESSAGE IMMEDIATELY
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.cyanAccent,
                  duration: const Duration(milliseconds: 800), // SNAPPY DURATION
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "${fuse.name.toUpperCase()}: ${fuse.description}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900, // MAXIMUM BOLD
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(fuse.icon, color: Colors.cyanAccent, size: 30),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              fuse.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (fuse.isRecommended)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.yellowAccent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "RECOMMENDED!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fuse.description,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}