import 'package:flutter/material.dart';
import 'landmark_detail_screen.dart';

class SanskrtiScreen extends StatelessWidget {
  const SanskrtiScreen({super.key});

  // Hardcoded list of important landmarks with stories
  static const List<Map<String, dynamic>> landmarks = [
    {
      'id': 'ram_ghat',
      'title': 'Ram Ghat',
      'subtitle': 'The Sacred Bathing Ghat',
      'image': 'assets/images/ram_ghat.jpg',
      'story': 'Ram Ghat is one of the most sacred bathing ghats in Ujjain, where pilgrims come to take a holy dip in the Shipra River. According to legend, Lord Rama himself visited this ghat during his exile. The ghat is believed to have the power to cleanse one\'s sins and purify the soul. Every morning, thousands of devotees gather here to witness the divine sunrise and offer prayers to the sacred river.',
      'significance': 'This ghat is considered one of the 84 ghats mentioned in ancient scriptures and is believed to be blessed by Lord Rama himself.',
    },
    {
      'id': 'mahakal_temple',
      'title': 'Mahakaleshwar Temple',
      'subtitle': 'The Jyotirlinga of Ujjain',
      'image': 'assets/images/mahakal_temple.jpg',
      'story': 'The Mahakaleshwar Temple is one of the 12 Jyotirlingas of Lord Shiva and is considered one of the most powerful temples in India. The temple houses the Swayambhu (self-manifested) lingam of Lord Shiva. According to mythology, the temple was established when Lord Shiva appeared to save the city of Ujjain from the demon Dushana. The temple is known for its unique Bhasma Aarti, performed with sacred ash from the cremation grounds.',
      'significance': 'This is the only Jyotirlinga that faces south, symbolizing the power of Lord Shiva to protect from all directions.',
    },
    {
      'id': 'harsiddhi_temple',
      'title': 'Harsiddhi Temple',
      'subtitle': 'The Shakti Peeth',
      'image': 'assets/images/harsiddhi_temple.jpg',
      'story': 'The Harsiddhi Temple is one of the 51 Shakti Peethas, where the elbow of Goddess Sati is believed to have fallen. The temple is dedicated to Goddess Annapurna and is considered extremely powerful for fulfilling wishes. According to legend, King Vikramaditya was blessed by the goddess here, which led to his great prosperity and wisdom. The temple is known for its unique architecture and the presence of two sacred lamps that are said to have been burning continuously for centuries.',
      'significance': 'This temple is believed to grant all wishes and is especially powerful for those seeking prosperity and wisdom.',
    },
    {
      'id': 'kal_bhairav_temple',
      'title': 'Kal Bhairav Temple',
      'subtitle': 'The Guardian of Ujjain',
      'image': 'assets/images/kal_bhairav_temple.jpg',
      'story': 'The Kal Bhairav Temple is dedicated to Lord Bhairav, the fierce form of Lord Shiva and the guardian deity of Ujjain. The temple is known for its unique tradition of offering alcohol to the deity, which is considered a sacred offering. According to legend, Lord Bhairav protects the city of Ujjain from all negative energies and evil forces. The temple is believed to have the power to remove obstacles and provide protection to devotees.',
      'significance': 'Lord Bhairav is considered the Kotwal (guardian) of Ujjain and is believed to protect the city and its devotees.',
    },
    {
      'id': 'sandipani_ashram',
      'title': 'Sandipani Ashram',
      'subtitle': 'The Ancient School of Wisdom',
      'image': 'assets/images/sandipani_ashram.jpg',
      'story': 'Sandipani Ashram is the ancient school where Lord Krishna, along with his friend Sudama, received their education. The ashram is located near the Shipra River and is considered a place of great learning and wisdom. According to legend, Lord Krishna learned 64 arts and sciences here, including music, dance, warfare, and philosophy. The ashram is still considered a center of spiritual learning and attracts scholars and devotees from all over the world.',
      'significance': 'This ashram represents the importance of education and the pursuit of knowledge in Hindu culture.',
    },
    {
      'id': 'shipra_river',
      'title': 'Shipra River',
      'subtitle': 'The Sacred River of Ujjain',
      'image': 'assets/images/shipra_river.jpg',
      'story': 'The Shipra River is considered one of the most sacred rivers in India and is central to the religious life of Ujjain. According to mythology, the river was created by Lord Shiva himself to provide water for the holy city. The river is believed to have the power to cleanse sins and purify the soul. Every 12 years, the Kumbh Mela is held on the banks of the Shipra, where millions of devotees gather to take a holy dip and seek spiritual blessings.',
      'significance': 'The Shipra River is considered as sacred as the Ganges and is believed to have the power to grant moksha (liberation).',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'Sanskrti',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.temple_hindu,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Cultural Immersion',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Discover the rich heritage and spiritual significance of Ujjain\'s sacred landmarks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Landmarks List
            const Text(
              'Sacred Landmarks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            ...landmarks.map((landmark) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandmarkDetailScreen(landmark: landmark),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Placeholder for image
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.temple_hindu,
                            size: 40,
                            color: Colors.purple.shade600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                landmark['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                landmark['subtitle'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    size: 16,
                                    color: Colors.purple.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Tap to explore story',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.purple.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),

            const SizedBox(height: 20),

            // Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'About Sanskrti',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sanskrti means "culture" in Sanskrit. This module helps you understand the spiritual and cultural significance of Ujjain\'s sacred places, enriching your pilgrimage experience with knowledge and reverence.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

