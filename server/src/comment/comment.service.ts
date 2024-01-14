import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateCommentDto } from './dto/create-comment.dto';
import { Repository } from 'typeorm';
import { Comment } from './entities/comment.entity';
import { UserService } from 'src/user/user.service';
import { PostService } from 'src/post/post.service';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class CommentService {
  constructor(
    @InjectRepository(Comment)
    private readonly commentRepository: Repository<Comment>,
    private readonly userService: UserService,
    private readonly postService: PostService,
  ) {}

  async create(userId: string, createCommentDto: CreateCommentDto) {
    const user = await this.userService.findOneById(userId);
    if (!user) {
      throw new BadRequestException('User not found');
    }
    const post = await this.postService.findOneById(createCommentDto.postId);
    if (!post) {
      throw new BadRequestException('Post not found');
    }
    const comment = this.commentRepository.create({
      ...createCommentDto,
      user,
      post,
    });
    return this.commentRepository.save(comment);
  }

  remove(userId: string, id: string) {
    return this.commentRepository.delete({
      id,
      user: {
        id: userId,
      },
    });
  }

  async findAllByPostId(postId: string) {
    return this.commentRepository
      .createQueryBuilder('comment')
      .where('comment.postId = :postId', { postId })
      .leftJoin('comment.user', 'user')
      .select([])
      .addSelect('comment.id', 'id')
      .addSelect('comment.body', 'body')
      .addSelect('comment.createdAt', 'createdAt')
      .addSelect('user.username', 'authorName')
      .addSelect('user.id', 'authorId')
      .execute();
  }
}
