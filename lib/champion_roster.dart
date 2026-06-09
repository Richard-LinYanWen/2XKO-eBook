import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt_mobile;
import 'background_pattern.dart';

// --- Champion Structs ---
class ChampionStats {
  final int range; final int power; final int vitality; final int mobility; final int easeOfUse;
  const ChampionStats({required this.range, required this.power, required this.vitality, required this.mobility, required this.easeOfUse});
}

class Champion {
  final String name; final String title; final String playstyle; final String icon; final String bio; final String profileImage; final ChampionStats stats; final bool isNew;
  Champion({required this.name, required this.title, required this.playstyle, required this.icon, required this.bio, required this.profileImage, required this.stats, this.isNew = false});
}

// --- REQUIREMENT: Custom Type Parsing Setup ---
class FighterPatch {
  final String updateNotes; final String version;
  FighterPatch({required this.updateNotes, required this.version});
  factory FighterPatch.fromJson(Map<String, dynamic> json) {
    return FighterPatch(updateNotes: json['notes'] ?? 'Sync balanced.', version: json['version'] ?? 'v1.0.0');
  }
}

// --- Roster Data Dataset ---
final List<Champion> roster = [
  Champion(name: 'Ahri', title: 'The Nine-Tailed Fox', playstyle: 'Rushdown', icon: '🦊',
            bio: 'Ahri is a fox-like vastaya who consumes the emotions of her opponent. She\s a highly mobile mage who pressures foes with an arsenal of dashes, charms, and foxfire attacks.', 
            profileImage: 'assets/champs/Ahri-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 5, easeOfUse: 3)),
  Champion(name: 'Akali', title: 'The Rogue Assassin', playstyle: 'Mix Up', icon: '🗡️', 
            bio: 'The former prodigy of the Kinkou Order, Akali was trained from childhood in the arts of stealth and assassination but now follows her own path of justice. She employs a variety of tricky movements and gast projectiles to slip into the close range, then traps her opponents in clouds of smoke that enhance her special moves and allow her to crush their defenses.', 
            profileImage: 'assets/champs/Akali-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 5, easeOfUse: 2)),
  Champion(name: 'Blitzcrank', title: 'The Great Steam Golem', playstyle: 'Grappler', icon: '🤖', 
            bio: 'Though this big, metal golem was originally made for waste disposal, Blitzcrank now uses their mechanical powers to help people in other ways. Using rocket fists to pull opponents close, Blitz then unleashes their grappler fury with potent grabs and energy bursts.', 
            profileImage: 'assets/champs/Blitzcrank-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Braum', title: 'The Heart of The Freljord', playstyle: 'Bruiser', icon: '🛡️', 
            bio: 'Braum roams the frostbitten wilds of the Freljord, lending his shield to those in need. He deploys a wide range of defensive utility, massive close-range attacks, and a small army of poros to protect his allies and freeze his enemies in their tracks.', 
            profileImage: 'assets/champs/Braum-2XKO-Profile.png',
            stats: const ChampionStats(range: 2, power: 5, vitality: 5, mobility: 2, easeOfUse: 4)),
  Champion(name: 'Caitlyn', title: 'The Sheriff of Piltover', playstyle: 'Zoner', icon: '🎯', 
            bio: 'As sheriff of Piltover, Caitlyn Kiramman sets her rifle sight on the city\'s criminals, taking them down with expert precision. She uses a variety of traps to limit enemy movement before finishing them with perfectly-aimed rifle shots.', 
            profileImage: 'assets/champs/Caitlyn-2XKO-Profile.png',
            stats: const ChampionStats(range: 5, power: 3, vitality: 2, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Darius', title: 'The Hand of Noxus', playstyle: 'All Rounder', icon: '🪓', 
            bio: 'Ever loyal to Noxus, Darius embodies the strength of the empire. He conquers his opponents from mid-range, swinging his axe with all his might from variety of angles.', 
            profileImage: 'assets/champs/Darius-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 5)),
  Champion(name: 'Ekko', title: 'The Boy Who Shattered Time', playstyle: 'Mix Up', icon: '⏳', 
            bio: 'A young genius from Zaun, Ekko uses his knowledge of hextech science to find a victorious timeline. He baffles opponents with an arsenal of invented gadgets, thriving in pressure mixups and burst mobility.', 
            profileImage: 'assets/champs/Ekko-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 2, vitality: 2, mobility: 4, easeOfUse: 3)),
  Champion(name: 'Illaoi', title: 'The Kraken Priestess', playstyle: 'Bruiser', icon: '🦑', 
            bio: 'The Truth-Bearer of Nagakabouros, Illaoi wields a massive totem to summon spectral tentacles and test the will of her opponents. She\'s a high damage lockdown bruiser who overwhelms enemies with pressure as immense as her faith.', 
            profileImage: 'assets/champs/Illaoi-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 4, vitality: 4, mobility: 2, easeOfUse: 3)),
  Champion(name: 'Jinx', title: 'The Loose Cannon', playstyle: 'Zoner', icon: '🚀', 
            bio: 'With an arsenal of custom guns, traps, and explosives, Jinx unleashes mayhem wherever she goes. She excels at zoning enemies, overwhelming them with colorful destruction from afar.', 
            profileImage: 'assets/champs/Jinx-2XKO-Profile.png',
            stats: const ChampionStats(range: 4, power: 3, vitality: 2, mobility: 2, easeOfUse: 4)),
  Champion(name: 'Senna', title: 'The Redeemer', playstyle: 'Zoner', icon: '👻', 
            bio: 'A Champion of the light cursed by darkness, Senna blasts foes with her vaunted relic cannon before rushing them down as a shadowy wraith. With two forms to choose from, she\'s highly capable of redeeming any corrupted soul.', 
            profileImage: 'assets/champs/Senna-2XKO-Profile.png',
            stats: const ChampionStats(range: 5, power: 4, vitality: 3, mobility: 3, easeOfUse: 3),
            isNew: true),
  Champion(name: 'Teemo', title: 'The Swift Scout', playstyle: 'Trap', icon: '🍄', 
            bio: 'A proud Bandle Scout, Teemo never misses an opportunity to earn a merit badge. Armed with his trusty scout utensils, this yordle is a deceptive ranged fighter with a knapsack full of tricks.', 
            profileImage: 'assets/champs/Teemo-2XKO-Profile.png',
            stats: const ChampionStats(range: 4, power: 1, vitality: 2, mobility: 3, easeOfUse: 3)),
  Champion(name: 'Thresh', title: 'The Chain Warden', playstyle: 'Tactical', icon: '💀', 
            bio: 'Wicked and cunning, Thresh is a malevolent specter that delights in tormenting opponents, imprisoning their souls in his lantern for all eternity. He uses his chain to attack from tricky and unexpected angles, while his lantern lets him teleport and summon jailed souls for aid.', 
            profileImage: 'assets/champs/Thresh-2XKO-Profile.png',
            stats: const ChampionStats(range: 5, power: 3, vitality: 3, mobility: 3, easeOfUse: 2),
            isNew: true),
  Champion(name: 'Vi', title: 'The Piltover Enforcer', playstyle: 'Rushdown', icon: '🧤', 
            bio: 'Vi is an impetuous power-puncher who lives to throw hands. Armed with hextech gauntlets and slick boxing footwork, she excels at closing the distance and clobbering foes with haymakers.', 
            profileImage: 'assets/champs/Vi-2XKO-Profile.png',
            stats: const ChampionStats(range: 1, power: 4, vitality: 3, mobility: 4, easeOfUse: 4)),
  Champion(name: 'Warwick', title: 'The Uncaged Wrath of Zaun', playstyle: 'Rushdown', icon: '🦁', 
            bio: 'An infamous and vicious hunter from the depths of Zaun, Warwick\'s howl strikes fear into the hearts of his opponents. Using powerful teeth and claws, and a relentless rushdown approach, Warwick mauls opponents with varied and unpredictable angles of attack.', 
            profileImage: 'assets/champs/Warwick-2XKO-Profile.png',
            stats: const ChampionStats(range: 2, power: 4, vitality: 3, mobility: 3, easeOfUse: 4)),
  Champion(name: 'Yasuo', title: 'The Unforgiven', playstyle: 'All Rounder', icon: '🌪️', 
            bio: 'An Ionian of deep resolve, Yasuo is an agile swordsman who wields the air itself against his enemies. He excels at mid-range, using the power of the wind to dash through opponents and block projectiles.', 
            profileImage: 'assets/champs/Yasuo-2XKO-Profile.png',
            stats: const ChampionStats(range: 3, power: 3, vitality: 3, mobility: 3, easeOfUse: 3)),
];

class PlaystyleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path(); double gap = 6.0; double stripeWidth = 10.0;
    path.moveTo(20, 0); path.lineTo(20 + stripeWidth, 0); path.lineTo(stripeWidth, size.height); path.lineTo(0, size.height); path.close();
    double startMain = stripeWidth + gap;
    path.moveTo(20 + startMain, 0); path.lineTo(size.width, 0); path.lineTo(size.width - 20, size.height); path.lineTo(startMain, size.height); path.close();
    return path;
  }
  @override bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RosterListView extends StatefulWidget {
  const RosterListView({super.key});
  @override
  State<RosterListView> createState() => _RosterListViewState();
}

class _RosterListViewState extends State<RosterListView> {
  List<Champion> filteredRoster = roster;
  bool _isLoading = false; bool _hasError = false;

  Future<void> _simulateOnlineSync() async {
    setState(() { _isLoading = true; _hasError = false; });
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() { _isLoading = false; _hasError = true; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SearchBar(
            hintText: 'Filter champions or styles...',
            onChanged: (val) => setState(() => filteredRoster = roster.where((c) => c.name.toLowerCase().contains(val.toLowerCase()) || c.playstyle.toLowerCase().contains(val.toLowerCase())).toList()),
            leading: const Icon(Icons.search, color: Colors.cyanAccent),
          ),
        ),
        if (_isLoading) const LinearProgressIndicator(color: Colors.cyanAccent),
        if (_hasError) Expanded(child: Center(child: TextButton(onPressed: _simulateOnlineSync, child: const Text('Uplink Failed. Retry?')))),
        if (!_isLoading && !_hasError)
          Expanded(
            child: RefreshIndicator(
              color: Colors.cyanAccent,
              onRefresh: _simulateOnlineSync,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: filteredRoster.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final currentChamp = filteredRoster[i];
                    return Card(
                      color: Colors.grey[900],
                      child: ListTile(
                        leading: Hero(tag: 'icon-${filteredRoster[i].name}', child: Material(color: Colors.transparent, child: Text(filteredRoster[i].icon, style: const TextStyle(fontSize: 28)))),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(currentChamp.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            if (currentChamp.isNew) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xffe60042),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "NEW",
                                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: Text(filteredRoster[i].playstyle, style: const TextStyle(color: Colors.cyanAccent)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChampionDetailPage(champion: filteredRoster[i]))),
                      ),
                    );
                }
              ),
            ),
          ),
      ],
    );
  }
}

