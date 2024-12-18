import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/workspace_entity.dart';
import '../../repositories/workspace_repositories.dart';

class GetJoinedWorkspaces {
  final WorkspaceRepositories repository;

  GetJoinedWorkspaces(this.repository);

  Future<Either<Failure, List<Workspace>>> call(String userId) async {
    return await repository.getJoinedWorkspaces(userId);
  }
}