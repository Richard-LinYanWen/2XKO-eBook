import 'package:flutter/material.dart';
import 'champion_roster.dart';

class Fuse {
  final String name; final String description; final String icon; final bool isRecommended; final bool isNew;
  const Fuse({required this.name, required this.description, required this.icon, this.isRecommended = false, this.isNew = false});
}

const List<Fuse> fuses = [
  Fuse(
    name: 'Double Down', 
    description: 'Combine your Super Attacks with your Assist\'s!',
    icon: 'assets/fuses/Double-Down_Fuse.png', // Custom image for the fuse
    isRecommended: true, // Highlight this as a recommended fuse
  ),
  Fuse(
    name: 'Freestyle', 
    description: 'Handshake tag twice in one sequence!',
    icon: 'assets/fuses/Freestyle_Fuse.png', // Custom image for the fuse
  ),
  Fuse(
    name: 'Sidekick', 
    description: 'Assist cannot be KO\'d or tagged to and has unique tools to help the Point!',
    icon: 'assets/fuses/Sidekick_Fuse.png', // Custom image for the fuse
  ),
  Fuse(
    name: 'Juggernaut', 
    description: 'Fight as a single champion with enhanced powers!',
    icon: 'assets/fuses/Juggernaut_Fuse.png', // Custom image for the fuse
  ),
  Fuse(
    name: 'Teamfight',
    description: 'Point and Assist fight simultaneously for a short burst!',
    icon: 'assets/fuses/Teamfight_Fuse.png',
    isNew: true,
  ),
  Fuse(
    name: '2X Assist', 
    description: 'Empower your partner with multiple Assist Actions!',
    icon: 'assets/fuses/2X-Assist_Fuse.png', // Custom image for the fuse
  ),
];

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
              // Navigates directly to the new API showcase screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FuseDetailPage(fuse: fuse)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset(fuse.icon, width: 30, height: 30),
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
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.white),
                            ),
                            if (fuse.isRecommended) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), 
                                decoration: BoxDecoration(color: Colors.yellowAccent, borderRadius: BorderRadius.circular(4)), 
                                child: const Text("RECOMMENDED!", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                            if (fuse.isNew) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), 
                                decoration: BoxDecoration(color: const Color(0xffe60042), borderRadius: BorderRadius.circular(4)), 
                                child: const Text("NEW!", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(fuse.description, style: const TextStyle(fontSize: 13, color: Colors.grey)),
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

// --- FIXED PAGE: FUSE API DETAIL SHOWCASE VIEW ---
class FuseDetailPage extends StatelessWidget {
  final Fuse fuse;
  const FuseDetailPage({super.key, required this.fuse});

  // API 2 Stream simulator parsing complex JSON dictionary trees (Only handles showcase media now)
  Future<Map<String, String>> _fetchFuseTelemetryStream() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return {
      'clipUrl': 'https://api.2xko.riotgames.com/v1/fuses/media/${fuse.name.toLowerCase().replaceAll(' ', '_')}.mp4',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${fuse.name.toUpperCase()} FUSE')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // REQUIREMENT 2: High-res asset PNG showcased right at the top (matches Champion profile style)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  fuse.icon, 
                  height: 200, 
                  width: double.infinity, 
                  fit: BoxFit.contain, 
                  errorBuilder: (_, __, ___) => const Icon(Icons.bolt, size: 100, color: Colors.cyanAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // REQUIREMENT 1: Structural Title & Header elements wrapped with the exact custom Playstyle badge clipper style
            Center(
              child: Text(
                fuse.name.toUpperCase(), 
                style: const TextStyle(fontSize: 26, color: Colors.black, letterSpacing: 1.5)
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ClipPath(
                clipper: PlaystyleClipper(), 
                child: Container(
                  padding: const EdgeInsets.fromLTRB(45, 6, 30, 6), 
                  decoration: const BoxDecoration(color: Colors.cyanAccent), 
                  child: const Text(
                    "SYSTEM MECHANIC", 
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1)
                  ),
                ),
              ),
            ),
            
            const Divider(height: 40, color: Colors.white24),
            
            // Interactive Video Wireframe Display Layer
            const Text("SHOWCASE FEED", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent, letterSpacing: 1)),
            const SizedBox(height: 12),
            
            FutureBuilder<Map<String, String>>(
              future: _fetchFuseTelemetryStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.black26,
                    child: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
                  );
                }
                
                final apiData = snapshot.data ?? {};
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Player Canvas Placeholder
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.1,
                              child: Image.asset(fuse.icon, fit: BoxFit.cover, errorBuilder: (_,__,___)=>const SizedBox()),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_circle_fill, size: 50, color: Colors.cyanAccent),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Streaming: ${apiData['clipUrl']}", 
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 10, color: Colors.grey, fontFamily: 'monospace'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    const Text("SYSTEM METRICS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                    const Divider(color: Colors.white12),
                    
                    // REQUIREMENT 3: Usage Rule utilizes local static description data directly
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
                      title: const Text("Usage Rule", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(fuse.description, style: const TextStyle(color: Colors.white70, height: 1.4)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}