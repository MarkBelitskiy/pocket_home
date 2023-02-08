part of 'add_service_bloc.dart';

abstract class AddServiceEvent {}

class CreateServceEvent extends AddServiceEvent {
  final ServiceDetailedModel modelToPrefs;

  CreateServceEvent(this.modelToPrefs);
}
