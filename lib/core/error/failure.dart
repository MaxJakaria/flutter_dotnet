import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  @override
  List<Object?> get props => [message];

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}
