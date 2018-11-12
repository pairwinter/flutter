import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(BabyNames());

class BabyNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BabyNamesWidget());
  }
}

class BabyNamesWidget extends StatefulWidget {
  @override
  State createState() {
    return BabyNamesState();
  }
}

final _mockNames = [
  {'name': 'Filip long long long long long long long name', 'votes': 10},
  {'name': 'Abraham', 'votes': 12},
  {'name': 'Richard', 'votes': 15},
  {'name': 'Ike', 'votes': 20},
  {'name': 'Justin', 'votes': 21},
];

class BabyNamesState extends State<BabyNamesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Static Baby Names'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.more_horiz), onPressed: _gotoRealNames)
        ],
      ),
      body: _buildStaticBody(),
    );
  }

  // Go to new page
  _gotoRealNames() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Dynamic baby Names'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _buildStreamBody(),
              Flexible(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  Widget _buildStaticBody() {
    Container root = Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final record = Record.fromMap(_mockNames[index]);
          return _buildNameItem(record);
        },
        itemCount: _mockNames.length,
      ),
    );
    return root;
  }

  Widget _buildStreamBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        List<DocumentSnapshot> snapshots = snapshot.data.documents;
        Container root = Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final record = Record.fromSnapshot(snapshots[index]);
              return _buildNameItem(record);
            },
            itemCount: snapshots.length,
          ),
        );
        return Expanded(child: root);
      },
    );
  }

  Widget _buildNameItem(Record record) {
    return Padding(
      key: ValueKey(record.name),
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          title: Text(record.toString()),
          trailing: Text(record.votes.toString()),
          onTap: () {
            if (record.reference != null) {
              //Not safe, it will work incorrect when multiple users operating at the same time.
              //record.reference.updateData({
              //  'votes': record.votes + 1
              //});

              //Safe, using Transaction to keep safe.
              Firestore.instance.runTransaction((transaction) async {
                final freshSnapshot = await transaction.get(record.reference);
                final freshRecord = Record.fromSnapshot(freshSnapshot);
                await transaction
                    .update(record.reference, {'votes': freshRecord.votes + 1});
              });
            }
          },
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return 'Record: <$name: $votes>';
  }
}
