import 'package:flutter/material.dart';
import 'package:apitest/models/article.dart';
import 'package:intl/intl.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            // ← 内側の余白を指定
            horizontal: 20,
            vertical: 80,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF55C500), // ← 背景色を指定
            borderRadius: BorderRadius.all(
              Radius.circular(32), // ← 角丸を設定
            ),
          ),
          child: const Column(
            children: [],
          ),
        ));
  }
}
