import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(BabyNames());

class BabyNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Baby Names'),
        ),
        body: BabyNamesWidget(),
      ),
    );
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
    return _buildBody();
  }

  Widget _buildBody() {
    Container root = Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final record = Record.fromMap(_mockNames[index]);
          return Padding(
            key: ValueKey(record.name),
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: ListTile(
                title: Text(record.toString()),
                trailing: Text(record.votes.toString()),
                onTap: (){
                  print(record);
                },
              ),
            ),
          );
        },
        itemCount: _mockNames.length,
      ),
    );
    return root;
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
