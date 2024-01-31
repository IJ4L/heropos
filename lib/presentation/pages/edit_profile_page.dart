import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  final GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    addressController = TextEditingController(text: widget.profile.alamat);
    phoneController = TextEditingController(text: widget.profile.phone);
    emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit Profile Toko",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.h),
            Stack(
              children: [
                Container(
                  height: 120.h,
                  width: 120.h,
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    border: Border.all(color: AppColor.green, width: 1),
                    borderRadius: BorderRadius.circular(60.h),
                  ),
                  child: BlocBuilder<CamereCubit, String>(
                    builder: (context, state) {
                      if (state.isNotEmpty) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(60.h),
                          child: Image.file(
                            File(state),
                            fit: BoxFit.fill,
                          ),
                        );
                      }

                      if (state.isEmpty && widget.profile.img.length > 26) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(60.h),
                          child: Image.file(
                            File(widget.profile.img),
                            fit: BoxFit.fill,
                          ),
                        );
                      }

                      if (state.isEmpty && widget.profile.img.length == 26) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(60.h),
                          child: Image.asset(
                            widget.profile.img,
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.fill,
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      context.read<CamereCubit>().getImage();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColor.green,
                      shape: const CircleBorder(),
                    ),
                    icon: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColor.white,
                        size: 15.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            TextFormFieldCustom(
              title: 'Nama Toko',
              initialValue: widget.profile.name,
              controller: nameController,
              keys: nameFormKey,
            ),
            SizedBox(height: 10.h),
            TextFormFieldCustom(
              title: 'Alamat',
              initialValue: widget.profile.alamat,
              controller: addressController,
              keys: addressFormKey,
            ),
            SizedBox(height: 10.h),
            TextFormFieldCustom(
              title: 'Alamat Email',
              initialValue: widget.profile.email,
              controller: emailController,
              keys: emailFormKey,
            ),
            SizedBox(height: 10.h),
            TextFormFieldCustom(
              title: 'Nomer Telpon',
              initialValue: widget.profile.phone,
              controller: phoneController,
              keys: phoneFormKey,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () async {
                  var name = nameFormKey.currentState!.validate();
                  var address = addressFormKey.currentState!.validate();
                  var email = emailFormKey.currentState!.validate();
                  var phone = phoneFormKey.currentState!.validate();
                  if (name && address && email && phone) {
                    Profile profileData = Profile(
                      id: widget.profile.id,
                      name: nameController.text,
                      alamat: addressController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      img: context.read<CamereCubit>().state == ""
                          ? widget.profile.img
                          : context.read<CamereCubit>().state,
                    );
                    context.read<ProfileCubit>().updateProfileData(profileData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColor.green,
                        content: Text(
                          "Berhasil menyimpan perubahan",
                          style: AppFont.popSemiBold.s14,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.h),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Simpan perubahan",
                  style: AppFont.semiBold.s14.copyWith(
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.controller,
    required this.keys,
  }) : super(key: key);

  final String title;
  final String initialValue;
  final TextEditingController controller;
  final GlobalKey<FormState> keys;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keys,
      child: TextFormField(
        controller: controller,
        scrollPadding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: AppFont.normal.s12,
          hintText: title,
          hintStyle: AppFont.normal.s12,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.grey.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Masukkan $title';
          }
          return null;
        },
      ),
    );
  }
}
