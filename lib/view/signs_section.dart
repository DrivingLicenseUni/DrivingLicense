import "package:flutter/material.dart";
import "package:license/res/colors.dart";
import "package:license/res/textstyles.dart";

class SignsSection extends StatefulWidget {
  const SignsSection({super.key});

  @override
  State<SignsSection> createState() => _SignsSectionState();
}

class _SignsSectionState extends State<SignsSection> {
  bool isSamplesSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theory Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: ToggleButtons(
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
              onPressed: (index) {
                setState(() {
                  isSamplesSelected = index == 1;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          _buildSignsSections(
            "Mandatory Signs",
            [
              _SignData('Turn Left Prohibited',
                  'assets/images/turn-left-prohibited.jpg'),
              _SignData('No Entry', 'assets/images/no-entry-traffic.png'),
            ],
          ),
          SizedBox(height: 15),
          _buildSignsSections(
            "Cautionary Signs",
            [
              _SignData(
                  'Left Reverse Bend', 'assets/images/left-reverse-bend.png'),
              _SignData('Narrow Bridge', 'assets/images/narrow-road-ahead.png'),
            ],
          ),
          SizedBox(height: 15),
          _buildSignsSections(
            "Informatory Signs",
            [
              _SignData('Left Reverse Bend', 'assets/images/hospital.png'),
              _SignData('Narrow Bridge', 'assets/images/fuel-station.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignsSections(String mainTitle, List<_SignData> signs) {
    return Column(
      children: [
        Text(
          mainTitle,
          style: AppTextStyles.title,
        ),
        SizedBox(height: 16),
        Row(
          children: signs
              .map(
                (sign) => Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        sign.image,
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        sign.title,
                        style: AppTextStyles.labelRegular,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SignData {
  final String title;
  final String image;

  _SignData(this.title, this.image);
}
