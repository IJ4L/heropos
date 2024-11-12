import 'dart:developer';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class PrinterDataSource {
  Future<bool> printStruk({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  });
  Future<List<int>> ticket(TroliState produk, Profile profile, int cash);
  Future<List<BluetoothInfo>> pairedBluetooths();
  Future<PermissionStatus> bluetoothCheck();
}

class PrinterDataSourceImpl implements PrinterDataSource {
  @override
  Future<bool> printStruk({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  }) async {
    try {
      await PrintBluetoothThermal.connect(
        macPrinterAddress: address,
      );

      final bool connectionStatus =
          await PrintBluetoothThermal.connectionStatus;

      if (connectionStatus) {
        await PrintBluetoothThermal.writeBytes(
            await ticket(produk, profile, cash));
        return true;
      } else {
        log("Failed to connect $connectionStatus");
      }
      return false;
    } catch (e) {
      log("Error during printing: $e");
      return false;
    }
  }

  @override
  Future<List<int>> ticket(
    TroliState produk,
    Profile profiles,
    int cash,
  ) async {
    List<int> bytes = [];
    var change = cash - produk.totalPrice;

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.reset();

    bytes += generator.text(
      profiles.name,
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );

    bytes += generator.text(
      profiles.alamat,
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.text(
      profiles.phone,
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.text(
      '--------------------------------',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.text(
      DateTime.now().toIso8601String(),
      styles: const PosStyles(align: PosAlign.right),
    );

    bytes += generator.row([
      PosColumn(
        text: 'Transaksi',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'No. Transaksi',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.text(
      '--------------------------------',
      styles: const PosStyles(align: PosAlign.center),
    );

    for (var i = 0; i < produk.products.length; i++) {
      var totalPriceProduk = produk.products[i].quantity *
          int.parse(produk.products[i].priceOfProduct);

      bytes += generator.text(
        produk.products[i].nameOfProduct,
        styles: const PosStyles(align: PosAlign.left),
      );

      bytes += generator.row([
        PosColumn(
          text:
              '${produk.products[i].quantity} X ${produk.products[i].priceOfProduct.toString().formatCurrency()}',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: totalPriceProduk.toString().formatCurrency(),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.text(
      '--------------------------------',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: produk.totalPrice.toInt().toString().formatCurrency(),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Bayar',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: cash.toInt().toString().formatCurrency(),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Kembalian',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: change.toInt().toString().formatCurrency(),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.feed(2);

    bytes += generator.text(
      '--- Terima Kasih ---',
      styles: const PosStyles(
        fontType: PosFontType.fontA,
        align: PosAlign.center,
      ),
    );

    bytes += generator.feed(2);
    bytes += generator.feed(2);
    return bytes;
  }

  @override
  Future<List<BluetoothInfo>> pairedBluetooths() async {
    var permGranted = false;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect
    ].request();
    if (statuses[Permission.bluetoothScan]!.isGranted &&
        statuses[Permission.bluetoothAdvertise]!.isGranted &&
        statuses[Permission.bluetoothConnect]!.isGranted) {
      permGranted = true;
    }

    if (permGranted) {
      final List<BluetoothInfo> listResult =
          await PrintBluetoothThermal.pairedBluetooths;
      return listResult;
    } else {
      return [];
    }
  }

  @override
  Future<PermissionStatus> bluetoothCheck() async {
    var status = await Permission.bluetooth.request();

    if (status.isGranted) {
      bool isBluetoothOn = await FlutterBluePlus.isOn;

      if (isBluetoothOn) {
        return PermissionStatus.granted;
      } else {
        return PermissionStatus.denied;
      }
    } else {
      return PermissionStatus.denied;
    }
  }
}
