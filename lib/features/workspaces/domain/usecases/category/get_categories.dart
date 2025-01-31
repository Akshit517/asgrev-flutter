import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/category/category_entity.dart';
import '../../repositories/workspace_repositories.dart';

class GetCategories {
  final WorkspaceRepositories repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<Category>>> call(String workspaceId) async {
    final category = await repository.getCategories(workspaceId);
    return category;
  }
}