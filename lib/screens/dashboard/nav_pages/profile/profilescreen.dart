import 'dart:io';
import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:ecommapp/domain/thememanage.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/getorder.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_state.dart';
import 'package:ecommapp/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String? username;

  ProfilePage({this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imgFile;
  XFile? imgPicked;
  bool isCamera = false;
  bool showSettings = false; // This variable tracks the toggle state
  bool isDarkMode = false; // Track the dark mode toggle state

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(GetUserProfileEvent());
  }

  Future<void> pickImage(bool isCamera) async {
    imgPicked = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (imgPicked != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imgPicked!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: "Cropper",
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          imgFile = File(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xEFF5F5F5),
        body: SingleChildScrollView(
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (_, state) {
              if (state is UserProfileLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserProfileErrorState) {
                return Center(
                  child: Text(
                    state.errorMsg,
                  ),
                );
              }
              if (state is UserProfileLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: CustumCircleActar(
                          //     icon: Icons.arrow_back,
                          //     backgroundColor: Colors.white,
                          //     size: 60.0,
                          //   ),
                          // ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xD9E7E4E4),
                                    shape: BoxShape.circle,
                                    image: imgFile != null
                                        ? DecorationImage(
                                            image: FileImage(imgFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) => ShowImagePickerModal(
                                          onPick: (isCamera) =>
                                              pickImage(isCamera),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 13,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning,",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 4),
                              Text(
                                state.data.data!.name!.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(width: 2, color: Colors.grey)),
                          //margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(horizontal: 19),
                          child: InkWell(
                            child: ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text("My orders"),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MyOrderPage()));
                            },
                          ),
                        ),
                      ),
                      _buildProfileInfo(
                        icon: Icons.mail,
                        title: state.data.data!.email!,
                      ),
                      _buildProfileInfo(
                        icon: Icons.phone,
                        title: state.data.data!.mobile_number!,
                      ),
                      _buildProfileInfo(
                        icon: Icons.password,
                        title: state.data.data!.password!,
                      ),
                      SizedBox(
                          height:
                              20), // Add spacing between profile info and settings
                      // Logout and Dark Mode rows
                      _buildSettingsRow(
                        title: "Dark Mode",
                        icon: Icons.dark_mode,
                        trailingWidget: Switch(
                          value: isDarkMode,
                          onChanged: (bool value) {
                            setState(() {
                              isDarkMode =
                                  value; // Update the local dark mode state
                            });
                            // Apply the theme change
                            final themeManager = Provider.of<Theme_manager>(
                                context,
                                listen: false);
                            themeManager
                                .changeTheme(isDarkMode); // Toggle theme
                          },
                        ),
                        onTap:
                            () {}, // Empty onTap since you're using onChanged for theme change
                      ),

                      _buildSettingsRow(
                        title: "Logout",
                        icon: Icons.logout,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          // Perform the logout logic
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(width: 2, color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(horizontal: 19),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }

  Widget _buildSettingsRow(
      {required String title,
      required IconData icon,
      Widget? trailingWidget,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailingWidget,
      onTap: onTap,
    );
  }
}

class ShowImagePickerModal extends StatelessWidget {
  final Function(bool) onPick;

  const ShowImagePickerModal({required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              onPick(true); // Camera
              Navigator.pop(context);
            },
            child: Text("Open Camera"),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              onPick(false); // Gallery
              Navigator.pop(context);
            },
            child: Text("Open Gallery"),
          ),
        ],
      ),
    );
  }
}
