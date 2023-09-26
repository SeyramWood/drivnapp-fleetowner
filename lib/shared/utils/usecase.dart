import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, P> {
  Future<Either<Failure,Type >> call(P params);
}

class Params<T> {
  final T data;

  Params(this.data);
}

class NoParams {
  NoParams();
}

class MultiParams<T1,T2>{
  final T1 data1;
  final T2 data2;

  MultiParams(this.data1, this.data2);
}