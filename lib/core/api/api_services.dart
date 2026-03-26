import 'package:fpdart/fpdart.dart';
import '../data/model/language.dart';
import '../data/model/law.dart';
import '../data/model/offline_pack.dart';
import '../data/model/role.dart';
import '../data/model/topic.dart';
import '../data/model/update.dart';
import 'exceptions/contracts/failure.dart';
import 'services/contracts/api_response.dart';

abstract class ApiService {
  Future<Either<Failure, ApiResponse<List<Role>>>> getRoleList(
    String? endpoint,
  );

  Future<Either<Failure, ApiResponse<List<Topic>>>> getTopicList(
    String? endpoint,
  );

  Future<Either<Failure, ApiResponse<List<Law>>>> getLawList(
    String? endpoint,
  );

  Future<Either<Failure, ApiResponse<List<Update>>>> getUpdateList(
    String? endpoint,
  );

  Future<Either<Failure, ApiResponse<OfflinePack>>> getOfflinePack(
    String? endpoint,
  );

  Future<Either<Failure, ApiResponse<List<Language>>>> getLanguageList(
    String? endpoint,
  );
}
