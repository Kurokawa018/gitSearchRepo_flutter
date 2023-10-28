import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic item;

  DetailPage({Key? key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['full_name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(backgroundImage: NetworkImage(item['owner']['avatar_url'])),
                SizedBox(width: 10),
                Text(item['language']),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(Icons.star, size: 16),
                SizedBox(width: 5),
                Text('${item['stargazers_count']}'),
                SizedBox(width: 20),
                Icon(Icons.remove_red_eye, size: 16),
                SizedBox(width: 5),
                Text('${item['watchers_count']}'),
                SizedBox(width: 20),
                Icon(Icons.call_split, size: 16),
                SizedBox(width: 5),
                Text('${item['forks_count']}'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(Icons.warning, size: 16),
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
