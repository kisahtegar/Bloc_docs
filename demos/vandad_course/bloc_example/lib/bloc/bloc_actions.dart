import 'package:flutter/foundation.dart' show immutable;

import 'person.dart';

/// Url for persons.
const persons1Url =
    'http://127.0.0.1:3000/demos/vandad_course/bloc_example/api/persons1.json';
const persons2Url =
    'http://127.0.0.1:3000/demos/vandad_course/bloc_example/api/persons2.json';

// Type definitions for PersonsLoader
typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

/// We need an action.
@immutable
abstract class LoadAction {
  const LoadAction();
}

/// Define an action for loading persons.
@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;

  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
