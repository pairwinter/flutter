import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int count = 0;

  BehaviorSubject<int> _behaviorSubject;

  CounterBloc(this.count) {
    _behaviorSubject = BehaviorSubject<int>.seeded(this.count);
  }

  Observable<int> get counterObserve => _behaviorSubject.stream;

  void increment() {
    count += 50;
    _behaviorSubject.sink.add(count);
  }

  void decrement() {
    count -= 50;
    _behaviorSubject.sink.add(count);
  }

  void dispose() {
    _behaviorSubject.close();
  }
}
