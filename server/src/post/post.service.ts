import { BadRequestException, Injectable } from '@nestjs/common';
import { CreatePostDto } from './dto/create-post.dto';
import { Repository } from 'typeorm';
import { Post } from './entities/post.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UserService } from 'src/user/user.service';
import { Comment } from 'src/comment/entities/comment.entity';

@Injectable()
export class PostService {
  constructor(
    @InjectRepository(Post) private readonly postRepository: Repository<Post>,
    private readonly userService: UserService,
  ) {}

  async create(userId: string, createPostDto: CreatePostDto) {
    const user = await this.userService.findOneById(userId);
    if (!user) {
      throw new BadRequestException('User not found');
    }
    const post = this.postRepository.create({
      ...createPostDto,
      user,
    });
    return this.postRepository.save(post);
  }

  findAll() {
    return this.postRepository
      .createQueryBuilder('post')
      .leftJoin('post.user', 'user')
      .select([])
      .addSelect('post.id', 'id')
      .addSelect('post.title', 'title')
      .addSelect(
        (qb) => qb.from(Post, 'post').select('SUBSTRING(post.body, 1, 100)'),
        'excerpt',
      )
      .addSelect('post.createdAt', 'createdAt')
      .addSelect('user.username', 'authorName')
      .addSelect(
        (qb) =>
          qb
            .from(Comment, 'comment')
            .andWhere('comment.postId = post.id')
            .select('COUNT(comment.id)'),
        'commentCount',
      )
      .execute();
  }

  async findOne(id: string) {
    return this.postRepository
      .createQueryBuilder('post')
      .where('post.id = :id', { id })
      .leftJoin('post.user', 'user')
      .select([])
      .addSelect('post.id', 'id')
      .addSelect('post.title', 'title')
      .addSelect('post.body', 'body')
      .addSelect('post.createdAt', 'createdAt')
      .addSelect('user.username', 'authorName')
      .addSelect('user.id', 'authorId')
      .getRawOne();
  }

  async findOneById(id: string) {
    return this.postRepository.findOne({
      where: {
        id,
      },
      relations: {
        user: false,
      },
    });
  }

  remove(userId: string, id: string) {
    return this.postRepository.delete({
      id,
      user: {
        id: userId,
      },
    });
  }
}
