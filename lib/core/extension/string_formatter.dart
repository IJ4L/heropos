extension CurrencyFormatting on String {
  String formatCurrency() {
    final amount = int.tryParse(this);
    if (amount != null) {
      final formattedAmount = amount.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match[1]},',
          );
      return formattedAmount;
    } else {
      return 'Invalid amount';
    }
  }
}

extension DateTimeRangeFormatter on String {
  String toDateOnlyRange() {
    final parts = split(" - ");

    final tanggalMulai = parts[0].split(" ")[0];

    return tanggalMulai;
  }
}
