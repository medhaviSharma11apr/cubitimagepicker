part of 'person_cubit.dart';

@immutable
class PersonState {
  const PersonState();
}

class PersonInitialState extends PersonState {

}


class PersonUpdatedState extends PersonState{
  final List<Person> persons;

  PersonUpdatedState(this.persons); 
}
