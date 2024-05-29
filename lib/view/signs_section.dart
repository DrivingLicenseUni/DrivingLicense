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
          _buildSignsSectionPage(context),
        ],
      ),
    );
  }

  Widget _buildSignsSectionPage(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildSignsSections(
          context,
          "Mandatory Signs",
          [
            _SignData(
              title: 'Turn Left Prohibited',
              image: 'assets/images/turn-left-prohibited.jpg',
              description:
                  'A "Turn Left Prohibited" sign, showing a left arrow with a red slash, indicates that left turns are not allowed at that location, enhancing traffic flow and safety.',
            ),
            _SignData(
              title: 'No Entry',
              image: 'assets/images/no-entry-traffic.png',
              description:
                  'A "No Entry" traffic sign, usually a red circle with a white horizontal bar, indicates that vehicles are not allowed to enter the roadway beyond the sign, ensuring restricted access for safety and traffic management.',
            ),
          ],
        ),
        SizedBox(height: 15),
        _buildSignsSections(
          context,
          "Cautionary Signs",
          [
            _SignData(
              title: 'Left Reverse Bend',
              image: 'assets/images/left-reverse-bend.png',
              description: 'Left Reverse Bend',
            ),
            _SignData(
              title: 'Narrow Bridge',
              image: 'assets/images/narrow-road-ahead.png',
              description: 'Narrow Road Ahead',
            ),
          ],
        ),
        SizedBox(height: 15),
        _buildSignsSections(
          context,
          "Informatory Signs",
          [
            _SignData(
              title: 'Hospital',
              image: 'assets/images/hospital.png',
              description: 'A nearby hospital',
            ),
            _SignData(
              title: 'Narrow Bridge',
              image: 'assets/images/fuel-station.png',
              description: 'Petrol Pump',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignsSections(
      BuildContext context, String mainTitle, List<_SignData> signs) {
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/sign-details",
                        arguments: {
                          'title': sign.title,
                          'image': sign.image,
                          'description': sign.description,
                        },
                      );
                    },
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
  final String description;

  _SignData(
      {required this.title, required this.image, required this.description});
}
