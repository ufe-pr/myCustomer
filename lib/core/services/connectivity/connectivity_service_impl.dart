import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:mycustomers/core/enums/connectivity_status.dart';
import 'package:mycustomers/core/enums/data_connection_status.dart';
import 'package:mycustomers/core/services/connectivity/connectivity_checker.dart';
import 'package:mycustomers/core/services/connectivity/connectivity_services.dart';
import 'package:mycustomers/core/utils/logger.dart';


class ConnectivityServiceImpl implements ConnectivityService {
  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();
  final _connection = ConnectionChecker();

  StreamSubscription<ConnectivityResult> _subscription;
  StreamSubscription<DataConnectionStatus> _connectionlistener;
  ConnectivityResult _lastResult;
  bool _serviceStopped = false;

  @override
  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  @override
  bool get serviceStopped => _serviceStopped;

  ConnectivityServiceImpl() {
    _subscription = _connectivity.onConnectivityChanged.listen(_emitConnectivity);
    _connectionlistener = _connection.onStatusChange.listen((status) {Logger.d('Current Internet Connection State: $status');});
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
      default:
        return false;
    }
  }

  @override
  void start() async {
    Logger.d('ConnectivityService resumed');
    _serviceStopped = false;

    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    Logger.d('ConnectivityService paused');
    _serviceStopped = true;

    _subscription.pause(_resumeSignal());
    _connectionlistener.cancel();
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;

    Logger.d('Connectivity status changed to $event');
    _connectivityResultController.add(_convertResult(event));
    _lastResult = event;
  }

  ConnectivityStatus _convertResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}
