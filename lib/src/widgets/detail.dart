import 'package:flutter/material.dart';
import 'package:nav2/src/shared/models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({@required this.book})
      : assert(book != null, 'book not found'),
        super(key: Key('${book.title}'));
  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      );
}
