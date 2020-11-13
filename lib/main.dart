import 'package:flutter/material.dart';
import 'package:edgeware/edgeware.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edgeware Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Edgeware KeyPair Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _pk;
  Edgeware _edgeware;

  @override
  void initState() {
    super.initState();
    _edgeware = Edgeware();
  }

  void _regenerate() {
    final keypair = _edgeware.generateKeyPair('123456');
    final paperKey = _edgeware.backupKeyPair();
    final k2 = _edgeware.restoreKeyPair(paperKey, '123456');
    // restore works :)
    assert(k2.public == keypair.public);
    setState(() {
      _pk = keypair.public;
    });
  }

  @override
  void dispose() {
    _edgeware.cleanKeyPair();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Public Key:',
            ),
            if (_pk != null)
              Text(
                '$_pk',
              )
            else
              const Text(
                'Hit the floating action button to generate a Key',
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _regenerate,
        tooltip: 'Generate',
        child: const Icon(Icons.autorenew),
      ),
    );
  }
}
