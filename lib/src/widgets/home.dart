import 'package:flutter/material.dart';
import 'package:nav2/src/shared/collections/books.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen() : super(key: const Key('HomeScreen'));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            for (var book in Books.LIST)
              ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                //onTap: () => onTapped(book),
                onTap: () {},
              )
          ],
        ),
      );
}
