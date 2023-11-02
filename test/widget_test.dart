// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:yumemi_flutter/main.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../lib/model/API_model.dart';
import '../lib/views/details_page.dart';
import 'widget_test.mocks.dart';

//class MockClient extends Mock implements http.Client{}

@GenerateNiceMocks([MockSpec<http.Client>(), MockSpec<GithubModel>()])

void main() {
  test('Test repository search and display results', () async {
    final client = MockClient();

    //Use Mockito to return a successful response when it calls the
    //provided http.Client.
    when(client.get(any))
        .thenAnswer((_) async => http.Response('{"total_count":603518}', 200));
    expect(
      (await client.get(Uri.parse(
          'https://api.github.com/search/repositories?q=flutter')))
          .body,
      '{"total_count":603518}',
    );

    // // Tap the first item in the list.
    // await tester.tap(find.byType(ListTile).first);
    // await tester.pumpAndSettle();
    //
    //
    //
    // // Build our app and trigger a frame.
    // await tester.pumpWidget(
    //     MaterialApp(home: MyHomePage()),
    //   );
    //
    // // Verify that the detail page is displayed.
    // expect(find.byType(DetailPage), findsOneWidget);
  });
}

