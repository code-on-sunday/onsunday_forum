import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostDto } from './dto/create-post.dto';
import { User } from 'src/user/user.decorator';
import { UserDto } from 'src/user/dtos/user.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('posts')
@Controller('posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @Post()
  create(@User() user: UserDto, @Body() createPostDto: CreatePostDto) {
    return this.postService.create(user.sub, createPostDto);
  }

  @Get()
  findAll() {
    return this.postService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.postService.findOne(id);
  }

  @Delete(':id')
  remove(@User() user: UserDto, @Param('id') id: string) {
    return this.postService.remove(user.sub, id);
  }
}
