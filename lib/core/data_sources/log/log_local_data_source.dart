import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/utils/file_helper.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

abstract class LogsLocalDataSource {
  /// Initialize Hive DB
  Future<void> init();

  /// Saves all the log [values] with auto-increment keys.
  Future<void> addLog(LogH log);
  void getLogs();

  /// Deletes the n-th key from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> deleteLog(int id);

  void getValues(int price, DateTime time, String action, String name, bool update);
}

class LogsLocalDataSourceImpl with ReactiveServiceMixin implements LogsLocalDataSource {
  final _fileHelper = locator<FileHelper>();
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.logs);
  Box<LogH> get _logsBox => _hiveService.box<LogH>(HiveBox.logs);

  RxValue<List<LogH>> _loglist = RxValue<List<LogH>>(initial: []);
  List<LogH> get loglist => _loglist.value;

  bool shouldnotify = false;

  LogsLocalDataSourceImpl(){
    listenToReactiveValues([_loglist, shouldnotify]);
  }

  @override
  Future<void> init() async {
    //final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    //_hiveService.init(path);
    _hiveService.registerAdapter<LogH>(LogHAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<LogH>(HiveBox.logs);
    }
  }

  @override
  void getValues(int price, DateTime time, String action, String name, bool update){
    int totallogs = _logsBox.values.toList().length;
    String msg;
    if(action == 'sign-in'){
      msg = 'Welcome, Signed In';
    } else if(action =='create-store'){
      msg = '$name store was created successfully';
    } else if(action == 'sign-out'){
      msg = 'Sign out of account';
    } else if(action == 'lang-change') {
      msg = 'Language changed';
    } else if(action == 'curr-change') {
      msg = 'Currency changed to $name';
    } else if(action == 'set-pin') {
      msg = 'Pin Changed';
    } else if(action == 'remove-pin') {
      msg = 'Pin Removed';
    } else {
      msg = update ? action == 'credit' ? 'A credit transaction was made for one of the debit of $name' : 'A debit transaction was made for one of the credit of $name' : action == 'credit' ? 'A credit transaction was made for $name' : 'A debit transaction was made for $name';
    }
    LogH newlog = new LogH(totallogs+1, msg, action, time);
    addLog(newlog);
  }

  void testfunc(DateTime time){
    int totallogs = _logsBox.values.toList().length; 
    String msg = 'Welcome Login at'+time.toString();
    LogH newlog = new LogH(totallogs+1, msg, 'debit', time);
    print(newlog);
    addLog(newlog);
  }

  void setnotify(){
    shouldnotify = !shouldnotify;
  }

  @override
  Future<void> addLog(LogH log) async {
    return _logsBox.put(log.id, log).then((value) {
      if(!shouldnotify){
        setnotify();
      }
    });
  }

  @override
  Future<void> deleteLog(int id) async {
    return _logsBox.delete(id);
  }

  @override
  void getLogs() {
    _loglist.value = _logsBox.values.toList();
    _loglist.value = new List<LogH>.from(_loglist.value.reversed);
  }
}
