void main() {
  print((3 << 2));
  print((3 << 4));
  var s = r'In a raw string, not even \n gets special treatment.';
  print(s);

  var s1 = '''
  test1
  test2
  ''';
  print(s1);

  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };
  print(gifts['first']);

  var nobleGases = {2: 'Helium', 10: 'neon'};
  print(nobleGases[2]);

  var clapping = '\u{1f44f}';
  print(clapping);
  print(clapping.codeUnits);
  print(clapping.runes.toList());

  Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));

  bool isEven(int number) => number > 0 && number % 2 == 0;

  print(isEven(4));

  bool isOdd({int number = 1}) => number > 0 && number % 2 == 1;
  print(isOdd());
  print(isOdd(number: 7));

  // Functions as first-class objects
  print('------------ Functions as first-class objects ------------');
  void printElement(int number) {
    print(number);
  }

  var list = [2, 5, 8];
  list.forEach(printElement);

  // Lexical closures
  Function makeAdder(num addBy) {
    return (num i) => print(addBy + i);
  }

  var add2 = makeAdder(2);
  var add4 = makeAdder(4);

  add2(8);
  add4(10);

  String playerName(String name) => name ?? 'Guest';
  print(playerName(null));
  print(playerName('Damon'));

  Point p0 = Point.origin();
  print(p0.x);

  Point greenPoint = GreenPoint(x: 1, y: 2);
  print(greenPoint.x);

  Point redPoint = RedPoint.fromJson({
    'x': 5,
    'y': 6,
  });
  print(redPoint.x);

  Point redPoint2 = RedPoint.fromJson2({
    'x': 11,
    'y': 12,
  });
  print(redPoint2.x);

  print(ImmutablePoint.origin.x);
}
// Classes
class Point {
  num x, y;
  Point(num x, num y) {
    this.x = x;
    this.y = y;
    print('Point: (${this.x}, ${this.y})');
  }

  Point.fromJson(Map data){
    this.x = data['x'];
    this.y = data['y'];
    print('Point From JSON: (${this.x}, ${this.y})');
  }

  Point.origin() {
    x = 0;
    y = 0;
  }
}

class GreenPoint extends Point {
  GreenPoint({x, y}) : super(x, y) {
    this.x = x * 10;
    this.y = y * 10;
    print('Green Point: (${this.x}, ${this.y})');
  }
}

class RedPoint extends Point {
  RedPoint.fromJson(Map data) : super(data['x'], data['y']) {
    this.x = data['x'] * 100;
    this.y = data['y'] * 100;
    print('Red Point: (${this.x}, ${this.y})');
  }

  RedPoint.fromJson2(Map data) : super.fromJson(data) {
    this.x = data['x'] * 100;
    this.y = data['y'] * 100;
    print('Red Point: (${this.x}, ${this.y})');
  }
}

class ImmutablePoint {
  final num x, y;
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);
  const ImmutablePoint(this.x, this.y);
}


