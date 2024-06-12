import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyles.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentUpload extends StatefulWidget {
  const DocumentUpload({super.key});

  @override
  DocumentUploadState createState() => DocumentUploadState();
}

class DocumentUploadState extends State<DocumentUpload> {
  File? selectedFile;

  Future<void> pickFile() async {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      // Permission granted, proceed with file picking
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          selectedFile = File(pickedFile.path);
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
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile != null) {
      try {
        // Upload the file to Firebase Storage
        String fileName =
            'uploads/${DateTime.now().millisecondsSinceEpoch}_${selectedFile!.path.split('/').last}';
        Reference storageReference =
            FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = storageReference.putFile(selectedFile!);
        TaskSnapshot snapshot = await uploadTask;

        // Get the file URL
        String fileURL = await snapshot.ref.getDownloadURL();

        // Save the file URL in Firestore
        await FirebaseFirestore.instance
            .collection('uploads')
            .add({'url': fileURL});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading file: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
      );
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
          CameraButton(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
              );

              if (image != null) {
                setState(() {
                  selectedFile = File(image.path);
                });
              } else {
                // User canceled the image capture
                print('No image captured.');
              }
            },
          ),
          ContinueButton(
            onPressed: () {
              uploadFile();
            },
          ),
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
    super.key,
    required this.onTap,
    this.selectedFile,
  });

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
          child: selectedFile != null
              ? Center(
                  child: selectedFile!.path.endsWith('.jpg') ||
                          selectedFile!.path.endsWith('.png')
                      ? Image.file(
                          selectedFile!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        )
                      : Icon(
                          getFileTypeIcon(selectedFile!.path),
                          size: 48,
                          color: AppColors.primary,
                        ),
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 23.3,
                      height: 23.3,
                      child: Icon(
                        Icons.insert_drive_file,
                        color: Color.fromRGBO(46, 96, 247, 1),
                      ),
                    ),
                    Text(
                      'Select file',
                      style: AppTextStyles.labelLarge,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  IconData getFileTypeIcon(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.insert_drive_file;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.desktop_windows;
      default:
        return Icons.insert_drive_file;
    }
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
  final VoidCallback onTap;

  const CameraButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12.5),
      child: SizedBox(
        width: 340,
        height: 56,
        child: FilledButton.tonal(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.secondaryLightBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 16,
                color: Color.fromRGBO(46, 96, 247, 1),
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
  final VoidCallback onPressed;

  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.5),
      child: SizedBox(
        width: 105,
        height: 40,
        child: FilledButton(
          onPressed: onPressed,
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
