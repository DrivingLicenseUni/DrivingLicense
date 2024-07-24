import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/res/types.dart';
import 'package:license/view_model/home_vm.dart';
import "package:license/view/verify_password.dart";
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HomeViewModel _homeViewModel = HomeViewModel();
  late FocusNode _phoneNumberFocusNode;
  late TextEditingController _phoneNumberController;
  late ValueNotifier<String> _labelNotifier;
  late ValueNotifier<bool> _canSubmit;
  String? _phoneNumberError = null;
  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    _labelNotifier = ValueNotifier<String>('');
    _canSubmit = ValueNotifier<bool>(false);

    _phoneNumberController.addListener(() {
      _canSubmit.value = _phoneNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _phoneNumberController.dispose();
    _labelNotifier.dispose();
    _canSubmit.dispose();
    super.dispose();
  }

  Future<void> _verifyPassword() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PasswordConfirmationPage()),
    );

    if (result == true) {
      setState(() {
        _isEditable = true;
        _phoneNumberFocusNode.requestFocus();
      });
    }
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
            _labelNotifier.value = student.phoneNumber;

            return Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 59,
                          backgroundImage:
                              NetworkImage(student.profileImageUrl),
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
                  height: 5,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Instructor's Name: ${student.instructorName}",
                          style: AppTextStyles.title,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ValueListenableBuilder<String>(
                    valueListenable: _labelNotifier,
                    builder: (context, labelText, child) {
                      return GestureDetector(
                        onTap: _isEditable
                            ? () {
                                _phoneNumberFocusNode.requestFocus();
                              }
                            : _verifyPassword,
                        child: AbsorbPointer(
                          absorbing: !_isEditable,
                          child: _textField(
                            focusNode: _phoneNumberFocusNode,
                            controller: _phoneNumberController,
                            labelText: labelText,
                            hintText: student.phoneNumber,
                            errorText: _phoneNumberError,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            onSubmitted: (value) {},
                          )!,
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _canSubmit,
                    builder: (context, canSubmit, child) {
                      return ElevatedButton(
                        onPressed: canSubmit
                            ? () async {
                                RegExp regExp = RegExp(
                                    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

                                if (!regExp
                                    .hasMatch(_phoneNumberController.text)) {
                                  setState(() {
                                    _phoneNumberError =
                                        "Please enter a valid phone number";
                                  });
                                  return;
                                }

                                if (_phoneNumberError != null) {
                                  setState(() {
                                    _phoneNumberError = null;
                                  });
                                }

                                await _homeViewModel.updatePhoneNumber(
                                    student.id, _phoneNumberController.text);
                                _phoneNumberFocusNode.unfocus();
                                _labelNotifier.value =
                                    _phoneNumberController.text;

                                setState(() {
                                  _isEditable = false;
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ElevatedButton(
          onPressed: () => HomeScreen().signOut(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.warning,
          ),
          child: const Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }

  Widget? _textField({
    required FocusNode focusNode,
    required TextEditingController? controller,
    required String labelText,
    required String hintText,
    required String? errorText,
    required bool obscureText,
    required TextInputType keyboardType,
    required void Function(String) onChanged,
    required void Function(String)? onSubmitted,
  }) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _labelNotifier.value = "Phone Number";
      } else {
        _labelNotifier.value = hintText;
      }
    });

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
      onSubmitted: (_) => onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
