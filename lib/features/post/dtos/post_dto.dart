import 'package:equatable/equatable.dart';

class PostDto extends Equatable {
  final String id;
  final String title;
  final String excerpt;
  final String authorName;
  final int commentCount;
  final DateTime createdAt;

  const PostDto(
      {required this.id,
      required this.title,
      required this.excerpt,
      required this.authorName,
      required this.commentCount,
      required this.createdAt});

  @override
  List<Object?> get props => [
        id,
        title,
        excerpt,
        authorName,
        commentCount,
        createdAt,
      ];

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
        id: json['id'],
        title: json['title'],
        excerpt: json['excerpt'],
        authorName: json['authorName'],
        commentCount: json['commentCount'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
