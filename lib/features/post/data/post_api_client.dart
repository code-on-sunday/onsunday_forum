import 'package:dio/dio.dart';
import 'package:onsunday_forum/features/post/dtos/create_post_dto.dart';
import 'package:onsunday_forum/features/post/dtos/post_detail_dto.dart';
import 'package:onsunday_forum/features/post/dtos/post_dto.dart';

class PostApiClient {
  final Dio dio;

  PostApiClient({required this.dio});

  Future<List<PostDto>> getPosts() async {
    final response = await dio.get('/posts');
    final data = response.data as List;
    return data.map((e) => PostDto.fromJson(e)).toList();
  }

  Future<void> createPost(CreatePostDto createPostDto) async {
    await dio.post('/posts', data: createPostDto.toJson());
  }

  Future<PostDetailDto> getPostDetail(String id) async {
    final response = await dio.get('/posts/$id');
    return PostDetailDto.fromJson(response.data);
  }
}
