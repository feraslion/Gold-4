import '../constants/app_constants.dart';

class CurrencyConverter {
  CurrencyConverter._();
  static double toUSD(double syp) => syp / AppConstants.exchangeRate;
  static double toSYP(double usd) => usd * AppConstants.exchangeRate;
  static String formatSYP(double amount) {
    final n = amount;
    final s = n >= 1000000 ? '${(n/1000000).toStringAsFixed(2)}م'
            : n >= 1000    ? '${(n/1000).toStringAsFixed(1)}ك'
            : n.toStringAsFixed(0);
    return '$s ${AppConstants.sypSymbol}';
  }
  static String formatUSD(double amount) => '${AppConstants.usdSymbol}${amount.toStringAsFixed(2)}';
  static String format(double amount, String currency) =>
      currency == AppConstants.usdCode ? formatUSD(amount) : formatSYP(amount);
}
