import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrowdNavigationScreen extends StatefulWidget {
  const CrowdNavigationScreen({super.key});

  @override
  State<CrowdNavigationScreen> createState() => _CrowdNavigationScreenState();
}

class _CrowdNavigationScreenState extends State<CrowdNavigationScreen> {
  static const List<String> kLocations = <String>[
    'Ram Ghat',
    'Mahakaleshwar Temple',
    'Medical Camp 1',
  ];

  String? _from;
  String? _to;
  bool _showRoute = false;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crowd-Aware Navigation',
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSafetyBanner(primary),
            const SizedBox(height: 16),
            _buildLocationPickers(primary),
            const SizedBox(height: 16),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showRoute ? 1.0 : 0.0,
              child: _buildMapAndSteps(primary),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showRoute = true; // demo only
                    });
                  },
                  child: const Text('Recalculate'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyBanner(Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.shield, color: Colors.green.shade700),
          const SizedBox(width: 10),
          Text(
            'Route Safety: High',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade800,
            ),
          ),
          const Spacer(),
          Row(children: <Widget>[
            Icon(Icons.circle, size: 10, color: Colors.green.shade400),
            const SizedBox(width: 4),
            Text('Low Crowd', style: GoogleFonts.openSans(fontSize: 12, color: Colors.green.shade700)),
          ])
        ],
      ),
    );
  }

  Widget _buildLocationPickers(Color primary) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildDropdownCard(
            label: 'From Location',
            value: _from,
            onChanged: (String? v) => setState(() {
              _from = v;
              _showRoute = _from != null && _to != null;
            }),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDropdownCard(
            label: 'To Location',
            value: _to,
            onChanged: (String? v) => setState(() {
              _to = v;
              _showRoute = _from != null && _to != null;
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCard({required String label, required String? value, required ValueChanged<String?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text('Select', style: GoogleFonts.openSans(color: Colors.grey.shade600)),
              items: _buildLocationItems(),
              onChanged: onChanged,
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildLocationItems() {
    return kLocations
        .map((String loc) => DropdownMenuItem<String>(
              value: loc,
              child: Text(loc, style: GoogleFonts.openSans(fontSize: 14)),
            ))
        .toList();
  }

  Widget _buildMapAndSteps(Color primary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/crowd_nav_map_placeholder.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        Text('Directions', style: GoogleFonts.rajdhani(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
        const SizedBox(height: 8),
        _buildStep('Start from ${_from ?? 'Ram Ghat'}'),
        _buildStep('Walk east for 500m'),
        _buildStep('Turn left toward ${_to ?? 'Mahakaleshwar Temple'}'),
      ],
    );
  }

  Widget _buildStep(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.circle, size: 10, color: Colors.orange),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: GoogleFonts.openSans(fontSize: 14, color: Colors.grey.shade800))),
      ],
    );
  }
}


