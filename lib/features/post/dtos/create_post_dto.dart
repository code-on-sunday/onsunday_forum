import 'package:equatable/equatable.dart';

class CreatePostDto extends Equatable {
  final String title;
  final String body;

  const CreatePostDto({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
