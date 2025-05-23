class Failure {
  final String message;

  Failure(this.message);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure(super.message);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message);

  @override
  String get message => _stripHtml(super.message);

  String _stripHtml(String input) {
    final RegExp exp = RegExp(r'<[^>]*>');
    return input.replaceAll(exp, '');
  }
}


class ServerFailure extends Failure {
  ServerFailure() : super('Server error occurred.');
}
