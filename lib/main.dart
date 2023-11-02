//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

//models
import 'model/API_model.dart';

//components
import 'components/search_results.dart';


//views
import 'views/details_page.dart';

//constants
import '../constants/doubles.dart';
import '../constants/strings.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ゆめみ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        //↓ハロウィン仕様のテーマ↓//
        //primarySwatch: Colors.orange,
        //textTheme: GoogleFonts.emilysCandyTextTheme(),
        //scaffoldBackgroundColor: Colors.orange[100],

        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {

  final _controller = TextEditingController();
  List<dynamic> _items = [];
  bool  isLoading = false;
  String query = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GithubModel githubModel = ref.watch(githubProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appTitle, style: TextStyle(fontSize: titleFontSize),),
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                  controller: _controller,
                  onChanged: (text) {
                    //テキストフィールドの文字が変更になった際にUIを変更する
                    githubModel.onChanged();
                    query = text;
                  },
                ),
                SizedBox(height: sizedHeight),
                ElevatedButton(
                  onPressed: () async {
                    //gitHubモデルのsearch起動
                    await githubModel.search(query);
                    _items = githubModel.items;
                  },
                    child: Text(buttonText),
                    ),
                SizedBox(height: sizedHeight),
                Expanded(child: SearchResultBuilder(githubModel: githubModel, items: _items)),
                  ],
                ),
              )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
