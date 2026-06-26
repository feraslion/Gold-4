class CurrencyConfig {
  static const String syp = 'SYP';
  static const String usd = 'USD';

  static double exchangeRate = 15000.0; // Default exchange rate SYP/USD

  static double convertToUSD(double sypAmount) {
    return sypAmount / exchangeRate;
  }

  static double convertToSYP(double usdAmount) {
    return usdAmount * exchangeRate;
  }
}
