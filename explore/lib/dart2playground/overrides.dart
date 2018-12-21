class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);

  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);
}

void main() {
  final v = Vector(5, 5);
  final w = Vector(2, 2);

  assert((v + w).x == Vector(7, 7).x);
  assert((v - w).x == Vector(3, 3).x);
}
