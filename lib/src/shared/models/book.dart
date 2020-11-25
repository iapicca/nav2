import 'package:meta/meta.dart';

class Book {
  const Book({
    @required this.title,
    @required this.author,
  });
  final String title;
  final String author;
}
