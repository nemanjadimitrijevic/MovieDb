import 'package:equatable/equatable.dart';

abstract class NetworkConnectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkInitial extends NetworkConnectionState {}

class NetworkConnected extends NetworkConnectionState {}

class NetworkDisconnected extends NetworkConnectionState {}
