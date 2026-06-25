import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String time;
  final String content;
  final List<String> mediaUrls;
  final int likes;
  final int comments;
  final bool isLiked;
  final String? icon;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.time,
    required this.content,
    this.mediaUrls = const [],
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.icon,
  });

  PostEntity copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? time,
    String? content,
    List<String>? mediaUrls,
    int? likes,
    int? comments,
    bool? isLiked,
    String? icon,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      time: time ?? this.time,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userAvatar,
        time,
        content,
        mediaUrls,
        likes,
        comments,
        isLiked,
        icon,
      ];
}

class CommentEntity extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime timestamp;

  const CommentEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props =>
      [id, userId, userName, userAvatar, content, timestamp];
}

class StoryEntity extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String? imageUrl;
  final bool isViewed;

  const StoryEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    this.imageUrl,
    this.isViewed = false,
  });

  @override
  List<Object?> get props =>
      [id, userId, userName, userAvatar, imageUrl, isViewed];
}

class ActivityFeedItem extends Equatable {
  final String id;
  final String type;
  final String userId;
  final String userName;
  final String description;
  final DateTime timestamp;

  const ActivityFeedItem({
    required this.id,
    required this.type,
    required this.userId,
    required this.userName,
    required this.description,
    required this.timestamp,
  });

  @override
  List<Object?> get props =>
      [id, type, userId, userName, description, timestamp];
}
