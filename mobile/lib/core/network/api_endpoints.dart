class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000/api/v1'; // Should be from .env

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String health = '/health';
  
  static const String customers = '/customers';
  static const String suppliers = '/suppliers';
  static const String products = '/products';
  static const String invoices = '/invoices';
  static const String reports = '/reports';
  static const String exchangeRate = '/exchange-rate';
}
