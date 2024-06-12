import "package:flutter/material.dart";
import "package:license/res/colors.dart";
import "package:license/res/textstyles.dart";
import "package:license/res/types.dart";
import "package:license/view_model/signs_data.dart";

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
          _buildSignsSectionPage(context),
        ],
      ),
    );
  }

  Widget _buildSignsSectionPage(BuildContext context) {
    return Column(
      children: signsData.entries.map((entry) {
        return _buildSignsSections(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildSignsSections(String mainTitle, List<SignData> signs) {
    List<SignData> filteredSigns = signs
        .where(
            (sign) => _selectedHeader == null || sign.header == _selectedHeader)
        .toList();

    return Column(
      children: [
        if (_selectedHeader == null || _selectedHeader == mainTitle)
          TextButton(
            child: Text(
              mainTitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1.4,
                letterSpacing: 0.02,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
            onPressed: () {
              setState(() {
                if (_selectedHeader == mainTitle) {
                  _selectedHeader = null;
                } else {
                  _selectedHeader = mainTitle;
                }
              });
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                AppColors.secondaryLightBlue,
              ),
            ),
          ),
        if (_selectedHeader == null || _selectedHeader == mainTitle)
          SizedBox(height: 16),
        if (filteredSigns.isNotEmpty)
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filteredSigns.map((sign) {
                  return GestureDetector(
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
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
