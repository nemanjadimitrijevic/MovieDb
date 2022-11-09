import 'package:equatable/equatable.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_state.dart';

abstract class NetworkConnectionEvent extends Equatable {
  const NetworkConnectionEvent();

  @override
  List<Object?> get props => [];
}

class CheckNetworkConnection extends NetworkConnectionEvent {
  @override
  List<Object?> get props => [];
}

class ConnectionChanged extends NetworkConnectionEvent {
  final NetworkConnectionState connection;
  const ConnectionChanged({required this.connection});

  @override
  List<Object?> get props => [connection];
}
