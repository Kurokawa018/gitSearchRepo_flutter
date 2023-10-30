// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_flutter/main.dart';
import '../lib/model/API_model.dart';
import '../lib/views/details_page.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('Test repository search and display results', (WidgetTester tester) async {
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get(Uri.parse('https://api.github.com/search/repositories?q=flutter')))
        .thenAnswer((_) async => http.Response('{"items": [{"full_name": "flutter/flutter"}]}', 200));

    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(home: MyHomePage()),
      );

    // Verify that the search field exists.
    expect(find.byType(TextField), findsOneWidget);

    // Enter 'flutter' into the TextField.
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pump();

    // Tap the search button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the API call is made and results are displayed.
    expect(find.byType(ListView), findsOneWidget);

    // Tap the first item in the list.
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify that the detail page is displayed.
    expect(find.byType(DetailPage), findsOneWidget);
  });
}

