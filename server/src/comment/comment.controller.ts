import { Controller, Post, Body, Param, Delete, Get } from '@nestjs/common';
import { CommentService } from './comment.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { User } from 'src/user/user.decorator';
import { UserDto } from 'src/user/dtos/user.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('comments')
@Controller('comments')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Post()
  create(@User() user: UserDto, @Body() createCommentDto: CreateCommentDto) {
    return this.commentService.create(user.sub, createCommentDto);
  }

  @Delete(':id')
  remove(@User() user: UserDto, @Param('id') id: string) {
    return this.commentService.remove(user.sub, id);
  }

  @Get('post/:postId')
  findAllByPostId(@Param('postId') postId: string) {
    return this.commentService.findAllByPostId(postId);
  }
}
