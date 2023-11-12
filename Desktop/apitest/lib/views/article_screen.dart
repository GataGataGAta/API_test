import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apitest/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

// WebViewControllerのためのProviderを定義します。
final webViewControllerProvider =
    StateProvider<WebViewController?>((ref) => null);

class ArticleScreen extends ConsumerWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: WebView(
        initialUrl: article.url,
        onWebViewCreated: (WebViewController webViewController) {
          // Providerを介してWebViewControllerをセットします。
          ref.read(webViewControllerProvider.notifier).state =
              webViewController;
        },
        // WebViewの他の設定...
      ),
    );
  }
}
