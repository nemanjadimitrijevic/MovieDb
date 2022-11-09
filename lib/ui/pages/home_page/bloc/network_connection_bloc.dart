import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_event.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_state.dart';

class NetworkConnectionBloc
    extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {
  late StreamSubscription _subscription;

  NetworkConnectionBloc() : super(NetworkInitial()) {
    on<CheckNetworkConnection>(_checkNetworkConnection);
    on<ConnectionChanged>(_onConnectionChanged);
  }

  _checkNetworkConnection(
      NetworkConnectionEvent event, Emitter<NetworkConnectionState> emit) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      add(ConnectionChanged(
          connection: result == ConnectivityResult.none
              ? NetworkDisconnected()
              : NetworkConnected()));
    });
  }

  _onConnectionChanged(
      NetworkConnectionEvent event, Emitter<NetworkConnectionState> emit) {
    emit((event as ConnectionChanged).connection);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
