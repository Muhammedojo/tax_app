import 'dart:io';
import 'package:intl/intl.dart';
import 'const.dart';

class NumberFormatter {
  static NumberFormat currencySymbol({String currencyCode = 'NGN'}) {
    var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: currencyCode);
    //print("currency symbol: ${format.currencySymbol}");
    return format;
  }

  static String roundTo3DecimalPlaces(double value) => value.toStringAsFixed(3);
  static String roundTo2DecimalPlaces(double value) => value.toStringAsFixed(2);
  static String roundTo1DecimalPlaces(double value) => value.toStringAsFixed(1);
  static String formatToThousands(double value) =>
      NumberFormat(DEFAULT_NUMBER_FORMATTER, "en_US").format(value);
  static String formatStringToThousands(String value) =>
      NumberFormat(DEFAULT_NUMBER_FORMATTER, "en_US").format(num.parse(
          value.isNotEmpty
              ? value
              : "$DEFAULT_DECIMAL_VALUE"));
  static String formatStringToThousands2(String value) =>
      NumberFormat(DEFAULT_NUMBER_FORMATTER, "en_US").format(num.parse(
          value.isNotEmpty
              ? value
              : "$DEFAULT_DECIMAL_VALUE"));
  static String formatStringToThousandsWeight(String value) =>
      NumberFormat(DEFAULT_NUMBER_FORMATTER_WEIGHT, "en_US").format(
          num.parse(value.isNotEmpty
              ? value
              : "$DEFAULT_DECIMAL_VALUE_WEIGHT"));

  static String formatUnitsToThousands(String value) =>
      NumberFormat("#,##0", "en_US")
          .format(num.parse(value.isNotEmpty ? value : "0"));
  static String formatAmountToThousands(String value) =>
      NumberFormat(DEFAULT_NUMBER_FORMATTER, "en_US").format(num.parse(
          value.isNotEmpty
              ? value
              : "$DEFAULT_DECIMAL_VALUE"));

  static String formatCurrency(String value, {String currencyCode = 'NGN'}) =>
      NumberFormat.simpleCurrency(
        locale: Platform.localeName,
        name: currencyCode,
      ).format(num.parse(value.isNotEmpty
              ? value
              : "$DEFAULT_DECIMAL_VALUE"));

  static String formatPhoneNumber(String value) {
    String text = value;
    if (value.length == 11) {
      text =
          "${value.substring(0, 4)} ${value.substring(4, 7)} ${value.substring(7, 11)}";
    }

    if (value.length == 13) {
      text =
          "${value.substring(0, 3)} ${value.substring(3, 6)} ${value.substring(6, 10)} ${value.substring(10, 13)}";
    }

    if (value.length == 14) {
      text =
          "${value.substring(0, 4)} ${value.substring(4, 7)} ${value.substring(7, 11)} ${value.substring(11, 14)}";
    }
    return text;
  }

  static String convertFromKgToUnits(String value) {
    int inputValue = int.parse(value);
    int units = (inputValue / 100).floor();
    return NumberFormat("#,##0", "en_US").format(units);
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(':');
  }
}
