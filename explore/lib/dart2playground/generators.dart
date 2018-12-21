Iterable<int> naturalsTo(n) sync* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

Iterable<int> naturalsDownFrom(n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

Stream<int> asynchronousNaturalsTo(n) async* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

void main() {
  for (int value in naturalsTo(10)) {
    print(value);
  }

  var stream = asynchronousNaturalsTo(10);
  stream.listen((event) {
    print('stream => $event');
  });

  for (int value in naturalsDownFrom(5)) {
    print(value);
  }
}
