import 'package:apitest/wigets/article_container.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apitest/models/article.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: SearchScreen(),
  );
}

class SearchScreen extends HookWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = useState<List<Article>>([]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter a search term',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value);
                result.value = results;
                debugPrint(result.value.toString());
              },
            ),
            Expanded(
                child: ListView(
              children: result.value
                  .map(
                    (article) => ArticleContainer(article: article),
                  )
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': keyword, // キーワードの検索クエリ
      'per_page': '10',
    });
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    try {
      final http.Response res = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      });

      if (res.statusCode == 200) {
        final List<dynamic> body = jsonDecode(res.body);
        return body.map((dynamic json) => Article.fromJson(json)).toList();
      } else {
        // エラー処理
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      // エラーハンドリング
      // 実際のアプリではここでエラーメッセージを表示するなどの処理を追加します。
      return [];
    }
  }
}
