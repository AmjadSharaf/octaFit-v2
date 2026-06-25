import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/community/domain/entities/post_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts({
    int page = 1,
    int perPage = 20,
  });

  Future<Either<Failure, PostEntity>> createPost({
    required String content,
    List<String>? mediaUrls,
  });

  Future<Either<Failure, PostEntity>> likePost(String postId);

  Future<Either<Failure, PostEntity>> unlikePost(String postId);

  Future<Either<Failure, List<CommentEntity>>> getComments(String postId);

  Future<Either<Failure, CommentEntity>> addComment({
    required String postId,
    required String content,
  });

  Future<Either<Failure, void>> deletePost(String postId);

  Future<Either<Failure, List<StoryEntity>>> getStories();

  Future<Either<Failure, void>> uploadStory({
    required String imagePath,
  });

  Future<Either<Failure, List<ActivityFeedItem>>> getActivityFeed();

  Future<Either<Failure, void>> followUser(String userId);

  Future<Either<Failure, void>> unfollowUser(String userId);
}

class MockCommunityRepository implements CommunityRepository {
  @override
  Future<Either<Failure, List<PostEntity>>> getPosts({
    int page = 1,
    int perPage = 20,
  }) async {
    return Right([
      PostEntity(
        id: '1', userId: 'u1', userName: 'John Doe', userAvatar: '',
        time: '2h ago', content: 'Great workout today!', likes: 15,
        comments: 3, isLiked: false, icon: '🏋️',
      ),
      PostEntity(
        id: '2', userId: 'u2', userName: 'Jane Smith', userAvatar: '',
        time: '4h ago', content: 'New PR on deadlift!', likes: 28,
        comments: 7, isLiked: true, icon: '💪',
      ),
    ]);
  }

  @override
  Future<Either<Failure, PostEntity>> createPost({
    required String content, List<String>? mediaUrls,
  }) async {
    return Right(PostEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'u1', userName: 'Me', userAvatar: '',
      time: 'Just now', content: content, mediaUrls: mediaUrls ?? [],
      likes: 0, comments: 0,
    ));
  }

  @override
  Future<Either<Failure, PostEntity>> likePost(String postId) async {
    return Right(PostEntity(
      id: postId, userId: 'u1', userName: 'User', userAvatar: '',
      time: '1h ago', content: 'Test post', likes: 1, comments: 0, isLiked: true,
    ));
  }

  @override
  Future<Either<Failure, PostEntity>> unlikePost(String postId) async {
    return Right(PostEntity(
      id: postId, userId: 'u1', userName: 'User', userAvatar: '',
      time: '1h ago', content: 'Test post', likes: 0, comments: 0, isLiked: false,
    ));
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String postId) async {
    return Right([]);
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment({
    required String postId, required String content,
  }) async {
    return Right(CommentEntity(
      id: 'c1', userId: 'u1', userName: 'Me', userAvatar: '',
      content: content, timestamp: DateTime.now(),
    ));
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<StoryEntity>>> getStories() async {
    return Right([]);
  }

  @override
  Future<Either<Failure, void>> uploadStory({required String imagePath}) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<ActivityFeedItem>>> getActivityFeed() async {
    return Right([]);
  }

  @override
  Future<Either<Failure, void>> followUser(String userId) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String userId) async {
    return const Right(null);
  }
}



