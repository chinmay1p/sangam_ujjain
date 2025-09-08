import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';
import 'landmark_detail_screen.dart';

class SanskrtiScreen extends StatefulWidget {
  const SanskrtiScreen({super.key});

  @override
  State<SanskrtiScreen> createState() => _SanskrtiScreenState();
}

class _SanskrtiScreenState extends State<SanskrtiScreen> {
  final Set<String> _visitedIds = <String>{};

  // Updated landmarks with proper asset paths
  static const List<Map<String, dynamic>> landmarks = [
    {
      'id': 'ram_ghat',
      'title': 'Ram Ghat',
      'subtitle': 'The Sacred Bathing Ghat',
      'image': 'assets/ram ghat.png',
      'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
      'story': 'Ram Ghat is one of the most sacred bathing ghats in Ujjain, where pilgrims come to take a holy dip in the Shipra River. According to legend, Lord Rama himself visited this ghat during his exile. The ghat is believed to have the power to cleanse one\'s sins and purify the soul. Every morning, thousands of devotees gather here to witness the divine sunrise and offer prayers to the sacred river.',
      'significance': 'This ghat is considered one of the 84 ghats mentioned in ancient scriptures and is believed to be blessed by Lord Rama himself.',
    },
    {
      'id': 'mahakal_temple',
      'title': 'Mahakaleshwar Temple',
      'subtitle': 'The Jyotirlinga of Ujjain',
      'image': 'assets/mahakaleshwar temple.png',
      'video': 'https://youtu.be/3P-Xz0MMxw8?feature=shared',
      'story': 'The Mahakaleshwar Temple is one of the 12 Jyotirlingas of Lord Shiva and is considered one of the most powerful temples in India. The temple houses the Swayambhu (self-manifested) lingam of Lord Shiva. According to mythology, the temple was established when Lord Shiva appeared to save the city of Ujjain from the demon Dushana. The temple is known for its unique Bhasma Aarti, performed with sacred ash from the cremation grounds.',
      'significance': 'This is the only Jyotirlinga that faces south, symbolizing the power of Lord Shiva to protect from all directions.',
    },
    {
      'id': 'harsiddhi_temple',
      'title': 'Harsiddhi Temple',
      'subtitle': 'The Shakti Peeth',
      'image': 'assets/harsiddhi temple.png',
      'video': 'https://youtu.be/u_TTxtVegcY?feature=shared',
      'story': 'The Harsiddhi Temple is one of the 51 Shakti Peethas, where the elbow of Goddess Sati is believed to have fallen. The temple is dedicated to Goddess Annapurna and is considered extremely powerful for fulfilling wishes. According to legend, King Vikramaditya was blessed by the goddess here, which led to his great prosperity and wisdom. The temple is known for its unique architecture and the presence of two sacred lamps that are said to have been burning continuously for centuries.',
      'significance': 'This temple is believed to grant all wishes and is especially powerful for those seeking prosperity and wisdom.',
    },
    {
      'id': 'kal_bhairav_temple',
      'title': 'Kal Bhairav Temple',
      'subtitle': 'The Guardian of Ujjain',
      'image': 'assets/kal bhairav temple.png',
      'video': 'https://youtu.be/VVFHUjWGjvQ?feature=shared',
      'story': 'The Kal Bhairav Temple is dedicated to Lord Bhairav, the fierce form of Lord Shiva and the guardian deity of Ujjain. The temple is known for its unique tradition of offering alcohol to the deity, which is considered a sacred offering. According to legend, Lord Bhairav protects the city of Ujjain from all negative energies and evil forces. The temple is believed to have the power to remove obstacles and provide protection to devotees.',
      'significance': 'Lord Bhairav is considered the Kotwal (guardian) of Ujjain and is believed to protect the city and its devotees.',
    },
    {
      'id': 'sandipani_ashram',
      'title': 'Sandipani Ashram',
      'subtitle': 'The Ancient School of Wisdom',
      'image': 'assets/sandipani ashram.png',
      'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
      'story': 'Sandipani Ashram is the ancient school where Lord Krishna, Balarama, and Sudama received their education. The ashram is located on the banks of the Shipra River and is considered one of the most sacred places in Ujjain. According to legend, Lord Krishna learned all 64 arts and sciences here under the guidance of Guru Sandipani. The ashram is known for its peaceful atmosphere and spiritual energy.',
      'significance': 'This ashram is considered the birthplace of divine knowledge and is believed to bless students and seekers with wisdom.',
    },
    {
      'id': 'shipra_river',
      'title': 'Shipra River',
      'subtitle': 'The Sacred River of Ujjain',
      'image': 'assets/shipra river.png',
      'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
      'story': 'The Shipra River is considered one of the most sacred rivers in India and is believed to have the power to cleanse sins and purify the soul. According to mythology, the river was created by Lord Shiva himself and is considered as holy as the Ganges. The river is known for its crystal-clear water and is surrounded by numerous ghats where pilgrims come to take holy dips. The river is especially sacred during the Kumbh Mela when millions of devotees gather to bathe in its waters.',
      'significance': 'The Shipra River is considered as sacred as the Ganges and is believed to have the power to grant moksha (liberation).',
    },
  ];

