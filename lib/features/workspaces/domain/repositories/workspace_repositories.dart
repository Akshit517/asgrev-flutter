import 'package:dartz/dartz.dart';
import 'package:ReviewPal/features/workspaces/domain/entities/category_entity.dart';
import 'package:ReviewPal/features/workspaces/domain/entities/workspace_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/category_member.dart';
import '../entities/workspace_member.dart';

abstract class WorkspaceRepositories {
  // Workspace methods
  Future<Either<Failure, Workspace>> createWorkspace(String name, String icon);
  Future<Either<Failure, void>> deleteWorkspace(String workspaceId);
  Future<Either<Failure, Workspace>> updateWorkspace(String workspaceId, String name, String icon);
  Future<Either<Failure, List<Workspace>>> getJoinedWorkspaces();
  Future<Either<Failure, Workspace>> getWorkspace(String workspaceId);
  Future<Either<Failure, void>> addWorkspaceMember(String workspaceId, String userEmail, String role);
  Future<Either<Failure, void>> removeWorkspaceMember(String workspaceId, String userEmail);
  Future<Either<Failure, List<WorkspaceMember>>> getWorkspaceMembers(String workspaceId);
  //Future<Either<Failure, void>> leaveWorkspace(String workspaceId);

  // Commented as not implemented
  // Future<Either<Failure, void>> leaveWorkspace(String workspaceId);
  // Future<Either<Failure, Workspace>> joinWorkspace(String workspaceId);
  // Future<Either<Failure, WorkspaceMember>> getWorkspaceMember(String workspaceId, String email);
  // Future<Either<Failure, void>> updateWorkspaceMember(String workspaceId, String email, String role);

  // Category methods
  Future<Either<Failure, List<Category>>> getCategories(String workspaceId);
  Future<Either<Failure, Category>> createCategory(String workspaceId, String name);
  Future<Either<Failure, void>> deleteCategory(String workspaceId, String id);
  Future<Either<Failure, Category>> updateCategory(String workspaceId, String id, String name);
  Future<Either<Failure, List<CategoryMember>>> getCategoryMembers(String workspaceId, String id);
  Future<Either<Failure, void>> addMemberToCategory(String workspaceId, String id, String email);
  Future<Either<Failure, void>> removeMemberFromCategory(String workspaceId, String id, String email);
  Future<Either<Failure, CategoryMember>> getCategoryMember(String workspaceId, String id, String email);
  Future<Either<Failure, void>> updateCategoryMember(String workspaceId, String id, String email, String role);

  // Channel methods (to be implemented similarly)
  // Future<Either<Failure, void>> createChannel(String workspaceId, String categoryId, String name, Assignment? assignmentData);
  // Future<Either<Failure, Channel>> updateChannel(String workspaceId, String categoryId, String channelId, String? name, Assignment? assignmentData);
  // Future<Either<Failure, Channel>> getChannel(String workspaceId, String categoryId, String channelId);
  // Future<Either<Failure, List<ChannelMember>>> getChannelMembers(String workspaceId, String categoryId, String channelId);
  // Future<Either<Failure, void>> addMemberToChannel(String workspaceId, String categoryId, String channelId, String email);
  // Future<Either<Failure, void>> removeMemberFromChannel(String workspaceId, String categoryId, String channelId, String email);

  // Assignment methods (to be implemented)
  // Either<Failure, Assignment> getAssignment(String workspaceId, String categoryId, String channelId);
  // Either<Failure, void> updateAssignment(String workspaceId, String categoryId, String channelId, Assignment assignment);

  // Submission Reviewee methods (to be implemented)
  // Future<Either<Failure, List<Submission>>> getSubmissionsReviewee(
  //     String workspaceId, String categoryId, String channelId);
  // Future<Either<Failure, void>> createSubmissionReviewee(
  //     String workspaceId, String categoryId, String channelId, Map<String, dynamic> data);
  // Future<Either<Failure, void>> updateSubmissionReviewee(
  //     String workspaceId, String categoryId, String channelId, Map<String, dynamic> data);
  // Future<Either<Failure, void>> deleteSubmissionReviewee(
  //     String workspaceId, String categoryId, String channelId);
}
