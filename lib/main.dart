import 'package:flutter/material.dart';
import 'champion_roster.dart';
import 'fuse_mechanic.dart';
import 'mechanics_glossary.dart';

void main() => runApp(const ProjectLWikiApp());

class ProjectLWikiApp extends StatelessWidget {
  const ProjectLWikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2XKO Terminal Portal',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyanAccent,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('2XKO HANDBOOK', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
          bottom: const TabBar(
            indicatorColor: Colors.cyanAccent,
            tabs: [
              Tab(text: "CHAMPIONS"),
              Tab(text: "FUSES"),
              Tab(text: "MECHANICS"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RosterListView(), // Routed from champion_list_view.dart
            MechanicsGridView(), // Routed from mechanics_grid_view.dart
            MechanicsGlossary(), // Routed from mechanics_glossary.dart
          ],
        ),
      ),
    );
  }
}