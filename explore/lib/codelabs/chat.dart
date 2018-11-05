import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(RootWidget());
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FriendlyChat());
  }
}

class FriendlyChat extends StatefulWidget {
  @override
  State createState() {
    return FriendlyChatState();
  }
}

class FriendlyChatState extends State<FriendlyChat> {
  final TextEditingController _textComposerController = TextEditingController();
  final List<ChatMessage> _chatMessages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendly Chat'),
      ),
      body: IconTheme(
          data: IconThemeData(color: Theme.of(context).accentColor),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: ListView.builder(
                itemCount: _chatMessages.length,
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _chatMessages[index],
              )),
              Divider(height: 1.0),
              Container(
                child: _buildTextComposer(),
              )
            ],
          )),
    );
  }

  _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textComposerController,
            onSubmitted: this._handleTextComposerSubmit,
            decoration: InputDecoration.collapsed(hintText: 'Send a message.'),
          )),
          Container(
            child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    _handleTextComposerSubmit(_textComposerController.text)),
          )
        ],
      ),
    );
  }

  void _handleTextComposerSubmit(String text) {
    if (text.trim().length == 0) {
      return;
    }
    _textComposerController.clear();

    this.setState(() {
      _chatMessages.insert(
          0,
          ChatMessage(
            name: WordPair.random().asPascalCase,
            message: text.trim(),
          ));
    });
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.name});

  final String message;
  final String name;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              child: Text(name[0]),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context).textTheme.subhead,
              ),
              Container(
                width: c_width,
                child: Text(message),
              )
            ],
          )
        ],
      ),
    );
  }
}
