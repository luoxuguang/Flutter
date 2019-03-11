import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';

class RefreshPage extends StatefulWidget {
  RefreshPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RefreshPageState createState() => new _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> with TickerProviderStateMixin {
  Widget _itemBuilder(BuildContext context, int index) {
    return new Padding(
      key: new Key(index.toString()),
      padding: new EdgeInsets.all(10.0),
      child: new Text(
        "Orered data:$index",
        style: new TextStyle(fontSize: 14.0),
      ),
    );
  }

  int _itemCount;

  @override
  void initState() {
    _itemCount = 10;
    super.initState();
  }

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _itemCount += 10;
      });
    });
  }

  Future<Null> onHeaderRefresh() {
//    throw new Exception("");

    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _itemCount = 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new SafeArea(
            child: new Refresh(

              onFooterRefresh: onFooterRefresh,
              onHeaderRefresh: onHeaderRefresh,
              child: new ListView.builder(
                itemBuilder: _itemBuilder,
                itemCount: _itemCount,
              ),
            )));
  }
}
