import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () {
              // TODO: Implement gallery picker
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Scanner Screen - Coming Soon'),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          // TODO: Implement camera scanning
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
