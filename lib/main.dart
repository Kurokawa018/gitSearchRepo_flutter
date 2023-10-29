import 'package:flutter/material.dart';

//models
import 'model/API_model.dart';

//views
import 'views/details_page.dart';

//constants
import '../constants/doubles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ゆめみ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const MyHomePage(title: 'ゆめみ　Flutter課題'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  List<dynamic> _items = [];

  void _search() async {

    var client = new GithubModel();
    var result = await client.get(_controller.text);
    setState(() {
      //nullチェック
      _items = result!;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontSize: titleFontSize),),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a keyword',
                ),
                controller: _controller,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _search,
                child: Text('Search'),
              ),
              SizedBox(height: 20),
              _items.length == 0 ? Text("No results found.",textAlign: TextAlign.left, style: TextStyle(fontSize: titleFontSize)):
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('Search Results', textAlign: TextAlign.left, style: TextStyle(fontSize: titleFontSize), ),
                  ]
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Hero(
                            tag: _items[index]['full_name'],
                            child: ListTile(
                              title: Text(_items[index]['full_name']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailPage(item: _items[index])),
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
          ),
        )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
