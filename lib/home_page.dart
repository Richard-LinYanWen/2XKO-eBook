import 'package:flutter/material.dart';
import 'champion_roster.dart';
import 'fuse_mechanic.dart';
import 'mechanics_glossary.dart';
import 'background_pattern.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundPattern(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.transparent, // Let the pattern show through
          appBar: AppBar(
            title: const Text('2XKO HANDBOOK', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
            bottom: const TabBar(
              indicatorColor: Colors.cyanAccent,
              tabs: [
                Tab(text: "CHAMPIONS"),
                Tab(text: "FUSES"),
                Tab(text: "TERMINOLOGY"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RosterListView(),
              MechanicsGridView(),
              MechanicsGlossary(),
            ],
          ),
        ),
      ),
    );
  }
}