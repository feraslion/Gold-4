import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(private readonly jwt: JwtService) {}

  async login(email: string, password: string) {
    if (!email || !password) {
      throw new UnauthorizedException();
    }

    return {
      access_token: this.jwt.sign({
        email,
      }),
    };
  }
}
