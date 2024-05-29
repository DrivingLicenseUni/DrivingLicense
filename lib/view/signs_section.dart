import "package:flutter/material.dart";
import "package:license/res/textstyles.dart";

class SignsSection extends StatelessWidget {
  const SignsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          _buildSignsSectionPage(),
        ],
      ),
    );
  }

  Widget _buildSignsSectionPage() {
    return Column(
      children: [
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
