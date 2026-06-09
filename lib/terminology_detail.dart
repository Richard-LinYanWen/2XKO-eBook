import 'package:flutter/material.dart';
import 'background_pattern.dart';
import 'favorites_page.dart';

class TerminologyDetail extends StatefulWidget {
  final String term;
  final String definition; // Add this

  const TerminologyDetail({
    super.key, 
    required this.term, 
    required this.definition, // Update constructor
  });

  @override
  State<TerminologyDetail> createState() => _TerminologyDetailState();
}

class _TerminologyDetailState extends State<TerminologyDetail> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = FavoritesManager.isFavorite(widget.term);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Details"),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                _isFavorited ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _isFavorited = !_isFavorited;
                  FavoritesManager.toggle(widget.term, widget.definition);
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.term.toUpperCase(),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              const Divider(color: Colors.amber, thickness: 2),
              const SizedBox(height: 20),
              
              // DISPLAY THE PASSED DEFINITION
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.definition, // Using the passed definition directly
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}