import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/category/category_entity.dart';
import '../../repositories/workspace_repositories.dart';

class UpdateCategoryUseCase {
  final WorkspaceRepositories repository;

  UpdateCategoryUseCase({required this.repository});

  Future<Either<Failure, Category>> call(String workspaceId, int categoryId, String name) async {
    return await repository.updateCategory(workspaceId, categoryId, name);
  }
}
