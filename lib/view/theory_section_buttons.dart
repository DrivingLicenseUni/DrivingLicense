import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';

class TheorySectionToggleButtons extends StatelessWidget {
  final bool isSamplesSelected;
  final Function(int) onPressed;

  const TheorySectionToggleButtons({
    Key? key,
    required this.isSamplesSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(20),
      selectedColor: AppColors.black,
      fillColor: AppColors.secondaryBlue,
      color: AppColors.black,
      borderColor: AppColors.placeholder,
      selectedBorderColor: AppColors.primary,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Text('Signs'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Text('Samples'),
        ),
      ],
      isSelected: [!isSamplesSelected, isSamplesSelected],
      onPressed: onPressed,
    );
  }
}
