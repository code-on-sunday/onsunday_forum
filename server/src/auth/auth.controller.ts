import { Body, Controller, Get, Post } from '@nestjs/common';
import { RegisterDto } from './dto/register.dto';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { Public } from './auth.decorator';
import { UserDto } from 'src/user/dtos/user.dto';
import { User } from 'src/user/user.decorator';
import { ApiBody, ApiTags } from '@nestjs/swagger';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @ApiBody({
    type: RegisterDto,
    examples: {
      default: {
        value: {
          username: 'onsunday',
          password: '123456',
        },
      },
    },
  })
  @Post('register')
  register(@Body() registerDto: RegisterDto) {
    return this.authService.register(
      registerDto.username,
      registerDto.password,
    );
  }

  @Public()
  @ApiBody({
    type: LoginDto,
    examples: {
      default: {
        value: {
          username: 'onsunday',
          password: '123456',
        },
      },
    },
  })
  @Post('login')
  login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto.username, loginDto.password);
  }

  @Get('profile')
  getProfile(@User() user: UserDto) {
    return user;
  }
}
