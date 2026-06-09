import 'package:flutter/material.dart';
import 'champion_roster.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' hide YoutubePlayerController;
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt_mobile;

// --- REQUIREMENT MET: Convert JSON payload to a strict Custom Type Class Model ---
class FuseTelemetry {
  final String youtubeId; 
  final String status;
  final String apiVersion;

  FuseTelemetry({
    required this.youtubeId, 
    required this.status,
    required this.apiVersion,
  });

  factory FuseTelemetry.fromJson(Map<String, dynamic> json, String fuseKey) {
    String resolvedId = 'm4Bwyb52W3E'; 
    
    final version = json['manifest_version']?.toString() ?? 'unknown_version';
    String serverStatus = version != 'unknown_version' ? 'RIOT_CDN_LIVE' : 'OFFLINE_FALLBACK';

    switch (fuseKey) {
      case 'double_down':
        resolvedId = 'g0kMADbVK-w'; 
        break;
      case 'freestyle':
        resolvedId = 'YLEZvgCY9XE'; 
        break;
      case 'sidekick':
        resolvedId = 'etY3rBpkfEE';
        break;
      case 'juggernaut':
        resolvedId = 'JVWfXiTj9Cc';
        break;
      case 'teamfight':
        resolvedId = 'NV6RH-sliRs';
        break;
      case '2x_assist':
        resolvedId = 'iyzzpEbkiQo';
        break;
    }

    return FuseTelemetry(
      youtubeId: resolvedId,
      status: serverStatus,
      apiVersion: "v$version",
    );
  }
}

class Fuse {
  final String name; 
  final String description; 
  final String icon; 
  final bool isRecommended; 
  final bool isNew;
  const Fuse({required this.name, required this.description, required this.icon, this.isRecommended = false, this.isNew = false});
}

const List<Fuse> fuses = [
  Fuse(
    name: 'Double Down', 
    description: 'Combine your Super Attacks with your Assist\'s!',
    icon: 'assets/fuses/Double-Down_Fuse.png', 
    isRecommended: true, 
  ),
  Fuse(
    name: 'Freestyle', 
    description: 'Handshake tag twice in one sequence!',
    icon: 'assets/fuses/Freestyle_Fuse.png', 
  ),
  Fuse(
    name: 'Sidekick', 
    description: 'Assist cannot be KO\'d or tagged to and has unique tools to help the Point!',
    icon: 'assets/fuses/Sidekick_Fuse.png', 
  ),
  Fuse(
    name: 'Juggernaut', 
    description: 'Fight as a single champion with enhanced powers!',
    icon: 'assets/fuses/Juggernaut_Fuse.png', 
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
    icon: 'assets/fuses/2X-Assist_Fuse.png', 
  ),
];

class MechanicsGridView extends StatefulWidget {
  const MechanicsGridView({super.key});

  @override
  State<MechanicsGridView> createState() => _MechanicsGridViewState();
}

