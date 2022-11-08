import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_event.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_state.dart';

class NetworkConnectionBloc
    extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {
  NetworkConnectionBloc() : super(const NetworkConnectionState()) {
    on<CheckNetworkConnection>(_checkNetworkConnection);
  }

  _checkNetworkConnection(NetworkConnectionEvent event,
      Emitter<NetworkConnectionState> emit) async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('STATUS -> $result');
      // if (result == ConnectivityResult.none) {
      //   emit(state.copyWith(isConnected: false));
      // } else {
      //   emit(state.copyWith(isConnected: true));
      // }
    });
  }
}
