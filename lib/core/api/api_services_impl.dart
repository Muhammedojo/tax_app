import 'package:fpdart/fpdart.dart';
import 'package:tax_app/core/api/services/endpoints.dart';

import '../data/model/language.dart';
import '../data/model/law.dart';
import '../data/model/offline_pack.dart';
import '../data/model/role.dart';
import '../data/model/topic.dart';
import '../data/model/update.dart';
import 'api_services.dart';
import 'exceptions/contracts/failure.dart';
import 'services/contracts/api_client.dart';
import 'services/contracts/api_response.dart';
import 'services/dio_client.dart';

class ApiServiceImpl implements ApiService {
  final IApiClient apiClient;

  ApiServiceImpl({required this.apiClient});

  @override
  Future<Either<Failure, ApiResponse<List<Role>>>> getRoleList(
    String? endpoint,
  ) async {
    return apiClient.request<List<Role>>(
      endpoint ?? roleEndpoint,
      MethodType.get,
      (data, {String? realUri}) {
        final programmeList = (data as List)
            .map<Role>((e) => Role.fromJson(e))
            .toList();

        return programmeList;
      },
      null,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<List<Topic>>>> getTopicList(
    String? endpoint,
  ) async {
    return apiClient.request<List<Topic>>(
      endpoint ?? topicEndpoint,
      MethodType.get,
      (data, {String? realUri}) {
        return (data as List).map<Topic>((e) => Topic.fromJson(e)).toList();
      },
      null,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<List<Law>>>> getLawList(
    String? endpoint,
  ) async {
    return apiClient.request<List<Law>>(
      endpoint ?? lawEndpoint,
      MethodType.get,
      (data, {String? realUri}) {
        final lawList = (data as List)
            .map<Law>((e) => Law.fromJson(e))
            .toList();

        return lawList;
      },
      null,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<List<Update>>>> getUpdateList(
    String? endpoint,
  ) async {
    return apiClient.request<List<Update>>(
      endpoint ?? updateEndpoint,
      MethodType.get,
      (data, {String? realUri}) {
        final updateList = (data as List)
            .map<Update>((e) => Update.fromJson(e))
            .toList();

        return updateList;
      },
      null,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<OfflinePack>>> getOfflinePack(
    String? endpoint,
  ) async {
    return apiClient.request<OfflinePack>(
      endpoint ?? offlinePackEndpoint,
      MethodType.get,
      (data, {String? realUri}) => OfflinePack.fromJson(data['data']),
      null,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<List<Language>>>> getLanguageList(
    String? endpoint,
  ) async {
    return apiClient.request<List<Language>>(
      endpoint ?? languageEndpoint,
      MethodType.get,
      (data, {String? realUri}) =>
          (data as List).map<Language>((e) => Language.fromJson(e)).toList(),
      null,
    );
  }
}
