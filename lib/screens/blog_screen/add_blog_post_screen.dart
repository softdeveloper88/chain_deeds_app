import 'dart:io';

import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/model/blog_model/blog_category_model.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/add_comaign_idea_screen.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/success_thank_you_screen.dart';
import 'package:chain_deeds_app/screens/blog_screen/bloc/blog_event.dart';
import 'package:chain_deeds_app/widgets/profile_dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import 'bloc/blog_bloc.dart';
import 'bloc/blog_state.dart';

class AddBlogPostScreen extends StatefulWidget {
  @override
  State<AddBlogPostScreen> createState() => _AddBlogPostScreenState();
}

class _AddBlogPostScreenState extends State<AddBlogPostScreen> {
  BlogBloc blogBloc = BlogBloc();
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

  Data? category;
  TextEditingController _titleEditingController=TextEditingController();
  TextEditingController _subTitleEditingController=TextEditingController();
  TextEditingController _descriptionEditingController=TextEditingController();
  @override
  void initState() {
    blogBloc.add(BlogCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        // Ensure title starts at the very left
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 14, color: Colors.black),
              onPressed: () {
                NavigatorService.goBack();
                // Handle back button press
              },
              padding: EdgeInsets.zero, // Remove padding from the icon button
              constraints:
                  const BoxConstraints(), // Remove any constraints to make sure it sticks to the edge
            ),
            const Expanded(
              child: Text(
                'Blogs Wall',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Post a blog",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCampaignIdeaScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Campaign idea's",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/vectors/bg_image.svg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
              // color: const Color(0xFFEAF3FF),
              padding: const EdgeInsets.all(16.0),
              child: BlocListener<BlogBloc, BlogState>(
                bloc: blogBloc,
                listener: (context, state) {
                  if (state is BlogFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  } else if (state is BlogSuccess) {
                    if (state.response.isNotEmpty) {
                      if (state.response['status']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(state.response['message'] ?? '')),
                        );
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SuccessThankYouScreen()));
                      } else {
                        if (state.response.containsKey('errors')) {
                          showErrorDialog(state.response['errors'], context);
                        } else if (state.response.containsKey('message')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Blog add  failed!${state.response['message']}')),
                          );
                        }
                      }
                    }
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Post A Blog',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<BlogBloc, BlogState>(
                          bloc: blogBloc,
                          builder: (BuildContext context, BlogState state) {
                            if (state is BlogLoading) {
                              return Container();
                            }
                            return ProfileDropdownField(
                              color: Colors.white,
                              getItemLabel: (item) => item!.categoryName!,
                              onChanged: (categoryData) {

                                category = categoryData;
                              },
                              label: 'Blog Category',
                              items: blogBloc.blogCategoryModel?.data ?? [],
                              selectedItem: category,
                            );
                          }),
                      // buildTextField('Category'),
                      const SizedBox(height: 16),
                      buildTextField('Title*',_titleEditingController),
                      const SizedBox(height: 16),
                      buildTextField('Subtitle*',_subTitleEditingController),
                      const SizedBox(height: 16),
                      buildImageAttachmentField(),
                      const SizedBox(height: 16),
                      buildDescriptionField(_descriptionEditingController),
                      const SizedBox(height: 32),
                      buildPostButton(context),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText,TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  Widget buildImageAttachmentField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _selectedFile == null
          ? InkWell(
              onTap: () async {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  const Text(
                    textAlign: TextAlign.center,
                    'Attach Image*',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.file(
                      _selectedFile,
                      height: 100,
                      width: 70.w,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {});
                          _selectedFile = null;
                        },
                        icon: Icon(Icons.remove_circle, color: Colors.red[600]))
                  ],
                ),
              ],
            ),
    );
  }

  Widget buildDescriptionField(TextEditingController controller) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          hintText: 'Description',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  Widget buildPostButton(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String imageFile=_selectedFile !=null?_selectedFile.path :'';
          if(_titleEditingController.text.isEmpty || _subTitleEditingController.text.isEmpty ||_descriptionEditingController.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Please fill all required field')),
            );
            return;
          }else if(_selectedFile == null){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Please add picture')),
            );
            return;
          }
          String title=_titleEditingController.text;
          String subTitle=_subTitleEditingController.text;
          String description=_descriptionEditingController.text;
          print(title);
          print(subTitle);
          print(description);
         blogBloc.add(AddBlogEvent(category?.id.toString()??'0', imageFile, title, subTitle, description));

        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
