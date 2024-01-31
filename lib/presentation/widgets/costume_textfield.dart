import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:svg_flutter/svg.dart';

class CostumeTextfield extends StatefulWidget {
  const CostumeTextfield({
    super.key,
    required this.label,
    required this.icons,
    required this.textController,
    required this.textInputAction,
    required this.formKey,
    required this.title,
  });

  final String label, title;
  final String icons;
  final TextEditingController textController;
  final TextInputAction textInputAction;
  final GlobalKey formKey;

  @override
  State<CostumeTextfield> createState() => _CostumeTextfieldState();
}

class _CostumeTextfieldState extends State<CostumeTextfield> {
  bool clearIcon = false;

  void clearState(bool state) {
    setState(() {
      clearIcon = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          width: 40.w,
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            border: Border.all(color: AppColor.grey.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 22,
                width: 22,
                child: SvgPicture.asset(
                  widget.icons,
                  // ignore: deprecated_member_use
                  color: AppColor.grey,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Form(
            key: widget.formKey,
            child: TextFormField(
              controller: widget.textController,
              cursorColor: AppColor.green,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: widget.label,
                labelStyle: AppFont.regular.s12.copyWith(
                  color: AppColor.grey,
                ),
                floatingLabelStyle: AppFont.regular.s12.copyWith(
                  color: AppColor.green,
                ),
                suffixIcon: clearIcon ? clearIconButton() : null,
                enabledBorder: costumeBorder(AppColor.grey.withOpacity(0.3)),
                focusedBorder: costumeBorder(AppColor.green),
                errorBorder: costumeBorder(AppColor.red),
                focusedErrorBorder: costumeBorder(AppColor.green),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "${widget.title} Tidak Boleh Kosong";
                }
                return null;
              },
              onSaved: (_) => clearState(false),
              onEditingComplete: () => {
                clearState(false),
                FocusManager.instance.primaryFocus?.unfocus(),
              },
              onTapOutside: (_) => {
                clearState(false),
                FocusManager.instance.primaryFocus?.unfocus(),
              },
              onChanged: (value) {
                if (value.isEmpty || value == "") {
                  clearState(false);
                  // context.read<TextformfieldCubit>().enable(true);
                } else {
                  clearState(true);
                  // context.read<TextformfieldCubit>().enable(false);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder costumeBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: color,
        width: 1.2,
      ),
    );
  }

  IconButton clearIconButton() {
    return IconButton(
      padding: EdgeInsets.all(10.r),
      icon: Container(
        height: 22.r,
        width: 22.r,
        decoration: BoxDecoration(
          color: AppColor.black.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(11.r)),
        ),
        child: Center(
          child: Icon(
            Icons.clear,
            size: 12.r,
            color: AppColor.white,
          ),
        ),
      ),
      onPressed: () {
        // context.read<TextformfieldCubit>().enable(true);
        widget.textController.clear();
        clearState(false);
      },
    );
  }
}
