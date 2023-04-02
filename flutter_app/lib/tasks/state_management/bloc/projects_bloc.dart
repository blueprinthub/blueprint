import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poll_e_task/tasks/entities/entities.dart';
import 'package:poll_e_task/tasks/repositories/projects_repository.dart';

part 'projects_bloc.freezed.dart';
part 'projects_event.dart';
part 'projects_state.dart';

/// The [ProjectsBloc] is responsible for managing the state of the projects
/// page.
///
/// Reacts to the following events:
/// - [LoadProjects] - Loads all the projects from the repository.
/// - [CreateProject] - Creates a new project.
/// - [UpdateProject] - Updates an existing project.
/// - [DeleteProject] - Deletes an existing project.
///
/// Emits the following states:
/// - [ProjectsInitial] - The initial state of the bloc.
/// - [ProjectsLoading] - The state when the bloc is loading the projects.
/// - [ProjectsModifyingProject] - The state when the bloc is modifying a project.
/// - [ProjectsLoaded] - The state when the bloc has loaded the projects.
/// - [ProjectsError] - The state when the bloc has encountered an error.
///
class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._projectRepository) : super(const ProjectsInitial([]));

  /// The subscription to the stream of projects. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<List<Project>>? _projectsSubscription;

  Future<void> loadProjects() async {
    if (_projectsSubscription != null) {
      // If the bloc has a subscription to the stream of projects, then it is
      // already with the latest data.
      return;
    }

    emit(const ProjectsLoading([]));
    try {
      final projects = _projectRepository.getProjects();

      _projectsSubscription = projects.listen(
        (projects) {
          if (isClosed) {
            return;
          }
          emit(ProjectsState.loaded(projects));
        },
      );
    } catch (e) {
      emit(ProjectsState.error(state.projects, e.toString()));
    }
  }

  @override
  Future<void> close() {
    _projectsSubscription?.cancel();
    return super.close();
  }

  final ProjectRepository _projectRepository;
}
