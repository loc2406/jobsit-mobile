import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppliedJobScreen extends StatefulWidget {
  const AppliedJobScreen({super.key});

  @override
  State<AppliedJobScreen> createState() => _AppliedJobScreenState();
}

class _AppliedJobScreenState extends State<AppliedJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Applied jobs'),
    );
  }
}