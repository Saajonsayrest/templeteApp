import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../widgets/no_internet.dart';

class MonitorConnectionView extends StatefulWidget {
  final Widget child;

  const MonitorConnectionView({
    super.key,
    required this.child,
  });

  @override
  _MonitorConnectionViewState createState() => _MonitorConnectionViewState();
}

class _MonitorConnectionViewState extends State<MonitorConnectionView> {
  late Stream<InternetStatus> _connectionStatusStream;
  late InternetStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = InternetStatus.connected; // Default status
    _connectionStatusStream = InternetConnection().onStatusChange;

    // Listen to the connectivity status
    _connectionStatusStream.listen((InternetStatus status) {
      setState(() {
        _currentStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStatus == InternetStatus.disconnected) {
      return const NoInternetWidget();
    } else {
      return widget.child;
    }
  }
}
