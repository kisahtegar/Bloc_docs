import 'package:flutter/material.dart';

// This extension turn Iterable<Note> into a list view.
extension ToListView<T> on Iterable<T> {
  Widget toListView() => IterableListView(iterable: this);
}

// This widget showing a list view of Iterable.
class IterableListView<T> extends StatelessWidget {
  final Iterable<T> iterable;

  const IterableListView({
    Key? key,
    required this.iterable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            iterable.elementAt(index).toString(),
          ),
        );
      },
    );
  }
}
