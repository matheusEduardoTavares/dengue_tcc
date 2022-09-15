import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';

abstract class InformationRepository {
  InformationRepository._();

  Future<Either<String, InformationModel>> getInformations(String endpoint);
}