class ChampionDetailPage extends StatefulWidget {
  final Champion champion;
  const ChampionDetailPage({super.key, required this.champion});

  @override
  State<ChampionDetailPage> createState() => _ChampionDetailPageState();
}

class _ChampionDetailPageState extends State<ChampionDetailPage> {
  late Future<String> _videoFuture;
  yt_mobile.YoutubePlayerController? _youtubeController;
  bool _isVideoInitialized = false;

  // Map to link Champion names to specific YouTube IDs
  final Map<String, String> _championVideoMap = {
    'Ahri': 'EOr6cnybcPg',
    'Akali': 'fT4CwqJNdMU',
    'Blitzcrank': 'RPx3m5UalQs',
    'Braum': 'vEcGceXBQoE',
    'Caitlyn': 'e8al2A0FsU0',
    'Darius': 'mj8Ym4Q_66c',
    'Ekko': '0x2Lhj8Ibwo',
    'Illaoi': 'qZWu8nA45ko',
    'Jinx': '9cJVWte_4Hc',
    'Senna': '6878YYX1LE8',
    'Teemo': 'A8-Uw_sypMs',
    'Thresh': '45q18ujEYyk',
    'Vi': 'quGZjIkigu4',
    'Warwick': '4CRb0tPXCXY',
    'Yasuo': 'vmx6h7wN3j4',
    // Add your other champion video IDs here...
  };

