import 'package:fpdart/fpdart.dart';

import '../../data/model/language.dart';
import '../../data/model/law.dart';
import '../../data/model/offline_pack.dart';
import '../../data/model/role.dart';
import '../../data/model/topic.dart';
import '../../data/model/update.dart';
import '../api_services.dart';
import '../exceptions/contracts/failure.dart';
import '../services/contracts/api_response.dart';
import 'repository_contract.dart';

class AppRepository implements IAppRepository {
  final ApiService service;
  AppRepository({required this.service});

  @override
  Future<Either<Failure, ApiResponse<List<Role>>>> getRoleList({
    String? endpoint,
  }) => service.getRoleList(endpoint);

  @override
  Future<Either<Failure, ApiResponse<List<Topic>>>> getTopicList({
    String? endpoint,
  }) => service.getTopicList(endpoint);

  @override
  Future<Either<Failure, ApiResponse<List<Law>>>> getLawList({
    String? endpoint,
  }) => service.getLawList(endpoint);

  @override
  Future<Either<Failure, ApiResponse<List<Update>>>> getUpdateList({
    String? endpoint,
  }) => service.getUpdateList(endpoint);

  @override
  Future<Either<Failure, ApiResponse<OfflinePack>>> getOfflinePack({
    String? endpoint,
  }) => service.getOfflinePack(endpoint);

  @override
  Future<Either<Failure, ApiResponse<List<Language>>>> getLanguageList({
    String? endpoint,
  }) => service.getLanguageList(endpoint);
}
