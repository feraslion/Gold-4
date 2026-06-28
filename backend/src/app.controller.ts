import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get('health')
  health() {
    return { status: 'ok', service: 'Gold-4 API', timestamp: new Date().toISOString() };
  }
}
