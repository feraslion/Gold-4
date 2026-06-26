import '../constants/app_constants.dart';

class CurrencyConverter {
  static double toUSD(double sypAmount) {
    return sypAmount / AppConstants.currentExchangeRate;
  }

  static double toSYP(double usdAmount) {
    return usdAmount * AppConstants.currentExchangeRate;
  }
  
  static String formatSYP(double amount) {
    return "${amount.toStringAsFixed(0)} ل.س";
  }
  
  static String formatUSD(double amount) {
    return "\$${amount.toStringAsFixed(2)}";
  }
}
