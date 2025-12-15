import 'package:flutter/material.dart';

class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Decks'),
      ),
      body: const Center(
        child: Text('Decks Screen - Coming Soon'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Create new deck
        },
        icon: const Icon(Icons.add),
        label: const Text('New Deck'),
      ),
    );
  }
}
