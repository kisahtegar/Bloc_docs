import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_actions.dart';
import 'person.dart';

// Define equality on Iterable<T>
extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

/// Define the result of the bloc.
@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrievedFromCache = $isRetrievedFromCache, persons = $persons)';

  // Adding fetch results with equality and hashCode.
  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetrievedFromCache,
      );
}

/// Write the bloc header.
class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  // We need a cache in the bloc.
  final Map<String, Iterable<Person>> _cache = {};

  // Write the bloc's constructor.
  PersonsBloc() : super(null) {
    // Handle the LoadPersonsAction in the constructor.
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;

        if (_cache.containsKey(url)) {
          // We have the value in the cache.
          final cachedPersons = _cache[url]!;
          final result = FetchResult(
            persons: cachedPersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          // We dont have the value in the cache.
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}
