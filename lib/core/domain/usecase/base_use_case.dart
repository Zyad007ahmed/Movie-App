import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../error/failure.dart';

abstract class BaseUseCase<T,P> {
  Future<Either<Failure,T>> call(P p);
} 

class NoParameters extends Equatable{
  const NoParameters._internal();
  @override
  List<Object?> get props => [];
}

const noParametrs = NoParameters._internal();