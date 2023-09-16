import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure,Type >> call(Params params);
}

class Params<T> {
  final T data;

  Params(this.data);
}

class NoParams {
  NoParams();
}

class MultiParams<T,E>{
  final T data;
  final E data2;

  MultiParams(this.data, this.data2);
}