import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/workspace_entity.dart';
import '../../../domain/usecases/category/get_categories.dart';
import '../../../domain/usecases/workspaces/create_worksapce.dart';
import '../../../domain/usecases/workspaces/delete_workspace.dart';
import '../../../domain/usecases/workspaces/get_joined_workspaces.dart';
import '../../../domain/usecases/workspaces/get_workspace.dart';
import '../../../domain/usecases/workspaces/update_workspace.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final CreateWorkspace createWorkspace;
  final DeleteWorkspace deleteWorkspace;
  final UpdateWorkspace updateWorkspace;
  final GetWorkspace getWorkspace;
  final GetJoinedWorkspaces getJoinedWorkspaces;
  final GetCategories getCategories;

  WorkspaceBloc({
    required this.createWorkspace,
    required this.deleteWorkspace,
    required this.updateWorkspace,
    required this.getWorkspace,
    required this.getJoinedWorkspaces,
    required this.getCategories,
  }) : super(WorkspaceInitial()) {
    on<CreateWorkspaceEvent>(_onCreateWorkspace);
    on<DeleteWorkspaceEvent>(_onDeleteWorkspace);
    on<UpdateWorkspaceEvent>(_onUpdateWorkspace);
    on<GetWorkspaceEvent>(_onGetWorkspace);
    on<GetJoinedWorkspacesEvent>(_onGetJoinedWorkspaces);
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onCreateWorkspace(
      CreateWorkspaceEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result = await createWorkspace(event.name, event.icon);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (workspace) => emit(WorkspaceCreated(workspace)),
    );
  }

  Future<void> _onDeleteWorkspace(
      DeleteWorkspaceEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result = await deleteWorkspace(event.workspaceId);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (_) => emit(WorkspaceDeleted()),
    );
  }

  Future<void> _onUpdateWorkspace(
      UpdateWorkspaceEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result =
        await updateWorkspace(event.workspaceId, event.name, event.icon);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (workspace) => emit(WorkspaceUpdated(workspace)),
    );
  }

  Future<void> _onGetWorkspace(
      GetWorkspaceEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result = await getWorkspace(event.workspaceId);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (workspace) => emit(WorkspaceLoaded(workspace)),
    );
  }

  Future<void> _onGetJoinedWorkspaces(
      GetJoinedWorkspacesEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result = await getJoinedWorkspaces(event.userId);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (workspaces) => emit(WorkspacesLoaded(workspaces)),
    );
  }

  Future<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<WorkspaceState> emit) async {
    emit(WorkspaceLoading());
    final result = await getCategories(event.workspaceId);
    result.fold(
      (failure) => emit(WorkspaceError(message: _mapFailureToMessage(failure))),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is UnauthorizedFailure) {
      return 'Unauthorized Access';
    } else if (failure is ServerFailure) {
      return 'Server Error';
    } else {
      return 'Unexpected Error';
    }
  }
}
