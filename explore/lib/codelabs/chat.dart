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

class FriendlyChatState extends State<FriendlyChat>
    with TickerProviderStateMixin {
  final TextEditingController _textComposerController = TextEditingController();
  final List<ChatMessage> _chatMessages = <ChatMessage>[];
  bool _isComposing = false;

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
            onChanged: (String text) {
              this.setState(() {
                _isComposing = text.trim().length > 0;
              });
            },
          )),
          Container(
            child: IconButton(
                disabledColor: Colors.grey,
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () =>
                        _handleTextComposerSubmit(_textComposerController.text)
                    : null),
          )
        ],
      ),
    );
  }

  void _handleTextComposerSubmit(String text) {
    _textComposerController.clear();
    ChatMessage chatMessage = ChatMessage(
      name: WordPair.random().asPascalCase,
      message: text.trim(),
      animationController: AnimationController(
          duration: Duration(milliseconds: 200),
          vsync: this), //Note vsync: this
    );
    this.setState(() {
      _isComposing = false;
      _chatMessages.insert(0, chatMessage);
    });
    chatMessage.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage chatMessage in _chatMessages) {
      chatMessage.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.name, this.animationController});

  final String message;
  final String name;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    Container content = Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  child: Text(message),
                )
              ],
            ),
          )
        ],
      ),
    );
    SizeTransition transition = SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: content,
      axisAlignment: 0.0,
    );
    return transition;
  }
}
