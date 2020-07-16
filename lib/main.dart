import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzlerapp/mock_value.dart';
import 'package:quizzlerapp/question.dart';
import 'package:quizzlerapp/result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static TextStyle style = TextStyle(fontSize: 24, color: Colors.white);
  int current = 0;
  Question curQuestion = questions[0];
  List<bool> results = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),
      appBar: AppBar(
        title: Text("Quizzler"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          buildQuestion(),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      checkAnswer(true,context);
                    },
                    child: Text(
                      "True",
                      style: style,
                    ),
                    color: Colors.green),
                RaisedButton(
                    onPressed: () {
                      checkAnswer(false,context);
                    },
                    child: Text(
                      "False",
                      style: style,
                    ),
                    color: Colors.red),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(children: buildResults()))
        ],
      ),
    );
  }

  Widget buildQuestion() {
    return Text(
      '${curQuestion.question}',
      style: style,
      textAlign: TextAlign.center,
    );
  }

  List<Widget> buildResults() {
    List<Widget> resultsWidget = [];
    for (bool result in this.results) {
      if (result) {
        // nếu đúng
        resultsWidget.add(Icon(Icons.check, color: Colors.green));
      } else {
        resultsWidget.add(Icon(Icons.close, color: Colors.red));
      }
    }
    return resultsWidget;
  }

  checkAnswer(bool answer,BuildContext context) {
    // check xem đã trả lời hết chưa trước khi chuyển sang câu tiếp theo
    // nếu đã trả lời hết rồi 'navigate' (chuyển sang) trang kết qua
    if (current >= questions.length) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return ResultPage(rightAnswer: results.where((element) => element).length, allAnswer: results.length);
      }));
      return;
    }
    print(this.current);
    curQuestion = questions[current];
    if (answer == curQuestion.isTrue) {
      results.add(true);
    } else {
      results.add(false);
    }

    setState(() {
      if (current < questions.length) {
        current += 1;
      }
    });
  }
}
