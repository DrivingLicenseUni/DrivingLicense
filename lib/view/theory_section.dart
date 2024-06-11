import 'package:flutter/material.dart';
import 'package:license/view/signs_section.dart';
import 'package:license/view/theory_exams_section.dart';
import 'package:license/view/theory_section_buttons.dart';

class TheorySection extends StatefulWidget {
  const TheorySection({super.key});

  @override
  State<TheorySection> createState() => _TheorySectionState();
}

class _TheorySectionState extends State<TheorySection> {
  bool isSamplesSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theory Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          TheorySectionToggleButtons(
            isSamplesSelected: isSamplesSelected,
            onPressed: (index) {
              setState(() {
                isSamplesSelected = index == 1;
              });
            },
          ),
          Expanded(
            child: isSamplesSelected ? ExamsPage() : SignsSection(),
          ),
        ],
      ),
    );
  }
}
