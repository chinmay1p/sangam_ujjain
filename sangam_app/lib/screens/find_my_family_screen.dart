import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FindMyFamilyScreen extends StatefulWidget {
  const FindMyFamilyScreen({super.key});

  @override
  State<FindMyFamilyScreen> createState() => _FindMyFamilyScreenState();
}

class _FindMyFamilyScreenState extends State<FindMyFamilyScreen> {
  bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find My Family', style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // simulate refresh
              if (_showMap) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Locations refreshed')));
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () => setState(() => _showMap = true),
                  child: const Text('Get Locations'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showMap ? _buildMapCard() : const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            if (_showMap) _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/family_map_placeholder.png', fit: BoxFit.cover),
          ),
          // Ayush marker
          Positioned(
            left: 60,
            top: 140,
            child: _buildMarker('Ayush'),
          ),
          // Sneh marker
          Positioned(
            right: 50,
            bottom: 80,
            child: _buildMarker('Sneh'),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(String name) {
    return Column(
      children: <Widget>[
        CircleAvatar(radius: 14, backgroundColor: Colors.orange.shade200, child: const Icon(Icons.person, size: 16, color: Colors.white)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade300)),
          child: Text(name, style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
        ),
      ],
    );
  }

  Widget _buildList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Nearby Family', style: GoogleFonts.rajdhani(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
          const SizedBox(height: 12),
          _buildPersonRow('Ayush', 'Ram Ghat'),
          const Divider(),
          _buildPersonRow('Sneh', 'Mahakaleshwar Temple'),
        ],
      ),
    );
  }

  Widget _buildPersonRow(String name, String place) {
    return Row(
      children: <Widget>[
        CircleAvatar(radius: 18, backgroundColor: Colors.orange.shade100, child: const Icon(Icons.person, color: Colors.orange)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            Text('Location: $place', style: GoogleFonts.openSans(fontSize: 12, color: Colors.grey.shade700)),
          ]),
        ),
      ],
    );
  }
}


