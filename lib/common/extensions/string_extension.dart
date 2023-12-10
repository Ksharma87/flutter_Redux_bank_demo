extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String reversed() {
    if (isEmpty) {
      return '';
    }
    return String.fromCharCodes(codeUnits.reversed);
  }
}
