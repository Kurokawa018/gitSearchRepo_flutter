import 'package:flutter/material.dart';

//constants
import '../constants/doubles.dart';

class DetailPage extends StatelessWidget {
  final dynamic item;

  DetailPage({Key? key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: item['full_name'], child: Text(item['full_name'], style: TextStyle(color: Colors.black,fontSize: titleFontSize, fontWeight: FontWeight.normal),)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: item['owner']['avatar_url'], child: CircleAvatar(backgroundImage: NetworkImage(item['owner']['avatar_url']))),
                SizedBox(width: 10),
                Text(item['language']),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Hero(tag: '${item['full_name']}-star', child: Icon(Icons.star, size: iconSize)),
                SizedBox(width: 5),
                Text('${item['stargazers_count']}'),
                SizedBox(width: 20),
                Hero(tag: '${item['full_name']}-watchers', child: Icon(Icons.remove_red_eye, size: iconSize)),
                SizedBox(width: 5),
                Text('${item['watchers_count']}'),
                SizedBox(width: 20),
                Hero(tag: '${item['full_name']}-forks', child: Icon(Icons.call_split, size: iconSize)),
                SizedBox(width: 5),
                Text('${item['forks_count']}'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(Icons.warning, size: iconSize),
                SizedBox(width: 5),
                Text('${item['open_issues_count']} open issues'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
