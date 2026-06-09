import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'favorites_page.dart';
import 'background_pattern.dart';
import 'terminology_detail.dart';

class GlossaryTerm {
  final String term;
  final String definition;

  GlossaryTerm({required this.term, required this.definition});

  factory GlossaryTerm.fromJson(Map<String, dynamic> json) {
    return GlossaryTerm(
      term: json['term'] ?? 'Unknown Term', 
      definition: json['def'] ?? 'No definition available', 
    );
  }
}

class ApiService {
  static Future<List<GlossaryTerm>> fetchGlossary() async {
    final response = await http.get(
      Uri.parse('https://glossary.infil.net/json/glossary.json'),
      headers: {'User-Agent': 'FlutterApp/1.0'},
    );
    
    if (response.statusCode == 200) {
      // 1. Decode the response body as a List
      final List<dynamic> jsonList = json.decode(response.body);
      //debugPrint("FIRST ITEM: ${jsonList[0]}");
      
      // 2. Map the List of JSON objects to a List of GlossaryTerm objects
      return jsonList.map((json) => GlossaryTerm.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load glossary: ${response.statusCode}');
    }
  }
}

class MechanicsGlossary extends StatefulWidget {
  const MechanicsGlossary({super.key});

  @override
  State<MechanicsGlossary> createState() => _MechanicsGlossaryState();
}

class _MechanicsGlossaryState extends State<MechanicsGlossary> {
  List<dynamic> allTerms = [];
  List<dynamic> filteredTerms = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() { _isLoading = true; _hasError = false; });
    try {
      // Note: This now returns List<GlossaryTerm>
      final List<GlossaryTerm> terms = await ApiService.fetchGlossary();
      setState(() {
        allTerms = terms;
        filteredTerms = terms;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("API ERROR: $e");
      setState(() { _isLoading = false; _hasError = true; });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      filteredTerms = allTerms.where((item) {
        // FIX: Use 'item.term' instead of 'item['term']'
        final term = item.term.toLowerCase(); 
        return term.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPattern(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SearchBar(
              hintText: 'Search terms (e.g., "Hitstun")...',
              onChanged: _filterSearch,
              leading: const Icon(Icons.search, color: Colors.cyanAccent),
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(color: Colors.cyanAccent),
          if (_hasError) 
            Expanded(child: Center(child: TextButton(onPressed: _loadData, child: const Text('Sync Failed. Retry?')))),
          if (!_isLoading && !_hasError)
            Expanded(
              child: RefreshIndicator(
                color: Colors.cyanAccent,
                onRefresh: _loadData,
                child: ListView.builder(
                  itemCount: filteredTerms.length,
                  itemBuilder: (context, index) {
                    final item = filteredTerms[index];
                    return Card(
                      child: ListTile(
                        // We use a Row to put the text and the icon side-by-side inside the title area
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.term, 
                                style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                FavoritesManager.isFavorite(item.term) ? Icons.star : Icons.star_border,
                                color: Colors.amber, // Yellow color for the star
                              ),
                              // This keeps the icon close to the text
                              padding: EdgeInsets.zero, 
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                setState(() {
                                  FavoritesManager.toggle(item.term, item.definition);
                                });
                              },
                            ),
                          ],
                        ),
                        //subtitle: Text(item.definition),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TerminologyDetail(
                                term: item.term, 
                                definition: item.definition, // Pass the definition here
                              ),
                            ),
                          );
                        },
                      )
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}