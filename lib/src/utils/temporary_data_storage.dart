import 'package:rxdart/rxdart.dart';

// Temporary storage for data that is not persisted across app restarts.
// This is used to store data that is needed to be accessible across different
// screens of the app.
class TemporaryStorage<T> {
  TemporaryStorage(T initial) : _subject = BehaviorSubject.seeded(initial);

  // BehaviorSubject holds the data.
  final BehaviorSubject<T> _subject;

  // Output stream that is used to listen to the data.
  Stream<T> get stream => _subject.stream;

  // Synchronous getter for the current value.
  T get value => _subject.value;

  // Setter for updating the value
  set value(T value) => _subject.add(value);

  // Dispose the stream.
  void dispose() => _subject.close();
}
