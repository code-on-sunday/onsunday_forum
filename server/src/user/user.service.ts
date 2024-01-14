import { Injectable } from '@nestjs/common';
import { User } from './entities/user.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) private readonly userRepository: Repository<User>,
  ) {}

  create(username: string, password: string) {
    return this.userRepository.save({
      username,
      password,
    });
  }

  findOne(username: string) {
    return this.userRepository.findOne({
      where: {
        username,
      },
    });
  }

  findOneById(id: string) {
    return this.userRepository.findOne({
      where: {
        id,
      },
    });
  }
}
