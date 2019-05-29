import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() {
    // TODO: implement createState
    return _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  int _favoriteCount = 10;
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: _isFavorited ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.red[500],
          onPressed: () {
            setState(() {
              if (_isFavorited) {
                _isFavorited = false;
                _favoriteCount -= 1;
              } else {
                _isFavorited = true;
                _favoriteCount += 1;
              }
            });
          },
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}
