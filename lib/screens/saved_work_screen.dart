import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedWorkScreen extends StatefulWidget {
  const SavedWorkScreen({super.key});

  @override
  State<SavedWorkScreen> createState() => _SavedWorkScreenState();
}

class _SavedWorkScreenState extends State<SavedWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Saved work'),
    );
  }
}
