import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';

class SignDetails extends StatefulWidget {
  final String _title;
  final String _image;
  final String _description;
  const SignDetails({
    super.key,
    required String title,
    required String image,
    required String description,
  })  : _title = title,
        _image = image,
        _description = description;

  @override
  _SignDetailsState createState() => _SignDetailsState();
}

class _SignDetailsState extends State<SignDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Details"),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              widget._title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Image.asset(
              widget._image,
              width: 300,
              height: 300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Text(
              widget._description,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
