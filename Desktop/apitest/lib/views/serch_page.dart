import 'package:apitest/wigets/article_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apitest/models/article.dart';
import 'package:apitest/models/user.dart';

final searchProvider = StateProvider<String>((ref) => "");
final searchResultProvider = StateProvider<List<Article>>((ref) => []);

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: SearchScreen(),
  );
}

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);
    final searchResults = ref.watch(searchResultProvider);

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
                ref.read(searchResultProvider.notifier).state = results;
              },
            ),
            ArticleContainer(
              article: Article(
                title: '西岡優太の初恋の相手、ゆうこちゃんに徹底取材！彼のどこに惚れたのか！？',
                user: User(
                  id: 'test',
                  profileImageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/gs-expansion-test.appspot.com/o/unknown_person.png?alt=media',
                ),
                createdAt: DateTime.now(),
                tags: ['Flutter', 'dart'],
                url: 'https://example.com',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final article = searchResults[index];
                  return ListTile(
                    title: Text(article.title),
                    // 他の記事情報を表示...
                  );
                },
              ),
            ),
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
