sealed class Either<L, R> {
  const Either();
}

final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}

extension EitherExtensions<L, R> on Either<L, R> {
  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L get left => (this as Left<L, R>).value;
  R get right => (this as Right<L, R>).value;

  void fold(void Function(L left) ifLeft, void Function(R right) ifRight) {
    if (this is Left<L, R>) {
      ifLeft((this as Left<L, R>).value);
    } else {
      ifRight((this as Right<L, R>).value);
    }
  }

  Either<T, R> mapLeft<T>(T Function(L left) f) {
    if (this is Left<L, R>) {
      return Left(f(left));
    }
    return Right(right);
  }

  Either<L, T> mapRight<T>(T Function(R right) f) {
    if (this is Right<L, R>) {
      return Right(f(right));
    }
    return Left(left);
  }
}
