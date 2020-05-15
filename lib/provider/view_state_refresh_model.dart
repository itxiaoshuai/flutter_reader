import 'package:flutterreader/provider/view_state_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshModel<T> extends ViewStateModel {
  /// 第一次进入页面loading skeleton
  initData() async {
    setLoading();
    await refresh(init: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;
  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      T data = await loadData();
      if (data == null) {
        setEmpty();
      } else {
        onCompleted(data);
        setIdle();
      }
    } catch (e, s) {
      setError(e, s);
    }
  }

  // 加载数据
  Future<T> loadData();

  onCompleted(T data) {}
}
