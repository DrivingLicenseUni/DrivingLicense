import "package:flutter/material.dart";
import "package:license/res/textstyles.dart";

class SignsSection extends StatefulWidget {
  const SignsSection({super.key});

  @override
  _SignsSectionState createState() => _SignsSectionState();
}

class _SignsSectionState extends State<SignsSection> {
  String? _selectedHeader;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          _buildHeaderDropdown(),
          _buildSignsSectionPage(context),
        ],
      ),
    );
  }

  Widget _buildHeaderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        value: _selectedHeader,
        onChanged: (newValue) {
          setState(() {
            _selectedHeader = newValue;
          });
        },
        decoration: InputDecoration(
          labelText: 'Filter by Header',
        ),
        items: [
          DropdownMenuItem(
            value: null,
            child: Text('All'),
          ),
          DropdownMenuItem(
            value: 'Mandatory Signs',
            child: Text('Mandatory Signs'),
          ),
          DropdownMenuItem(
            value: 'Cautionary Signs',
            child: Text('Cautionary Signs'),
          ),
          DropdownMenuItem(
            value: 'Informatory Signs',
            child: Text('Informatory Signs'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignsSectionPage(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildSignsSections(
          "Mandatory Signs",
          [
            _SignData(
              title: 'Turn Left Prohibited',
              image: 'assets/images/turn-left-prohibited.jpg',
              description:
                  'A "Turn Left Prohibited" sign, showing a left arrow with a red slash, indicates that left turns are not allowed at that location, enhancing traffic flow and safety.',
              header: 'Mandatory Signs',
            ),
            _SignData(
              title: 'No Entry',
              image: 'assets/images/no-entry-traffic.png',
              description:
                  'A "No Entry" traffic sign, usually a red circle with a white horizontal bar, indicates that vehicles are not allowed to enter the roadway beyond the sign, ensuring restricted access for safety and traffic management.',
              header: 'Mandatory Signs',
            ),
          ],
        ),
        _buildSignsSections(
          "Cautionary Signs",
          [
            _SignData(
              title: 'Left Reverse Bend',
              image: 'assets/images/left-reverse-bend.png',
              description: 'Left Reverse Bend',
              header: 'Cautionary Signs',
            ),
            _SignData(
              title: 'Narrow Bridge',
              image: 'assets/images/narrow-road-ahead.png',
              description: 'Narrow Road Ahead',
              header: 'Cautionary Signs',
            ),
          ],
        ),
        _buildSignsSections(
          "Informatory Signs",
          [
            _SignData(
              title: 'Hospital',
              image: 'assets/images/hospital.png',
              description: 'A nearby hospital',
              header: 'Informatory Signs',
            ),
            _SignData(
              title: 'Narrow Bridge',
              image: 'assets/images/fuel-station.png',
              description: 'Petrol Pump',
              header: 'Informatory Signs',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignsSections(String mainTitle, List<_SignData> signs) {
    return Column(
      children: [
        if (_selectedHeader == null || _selectedHeader == mainTitle)
          Text(
            mainTitle,
            style: AppTextStyles.title,
          ),
        if (_selectedHeader == null || _selectedHeader == mainTitle)
          SizedBox(height: 16),
        Row(
          children: signs
              .where((sign) =>
                  _selectedHeader == null || sign.header == _selectedHeader)
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
  final String header;

  _SignData(
      {required this.title,
      required this.image,
      required this.description,
      required this.header});
}
