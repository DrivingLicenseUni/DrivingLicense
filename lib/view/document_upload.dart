import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyles.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class DocumentUpload extends StatefulWidget {
  const DocumentUpload({super.key});

  @override
  _DocumentUploadState createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  File? selectedFile;

  Future<void> pickFile() async {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      // Permission granted, proceed with file picking
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
        });
      } else {
        // User canceled the file picker
      }
    } else if (permissionStatus.isDenied) {
      // Permission denied by user, handle accordingly
      print('Permission denied by user');
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied, open app settings to allow permission manually
      print('Permission permanently denied');
      await handler.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          HeaderText(),
          FileSelectionContainer(
            onTap: pickFile,
            selectedFile: selectedFile,
          ),
          OrDivider(),
          CameraButton(),
          ContinueButton(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Registration',
        style: AppTextStyles.headline,
      ),
      centerTitle: true,
      toolbarHeight: preferredSize.height,
    );
  }
}

class HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 12.5),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 335,
          child: const Text(
            'Regulations require you to upload documents that are required for school enrollment. Don\'t worry, your data will remain secure and private.',
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
        ),
      ),
    );
  }
}

class FileSelectionContainer extends StatelessWidget {
  final VoidCallback onTap;
  final File? selectedFile;

  const FileSelectionContainer({
    Key? key,
    required this.onTap,
    this.selectedFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12.5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 304,
          height: 159,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(32),
            color: const Color(0xFFFAFAFA),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 23.3,
                height: 23.3,
                child: Icon(
                  selectedFile != null ? Icons.check : Icons.insert_drive_file,
                  color: AppColors.primary,
                ),
              ),
              Text(
                selectedFile != null
                    ? selectedFile!.path.split('/').last
                    : 'Select file',
                style: AppTextStyles.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: const Divider(
              color: Color(0xFFEEEEEE),
              height: 36,
            ),
          ),
        ),
        Text(
          "or",
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF616161),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: const Divider(
              color: Color(0xFFEEEEEE),
              height: 36,
            ),
          ),
        ),
      ],
    );
  }
}

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12.5),
      child: SizedBox(
        width: 340,
        height: 56,
        child: FilledButton.tonal(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.secondaryLight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Open Camera & Take Photo',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.5),
      child: SizedBox(
        width: 105,
        height: 40,
        child: FilledButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTextStyles.labelLarge,
                selectionColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
