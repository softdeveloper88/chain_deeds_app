import 'dart:io';

import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/model/cod_model/get_member_model.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_event.dart';
import 'package:chain_deeds_app/widgets/custom_phone_text_field_widget.dart';
import 'package:chain_deeds_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import 'bloc/cod_bloc.dart';
import 'bloc/code_state.dart'; // For formatting the date

class CreateEditMembersScreen extends StatefulWidget {
  CreateEditMembersScreen({super.key, this.members});

  Members? members;

  @override
  State<CreateEditMembersScreen> createState() =>
      _CreateEditMembersScreenState();
}

class _CreateEditMembersScreenState extends State<CreateEditMembersScreen> {
  TextEditingController firstNameEditingController = TextEditingController();

  TextEditingController lastNameEditingController = TextEditingController();

  TextEditingController emailEditingController = TextEditingController();

  TextEditingController dateBirthEditingController = TextEditingController();

  TextEditingController phoneEditingController = TextEditingController();

  TextEditingController relationEditingController = TextEditingController();

  String? _selectedDate;
  String dialCode = '+1';
  String countryCode = "US";
  bool notifyMember = false;
  bool memberIsDeceased = false;
  CODBloc codBloc = CODBloc();

  @override
  void initState() {
    if (widget.members != null) {
      firstNameEditingController = TextEditingController(
          text: widget.members?.name?.split(" ").first ?? '');

      lastNameEditingController = TextEditingController(
          text: widget.members?.name?.split(" ").last ?? '');

      emailEditingController =
          TextEditingController(text: widget.members?.email ?? "");

      dateBirthEditingController = TextEditingController();

      phoneEditingController =
          TextEditingController(text: widget.members?.phone ?? '');

      relationEditingController =
          TextEditingController(text: widget.members?.relation ?? '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      // Light background color
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScreenColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              NavigatorService.goBack();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        title: Row(
          children: [
            Text(widget.members != null ? 'Update Member' : 'Add Member',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            InkWell(
              onTap: () {},
              child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: AppColors.buttonSecondary,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  )),
            )
          ],
        ),
        centerTitle: false,
      ),
      body: BlocListener<CODBloc, CODState>(
          bloc: codBloc,
          listener: (context, state) {
            if (state is CODFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is CODSuccess) {
              if (state.response['status']) {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.response['message']??'')),
                );
              } else {
                if (state.response.containsKey('errors')) {
                  showErrorDialog(state.response['errors'], context);
                } else if (state.response.containsKey('message')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Member add  failed!${state.response['message']}')),
                  );
                }
              }
            }
          },
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFFD4E2F3),
                          child: Image.file(
                            File(_selectedFile?.path ?? ""),
                            // size: 50,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () async {
                                const permission = Permission.storage;
                                const permission1 = Permission.photos;
                                var status = await permission.status;
                                print(status);
                                if (await permission1.isGranted) {
                                  _showFileOptions(false);
                                  // _selectFiles(context);
                                } else if (await permission1.isDenied) {
                                  final result = await permission1.request();
                                  if (status.isGranted) {
                                    _showFileOptions(false);
                                    // _selectFiles(context);
                                    print("isGranted");
                                  } else if (result.isGranted) {
                                    _showFileOptions(false);
                                    // _selectFiles(context);
                                    print("isGranted");
                                  } else if (result.isDenied) {
                                    final result = await permission.request();
                                    print("isDenied");
                                  } else if (result.isPermanentlyDenied) {
                                    print("isPermanentlyDenied");
                                    // _permissionDialog(context);
                                  }
                                }
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFieldWidget(
                    labelText: 'First Name',
                    controller: firstNameEditingController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWidget(
                    labelText: 'Surname',
                    controller: lastNameEditingController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWidget(
                    labelText: 'Email',
                    controller: emailEditingController,
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  CustomTextFieldWidget(
                    labelText: 'Relation',
                    controller: relationEditingController,
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(context),
                  const SizedBox(height: 16),
                  CustomPhoneTextFieldWidget(
                    initialCountryCode: 'US',
                    favoriteCountries: const ["+1", "US"],
                    controller: phoneEditingController,
                    onChange: (code) {
                      dialCode = code.dialCode ?? "+1";
                      countryCode = code.code ?? "US";
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: notifyMember,
                        onChanged: (bool? newValue) {
                          setState(() {
                            notifyMember = newValue ?? false;
                          });
                        },
                      ),
                      const Text('Notify member when sent tokens'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: memberIsDeceased,
                        onChanged: (bool? newValue) {
                          setState(() {
                            memberIsDeceased = newValue ?? false;
                          });
                        },
                      ),
                      const Text('The member is deceased'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        print('data ${firstNameEditingController.text}');
                        String firstName = firstNameEditingController.text;
                        String lastName = lastNameEditingController.text;
                        String email = emailEditingController.text;
                        String phone = phoneEditingController.text;
                        String relation = relationEditingController.text;
                        String memberId = widget.members != null
                            ? widget.members?.id.toString() ?? '0'
                            : "0";
                       String imageFile=_selectedFile !=null?_selectedFile.path :'';
                        codBloc.add(CreateMemberEvent(
                            memberId,
                            firstName,
                            lastName,
                            email,
                            relation,
                            _selectedDate ?? "",
                            imageFile,
                            phone,
                            countryCode,
                            dialCode,
                            notifyMember ? '1' : '0',
                            memberIsDeceased ? '1' : '0',
                            widget.members != null ? false : true));
                      },
                      minWidth: 90.w,
                      height: 40,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.members != null ? 'Update' : 'Save',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2020), // Initial selected date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildDateField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.backgroundScreenColor),
      child: TextField(
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Date of Birth',
          labelStyle: const TextStyle(color: Colors.blueGrey),
          filled: true,
          fillColor: AppColors.backgroundScreenColor,
          border: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.calendar_today),
          hintText: _selectedDate ?? 'Select your birth date',
        ),
      ),
    );
  }

  var _selectedFile;

  void _showFileOptions(bool isProfilePic) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  File? file = await _pickFile(ImageSource.gallery);
                  if (file != null) {
                    setState(() {
                      print('ddd${file.path}');
                      _selectedFile = file;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () async {
                  Navigator.pop(context);
                  File? file = await _pickFile(ImageSource.camera);
                  if (file != null) {
                    setState(() {
                      print('ddd${file.path}');
                      _selectedFile = file;
                      // widget.profileBoc!.add(UpdateProfilePicEvent(
                      //     filePath: file.path, isProfilePicture: isProfilePic));
                    });
                  }
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.insert_drive_file),
              //   title: const Text('Select a document'),
              //   onTap: () async {
              //     Navigator.pop(context);
              //     File? file = await _pickFile(ImageSource.gallery);
              //     if (file != null) {
              //       setState(() {
              //         _selectedFile = file;
              //       });
              //     }
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<File?> _pickFile(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
