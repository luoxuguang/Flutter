import 'package:flip_carousel_rehearsal/card_data.dart';
import 'package:flip_carousel_rehearsal/card_flipper.dart';
import 'package:flip_carousel_rehearsal/refresh_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RefreshPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              height: 20,
              width: double.infinity,
            ),
            new Expanded(child: new CardFlipper(
              cards: demoCards,
              onScroll: ()=>{},
            )),

          ],
      ),
    );

  }
}
