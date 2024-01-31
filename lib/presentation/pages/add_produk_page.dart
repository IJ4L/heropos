import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/produk_cubit/produk_cubit.dart';

class AddProdukPage extends StatefulWidget {
  const AddProdukPage({Key? key}) : super(key: key);

  @override
  State<AddProdukPage> createState() => _AddProdukPageState();
}

class _AddProdukPageState extends State<AddProdukPage> {
  TextEditingController namaBarangController = TextEditingController();
  TextEditingController kodeBarangController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController hargaBeliController = TextEditingController();
  TextEditingController hargaJualController = TextEditingController();

  final GlobalKey<FormState> namaBarangFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> kodeBarangFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stokFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> hargaBeliFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> hargaJualFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    namaBarangController.dispose();
    kodeBarangController.dispose();
    stokController.dispose();
    hargaBeliController.dispose();
    hargaJualController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Tambah Produk",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
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
            SizedBox(height: 12.h),
            TextformfieldCostume(
              title: "Nama Barang",
              initialValue: "",
              controller: namaBarangController,
              keys: namaBarangFormKey,
            ),
            SizedBox(height: 8.h),
            TextformfieldCostume(
              title: "Kode Barang",
              initialValue: "",
              controller: kodeBarangController,
              keys: kodeBarangFormKey,
            ),
            SizedBox(height: 8.h),
            TextformfieldCostume(
              title: "Stok",
              initialValue: "",
              controller: stokController,
              keyboardType: TextInputType.number,
              keys: stokFormKey,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                MoneyCostumeTexfield(
                  title: 'Harga Beli',
                  controller: hargaBeliController,
                  keys: hargaBeliFormKey,
                ),
                SizedBox(width: 8.h),
                MoneyCostumeTexfield(
                  title: 'Harga Jual',
                  controller: hargaJualController,
                  keys: hargaJualFormKey,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  var name = namaBarangFormKey.currentState!.validate();
                  var code = kodeBarangFormKey.currentState!.validate();
                  var stock = stokFormKey.currentState!.validate();
                  var buy = hargaBeliFormKey.currentState!.validate();
                  var sell = hargaJualFormKey.currentState!.validate();
                  if (name && code && stock && buy && sell) {
                    Produk newProduk = Produk(
                      namaProduk: namaBarangController.text,
                      kodeProduk: kodeBarangController.text,
                      hargaBeli: double.parse(hargaBeliController.text.trim()),
                      hargaJual: double.parse(hargaJualController.text.trim()),
                      stok: int.parse(stokController.text),
                      gambarProduk: context.read<CamereCubit>().state,
                      kategoriProduk: 'Tidak Ada',
                      tanggalKadaluarsa: DateTime.now(),
                      hargaGrosir: 232,
                    );
                    context.read<ProdukCubit>().addProduk(newProduk);
                    context.pop();
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
                  "Simpan produk",
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

class MoneyCostumeTexfield extends StatelessWidget {
  const MoneyCostumeTexfield({
    Key? key,
    required this.title,
    required this.controller,
    required this.keys,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final GlobalKey<FormState> keys;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keys,
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 40.w,
              decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.r),
                  bottomLeft: Radius.circular(6.r),
                ),
                border: Border.all(
                  color: AppColor.grey.withOpacity(0.3),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22.r,
                    width: 22.r,
                    child: Center(
                      child: Text(
                        "Rp",
                        style: AppFont.semiBold.s14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: TextFormField(
                controller: controller,
                scrollPadding: EdgeInsets.symmetric(vertical: 10.h),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: title,
                  labelStyle: AppFont.normal.s12,
                  hintText: title,
                  hintStyle: AppFont.normal.s12,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.grey.withOpacity(0.6),
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan $title';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextformfieldCostume extends StatelessWidget {
  const TextformfieldCostume({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.keys,
  }) : super(key: key);

  final String title;
  final String initialValue;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final GlobalKey<FormState> keys;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keys,
      child: TextFormField(
        controller: controller,
        scrollPadding: EdgeInsets.symmetric(vertical: 10.h),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: AppFont.normal.s12,
          hintText: title,
          hintStyle: AppFont.normal.s12,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.r),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.grey.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.r),
            ),
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
