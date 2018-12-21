// https://www.dartlang.org/guides/language/language-tour#declaring-async-functions

Future checkVersion() async{
  var version = await 'te';
  return version;
}

void main(){
  checkVersion().then((version){
    print(version);
  });
}