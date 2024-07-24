import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/res/types.dart';
import 'package:license/view_model/home_vm.dart';

class PasswordConfirmationPage extends StatefulWidget {
  const PasswordConfirmationPage({super.key});

  @override
  State<PasswordConfirmationPage> createState() =>
      _PasswordConfirmationPageState();
}

class _PasswordConfirmationPageState extends State<PasswordConfirmationPage> {
  HomeViewModel _homeViewModel = HomeViewModel();
  late FocusNode _passwordFocusNode;
  late TextEditingController _passwordController;
  ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      _canSubmit.value = _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    _canSubmit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: AppTextStyles.headline),
        actions: const [
          SizedBox(width: 17.0),
        ],
        centerTitle: true,
        toolbarHeight: 83,
      ),
      body: FutureBuilder<Student?>(
        future: _homeViewModel.fetchCurrentStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final student = snapshot.data!;

            return Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 59,
                          backgroundImage: AssetImage(student.profileImageUrl),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          student.fullName,
                          style: AppTextStyles.title,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: GestureDetector(
                    child: _textField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      labelText: "Password",
                      hintText: "Password",
                      errorText: null,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    )!,
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _canSubmit,
                  builder: (context, canSubmit, child) {
                    return canSubmit
                        ? ElevatedButton(
                            onPressed: () {
                              _homeViewModel
                                  .comparePassword(_passwordController.text)
                                  .then((value) {
                                if (value) {
                                  Navigator.of(context).pop(true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Password is incorrect'),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox();
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget? _textField({
    required FocusNode focusNode,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String? errorText,
    required bool obscureText,
    required TextInputType keyboardType,
    required void Function(String) onChanged,
    required void Function(String)? onSubmitted,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: errorText == null ? AppColors.placeholder : null,
          fontWeight: FontWeight.w500,
        ),
        focusColor: AppColors.primary,
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorText: errorText,
      ),
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
