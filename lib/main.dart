import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'widgets/favorite.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

var titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Oeschinen Lake Campground',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Oeschinen Lake Campground',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
      FavoriteWidget()
    ],
  ),
);

var textSection = Container(
  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  alignment: Alignment.center,
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    'Alps. Situated 1,578 meters above sea level, it is one of the '
    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    'half-hour walk through pastures and pine forest, leads you to the '
    'lake, which warms to 20 degrees Celsius in the summer. Activities '
    'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);

Widget Function(BuildContext context) _buildIconSection = (context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: IconButton(
                onPressed: () {
                  print(context);
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: Text('My Page')),
                        body: Center(
                          child: FlatButton(
                            child: Text('POP'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ));
                },
                icon: Icon(
                  Icons.call,
                  color: Colors.blue[500],
                ),
              ),
            ),
            Text(
              'CALL',
              style: TextStyle(color: Colors.blue[500]),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(
                Icons.location_on,
                color: Colors.blue[500],
              ),
            ),
            Text(
              'ROUTE',
              style: TextStyle(color: Colors.blue[500]),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(
                Icons.share,
                color: Colors.blue[500],
              ),
            ),
            Text(
              'SHARE',
              style: TextStyle(color: Colors.blue[500]),
            )
          ],
        )
      ],
    ),
  );
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator ',
      // home: RandomWords(),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('TestProject'),
            ),
            body: ListView(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(400, 0),
                  child: Transform(
                    // origin: Offset.fromDirection(0.275, 0.5),
                    transform: Matrix4.rotationZ(pi / 2),
                    child: Image.asset(
                      'images/lake.jpg',
                      height: 400,
                      width: 600,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                titleSection,
                _buildIconSection(context),
                textSection
              ],
            ),
          );
        }
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Container(
        color: Colors.red,
        padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: _pushSaved, child: Text('Increment')),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onDoubleTap: () {
          print('my gesture is detected');
        },
        child: Container(
          height: 36.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.lightGreen[500]),
          child: Center(
            child: Text('click me'),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      backgroundColor: Colors.white,
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return ListTile(
                title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ));
          });
          final List<Widget> divided =
              ListTile.divideTiles(context: context, tiles: tiles).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}
