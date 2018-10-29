import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordpair = WordPair('damon', 'liu');
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App title'),
        ),
        body: Center(
//          child: Text('home->body->Center>child(Text)'),
          child: Text(wordpair.asPascalCase),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
