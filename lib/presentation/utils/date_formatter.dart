String formatDate(DateTime date) {
  return "${_getMonthName(date.month)} ${date.day}, ${date.year}";
}

String _getMonthName(int month) {
  const monthNames = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  return monthNames[month - 1];
}
