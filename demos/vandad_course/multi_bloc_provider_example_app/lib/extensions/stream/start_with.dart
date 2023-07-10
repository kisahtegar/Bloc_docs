import 'package:async/async.dart' show StreamGroup;

extension StartWith<T> on Stream<T> {
  // x means elements,
  // - means loading

  /*
  this before:    | ------------- X ------------- X
  Stream.value:   | X |
  result of merge:| X ----------- X ------------- X 
  */

  // We want a stream that immediatly produces a value and then continues as
  // long as the other stream which is this continues. so user doesn't wait
  // loading to get elements (images).

  Stream<T> startWith(T value) => StreamGroup.merge(
        [
          this,
          Stream<T>.value(value),
        ],
      );
}
