import 'package:flutter/material.dart';

import '../utils/monitor_connection.dart';


extension NoInternet on Widget {
  Widget monitorConnection() {
    return MonitorConnectionView(
      child: this,
    );
  }
}
