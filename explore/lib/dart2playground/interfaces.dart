class Person{
  final _name;
  Person(this._name);
  String greet(String who) => 'Hello $who. I am $_name.';
}

class Engineer implements Person{
  get _name => 'Engineer';
  String greet(String who) => 'Hello $who, I am $_name, an Engineer!';

}

String greetBob(Person person) => person.greet('Bob');

mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe(){
    if(canPlayPiano){
      print('Play Piano');
    } else if(canCompose){
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

class Musician extends Person with Musical{
  Musician(String name): super(name){
    this.canPlayPiano = true;
  }
}

void main() {
  Person person = Person('Damon');
  Engineer engineer = Engineer();
  print(greetBob(person));
  print(greetBob(engineer));

  Musician musician = Musician('God');
  print(musician.greet('People'));
  musician.entertainMe();
}

