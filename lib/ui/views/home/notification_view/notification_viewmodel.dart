import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends ReactiveViewModel {
  List notifications = [
    {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'},
    // {'msg':'A reminder was set for Invoice 007 debt (receivable) due on 30/06/2020', 'price': '3000', 'time': '10:30AM'}
  ];

  final _logService = locator<LogsLocalDataSourceImpl>();

  List<LogH> get loglist => _logService.loglist;
  bool get notify => _logService.shouldnotify;

  void getlogs(){
    print('called2');
    _logService.getLogs();
    if(notify){
      _logService.setnotify();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_logService];
}