import 'package:equatable/equatable.dart';

class PostDetailDto extends Equatable {
  final String id;
  final String title;
  final String body;
  final String authorName;
  final String authorId;
  final DateTime createdAt;

  const PostDetailDto(
      {required this.id,
      required this.title,
      required this.body,
      required this.authorName,
      required this.authorId,
      required this.createdAt});

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        authorName,
        authorId,
        createdAt,
      ];

  factory PostDetailDto.fromJson(Map<String, dynamic> json) {
    return PostDetailDto(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        authorName: json['authorName'],
        authorId: json['authorId'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
