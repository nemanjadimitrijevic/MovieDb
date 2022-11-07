import 'package:equatable/equatable.dart';

class NetworkConnectionState extends Equatable {
  final bool isConnected;
  const NetworkConnectionState({this.isConnected = true});

  @override
  List<Object?> get props => [isConnected];

  NetworkConnectionState copyWith({bool? isConnected}) {
    return NetworkConnectionState(isConnected: isConnected ?? this.isConnected);
  }
}
