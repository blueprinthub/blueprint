import 'package:bloc/bloc.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial()) {
    on<ProjectsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