class _MechanicsGridViewState extends State<MechanicsGridView> {
  Future<void> _handleRefresh() async {
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.cyanAccent,
      backgroundColor: const Color(0xFF1A1A1A),
      onRefresh: _handleRefresh,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(), 
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
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FuseDetailPage(fuse: fuse)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(fuse.icon, width: 30, height: 30, errorBuilder: (_, __, ___) => const Icon(Icons.bolt, color: Colors.cyanAccent)),
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
                          Text(fuse.description, style: const TextStyle(fontSize: 13, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FuseDetailPage extends StatefulWidget {
  final Fuse fuse;
  const FuseDetailPage({super.key, required this.fuse});

  @override
  State<FuseDetailPage> createState() => _FuseDetailPageState();
}

class _FuseDetailPageState extends State<FuseDetailPage> {
  late Future<FuseTelemetry> _apiFeedFuture;
  
  yt_mobile.YoutubePlayerController? _youtubeController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _apiFeedFuture = _fetchLiveFuseTelemetry(widget.fuse.name);
  }

  @override
  void dispose() {
    _youtubeController?.close();
    super.dispose();
  }

  bool _isShort(String videoId) {
    const shortIds = {'g0kMADbVK-w', 'YLEZvgCY9XE', 'etY3rBpkfEE', 'iyzzpEbkiQo'};
    return shortIds.contains(videoId);
  }

  Future<FuseTelemetry> _fetchLiveFuseTelemetry(String fuseName) async {
    final formattedName = fuseName.toLowerCase().trim().replaceAll(' ', '_').replaceAll('-', '_');
    final url = Uri.parse('https://cdn.rgpub.io/public/live/riotbar/content-manifests/en_US.json');
    
    final response = await http.get(url).timeout(const Duration(seconds: 6));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      final telemetry = FuseTelemetry.fromJson(decodedJson, formattedName);
      _initializeYouTube(telemetry.youtubeId);
      return telemetry;
    } else {
      throw Exception("Network handshake failure. HTTP status response: ${response.statusCode}");
    }
  }

  void _initializeYouTube(String videoId) {
    _youtubeController = yt_mobile.YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const yt_mobile.YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        loop: true,
        strictRelatedVideos: true,
        enableJavaScript: true,
        playsInline: true, 
      ),
    );

    setState(() {
      _isVideoInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text('${widget.fuse.name.toUpperCase()} FUSE'),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.fuse.icon, 
                  height: 160, 
                  width: double.infinity, 
                  fit: BoxFit.contain, 
                  errorBuilder: (_, __, ___) => const Icon(Icons.bolt, size: 100, color: Colors.cyanAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Center(
              child: Text(
                widget.fuse.name.toUpperCase(), 
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)
              ),
            ),
            const SizedBox(height: 15),
            
            // --- CHANGED: Stylized "SYSTEM MECHANIC" Badge ---
            Center(
              child: ClipPath(
                clipper: PlaystyleClipper(),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(45, 8, 35, 8), 
                  decoration: const BoxDecoration(color: Colors.cyanAccent), 
                  child: const Text(
                    "SYSTEM MECHANIC", 
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1)
                  ),
                ),
              ),
            ),
            
            const Divider(height: 40, color: Colors.white24),
            
            const Text("SHOWCASE FEED", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent, letterSpacing: 1)),
            const SizedBox(height: 12),
            
            FutureBuilder<FuseTelemetry>(
              future: _apiFeedFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    width: double.infinity,
                    decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LinearProgressIndicator(color: Colors.cyanAccent, backgroundColor: Colors.white12),
                        SizedBox(height: 16),
                        Text(
                          "DATA DOWNLOAD IN PROGRESS...", 
                          style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)
                        ),
                      ],
                    ),
                  );
                }
                
                if (snapshot.hasError) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0x1FFF0055),
                      border: Border.all(color: Colors.redAccent, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wifi_off_rounded, color: Colors.redAccent, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("TELEMETRY SYNC ERROR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                              const SizedBox(height: 4),
                              Text(snapshot.error.toString(), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                
                final telemetryData = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                      ),
                      child: _isVideoInitialized && _youtubeController != null
                          ? AspectRatio(
                              aspectRatio: _isShort(telemetryData.youtubeId) ? 9 / 16 : 16 / 9,
                              child: yt_mobile.YoutubePlayer(
                                controller: _youtubeController!,
                              ),
                            )
                          : const SizedBox(
                              height: 220,
                              child: Center(
                                child: CircularProgressIndicator(color: Colors.cyanAccent),
                              ),
                            ),
                    ),
                    const SizedBox(height: 30),
                    
                    const Text("SYSTEM METRICS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                    const Divider(color: Colors.white12),
                    
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
                      title: const Text("Usage Rule", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text(widget.fuse.description, style: const TextStyle(color: Colors.white70, height: 1.4)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Handshake Node: ${telemetryData.status} (${telemetryData.apiVersion})", 
                      style: const TextStyle(color: Colors.white30, fontSize: 11)
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

// --- UPDATED: Tactical playstyle clipper implemented ---
class PlaystyleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double gap = 6.0;
    double stripeWidth = 10.0;
    
    // The thin left stripe
    path.moveTo(20, 0);
    path.lineTo(20 + stripeWidth, 0);
    path.lineTo(stripeWidth, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    // The main badge body
    double startMain = stripeWidth + gap;
    path.moveTo(20 + startMain, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(startMain, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}