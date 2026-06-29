import { Injectable } from '@nestjs/common';

@Injectable()
export class ExchangeRateService {
  getExchangeRate() {
    // For now, return a static exchange rate. In a real application, this would fetch from an external API.
    return { usdToSyp: 15000 }; // Example rate
  }
}
