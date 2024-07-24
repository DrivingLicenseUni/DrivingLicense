import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyle.dart';

import '../view_model/progress_log.dart';

class InstructorLogProgress extends StatefulWidget {
  final Map<String, String> user;

  const InstructorLogProgress({Key? key, required this.user}) : super(key: key);

  @override
  _InstructorLogProgress createState() => _InstructorLogProgress();
}

class _InstructorLogProgress extends State<InstructorLogProgress> {
  late ProgressLogViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProgressLogViewModel(userId: widget.user['id']!);
    _viewModel.loadProgress().then((_) {
      setState(() {}); // Trigger a rebuild once progress is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress',
          style: AppTextStyles.headline,
        ),
        centerTitle: true,
        toolbarHeight: 83,
      ),
      body: Container(
        color: AppColors.secondaryLightBlue,
        child: ListView.builder(
          itemCount: _viewModel.checkboxData.length,
          itemBuilder: (context, index) {
            bool showDivider = index == 0 ||
                _viewModel.checkboxData[index]['category'] != _viewModel.checkboxData[index - 1]['category'];

            bool showEndDivider = index == _viewModel.checkboxData.length - 1 ||
                (index < _viewModel.checkboxData.length - 1 &&
                    _viewModel.checkboxData[index]['category'] != _viewModel.checkboxData[index + 1]['category']);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDivider)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 33),
                    child: Text(
                      _viewModel.checkboxData[index]['category'],
                      style: AppTextStyles.labelMenuBold,
                    ),
                  ),
                Container(
                  width: 430,
                  height: 60,
                  child: CheckboxListTile(
                    value: _viewModel.checkboxData[index]['value'],
                    onChanged: (bool? value) {
                      setState(() {
                        _viewModel.updateCheckboxValue(index, value!);
                      });
                    },
                    activeColor: AppColors.primary,
                    checkColor: Colors.white,
                    title: Text(
                      _viewModel.checkboxData[index]['title'],
                      style: AppTextStyles.labelMenuMenu,
                    ),
                    secondary: CircleAvatar(
                      child: Text(
                        _viewModel.checkboxData[index]['title'][0],
                      ),
                    ),
                  ),
                ),
                if (showEndDivider) const Divider(height: 0),
              ],
            );
          },
        ),
      ),
    );
  }
}