  int get _punyaPoints => _visitedIds.length * 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Sanskriti',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 24),
              onPressed: () {
                // TODO: Implement camera functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Camera functionality coming soon!',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.shade600,
                  Colors.orange.shade400,
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Sacred Landmarks of Ujjain',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover the spiritual heritage and ancient wisdom',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                // Dharma Trail Progress Banner
                Consumer<UserProvider>(
                  builder: (context, userProvider, _) {
                    final int digitalPunya = userProvider.user?.punya ?? 0;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.emoji_nature, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Dharma Trail Progress: $digitalPunya punya points',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Landmarks Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 280,
                ),
                itemCount: landmarks.length,
                itemBuilder: (context, index) {
                  final landmark = landmarks[index];
                  final String id = landmark['id'] as String;
                  final bool isVisited = _visitedIds.contains(id);
                  return _buildLandmarkCard(context, landmark, index, isVisited, () async {
                    setState(() {
                      if (isVisited) {
                        _visitedIds.remove(id);
                      } else {
                        _visitedIds.add(id);
                      }
                    });
                    await _saveVisited();
                    if (!isVisited) {
                      // Add +5 to the user's digital punya when marking visited
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      await userProvider.incrementPunya(5);
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadVisited();
  }

  Future<void> _loadVisited() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList('sanskriti_visited') ?? <String>[];
    setState(() {
      _visitedIds
        ..clear()
        ..addAll(stored);
    });
  }

  Future<void> _saveVisited() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('sanskriti_visited', _visitedIds.toList());
  }

  Widget _buildLandmarkCard(
    BuildContext context,
    Map<String, dynamic> landmark,
    int index,
    bool isVisited,
    VoidCallback onToggleVisited,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LandmarkDetailScreen(landmark: landmark),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    landmark['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                // (Removed) Decorative curved trail overlay per request

                // Visited check overlay
                Positioned(
                  top: 10,
                  left: 10,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: isVisited ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3)),
                        ],
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 16),
                    ),
                  ),
                ),
                
                // Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          landmark['title'],
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          landmark['subtitle'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 0.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Mark Visited button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: onToggleVisited,
                            icon: Icon(isVisited ? Icons.check_circle : Icons.flag, size: 16),
                            label: Text(isVisited ? 'Visited' : 'Mark Visited', style: GoogleFonts.openSans(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              backgroundColor: isVisited ? Colors.green.shade600 : Colors.orange.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Action Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionIcon(
                              Icons.translate,
                              '',
                              Colors.blue,
                            ),
                            _buildActionIcon(
                              Icons.share,
                              '',
                              Colors.green,
                            ),
                            _buildActionIcon(
                              Icons.directions,
                              '',
                              Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Camera Icon (top right)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 18,
      ),
    );
  }
}

// Curved trail painter removed per request