  @override
  void initState() {
    super.initState();
    _videoFuture = _fetchChampionVideoId(widget.champion.name);
  }

  @override
  void dispose() {
    _youtubeController?.close();
    super.dispose();
  }

  Future<String> _fetchChampionVideoId(String name) async {
    // Mimicking the API fetch from your other file
    final url = Uri.parse('https://cdn.rgpub.io/public/live/riotbar/content-manifests/en_US.json');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final videoId = _championVideoMap[name] ?? 'xyK3lFtz2H8'; // Default video to 2XKO cinematic
        _initializeYouTube(videoId);
        return videoId;
      }
    } catch (e) {
      // Fallback
    }
    return 'xyK3lFtz2H8'; // Default video to 2XKO cinematic
  }

  void _initializeYouTube(String videoId) {
    _youtubeController = yt_mobile.YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const yt_mobile.YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        loop: true,
        enableJavaScript: true,
      ),
    );
    setState(() => _isVideoInitialized = true);
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(label.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))),
        Expanded(flex: 5, child: Row(children: List.generate(5, (index) => Expanded(child: Container(height: 8, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(color: index < value ? Colors.greenAccent : Colors.white10, borderRadius: BorderRadius.circular(2))))))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let the pattern show through
        appBar: AppBar(title: Text(widget.champion.name)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.champion.profileImage, height: 400, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Hero(tag: 'icon-${widget.champion.name}', child: Material(color: Colors.transparent, child: Text(widget.champion.icon, style: const TextStyle(fontSize: 100))))),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text(widget.champion.title, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey))),
              const Divider(height: 40, color: Colors.white24),
              ClipPath(clipper: PlaystyleClipper(), child: Container(padding: const EdgeInsets.fromLTRB(45, 5, 30, 5), decoration: const BoxDecoration(color: Colors.greenAccent), child: Text(widget.champion.playstyle.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)))),
              const SizedBox(height: 15),
              _buildStatRow("Range", widget.champion.stats.range), _buildStatRow("Power", widget.champion.stats.power), _buildStatRow("Vitality", widget.champion.stats.vitality), _buildStatRow("Mobility", widget.champion.stats.mobility), _buildStatRow("Ease of Use", widget.champion.stats.easeOfUse),
              const SizedBox(height: 30),
              const Text("SHOWCASE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
              const SizedBox(height: 8),
              
              // --- VIDEO FEED SECTION ---
              FutureBuilder<String>(
                future: _videoFuture,
                builder: (context, snapshot) {
                  if (!_isVideoInitialized) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white10,
                      child: const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
                    );
                  }
                  return Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: yt_mobile.YoutubePlayer(controller: _youtubeController!),
                  );
                }
              ),
              
              const SizedBox(height: 24),
              const Text("BIO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
              const SizedBox(height: 10),
              Text(widget.champion.bio, style: const TextStyle(fontSize: 16, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}