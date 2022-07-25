import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            const ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            const ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              minVerticalPadding: 0,
              title: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Text('123', textAlign: TextAlign.left),
                    ),
                    Expanded(
                      child:Text("OK", textAlign: TextAlign.right),
                    ),
                    Expanded(
                      child: Text('1 Min', textAlign: TextAlign.right),
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}