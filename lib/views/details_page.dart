import 'package:flutter/material.dart';

//constants
import '../constants/doubles.dart';


class DetailPage extends StatelessWidget {
  final dynamic items;
  const DetailPage({
    Key? key,
    required this.items
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: items['full_name'], child: Text(items['full_name'], style: TextStyle(color: Colors.black,fontSize: titleFontSize, fontWeight: FontWeight.normal),)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: items['owner']['avatar_url'], child: CircleAvatar(backgroundImage: NetworkImage(items['owner']['avatar_url']))),
                SizedBox(width: sizedWeight),
                Text(items['language']),
              ],
            ),
            SizedBox(height: sizedHeight),
            Row(
              children: <Widget>[
                Hero(tag: '${items['full_name']}-star', child: Icon(Icons.star, size: iconSize)),
                SizedBox(width: spaceWeight),
                Text('${items['stargazers_count']}'),
                SizedBox(width: sizedWeight),
                Hero(tag: '${items['full_name']}-watchers', child: Icon(Icons.remove_red_eye, size: iconSize)),
                SizedBox(width: spaceHeight),
                Text('${items['watchers_count']}'),
                SizedBox(width: sizedWeight),
                Hero(tag: '${items['full_name']}-forks', child: Icon(Icons.call_split, size: iconSize)),
                SizedBox(width: spaceWeight),
                Text('${items['forks_count']}'),
              ],
            ),
            SizedBox(height: sizedHeight),
            Row(
              children: <Widget>[
                Icon(Icons.warning, size: iconSize),
                SizedBox(width: spaceWeight),
                Text('${items['open_issues_count']} open issues'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
