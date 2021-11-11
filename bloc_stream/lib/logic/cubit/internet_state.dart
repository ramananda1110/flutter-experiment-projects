part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}


class InternetLoading extends InternetState {}

class InternetDisconnected extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({@required this.connectionType});
}

