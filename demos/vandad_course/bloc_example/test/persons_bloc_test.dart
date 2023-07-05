import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_example/bloc/bloc_actions.dart';
import 'package:bloc_example/bloc/persons_bloc.dart';
import 'package:bloc_example/bloc/person.dart';
import 'package:bloc_test/bloc_test.dart';

// Add 2 mocked Person Iterable.
const mockedPersons1 = [
  Person(
    age: 20,
    name: 'Foo',
  ),
  Person(
    age: 30,
    name: 'Bar',
  ),
];
const mockedPersons2 = [
  Person(
    age: 20,
    name: 'Foo',
  ),
  Person(
    age: 30,
    name: 'Bar',
  ),
];

// Define 2 mocked functions.
Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  // Write the group and the setUp() function.
  group(
    'Testing bloc',
    () {
      // Write our tests.
      late PersonsBloc bloc;

      // A bloc will be closed after every test and setUp() will be called / get
      // fresh bloc.
      setUp(() {
        bloc = PersonsBloc();
      });

      // Write test for the initial state of the bloc.
      blocTest<PersonsBloc, FetchResult?>(
        'Test initial state',
        build: () => bloc,
        // Verify the initial state, should be null to start it.
        verify: (bloc) => expect(bloc.state, null),
      );

      /// Write test for loading first batch of mocked persons.
      ///
      // fetch mock data (persons1) and compare it with FetchResult
      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons1,
            isRetrievedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPersons1,
            isRetrievedFromCache: true,
          ),
        ],
      );

      // fetch mock data (persons2) and compare it with FetchResult
      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons2,
            isRetrievedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPersons2,
            isRetrievedFromCache: true,
          ),
        ],
      );
    },
  );
}
