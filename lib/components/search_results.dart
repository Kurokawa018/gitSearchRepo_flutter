import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yumemi_flutter/constants/strings.dart';

//model
import '../model/API_model.dart';

//views
import '../views/details_page.dart';

//constants
import '../constants/doubles.dart';
import '../constants/strings.dart';

//components
import 'error_widget.dart';


class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({
    Key? key,
    required this.githubModel,
    required this.items
  }) : super(key: key);

  final GithubModel githubModel;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //リクエストが走っているときに表示される。
        githubModel.isLoading ?
        Center(
          child: const Text(loadingText),
        ):
        SizedBox(height: 0),
        //レスポンスの検索結果が空の時に表示される
        githubModel.isEmpty ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(noResults, textAlign: TextAlign.left,
                style: TextStyle(fontSize: titleFontSize),),
            ] )
            : SizedBox(height: 0,),
        //Searchボタンタップ時、かつレスポンスの長さが0じゃないときに表示される。TextFieldが変更時に非表示になる
        githubModel.isSearched ?
         Expanded(child:
         Column(
           children: [
             Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(searchResults, textAlign: TextAlign.left,
                     style: TextStyle(fontSize: titleFontSize),),
                 ]),
             SizedBox(height: sizedHeight,),
             Expanded(
               child :
               ListView.builder(
                 itemCount: items.length,
                 itemBuilder: (context, index) {
                   return Container(
                     child: Column(
                       children: [
                         Hero(
                           tag: items[index]['full_name'],
                           child: ListTile(
                             title: Text(items[index]['full_name']),
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) =>
                                    DetailPage(items: items[index])),
                               );
                             },
                           ),
                         ),
                         Divider(thickness: 1),
                       ],
                     ),
                   );
                 },
               ),
             ),
           ],
         )) : SizedBox(height: 0),
        //レスポンスのstatusが200以外の時に表示される
        githubModel.isError ? SearchError()
            : SizedBox(height: 0,),
      ],
    );
  }
}