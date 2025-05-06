import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../person.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  List<Person> lstpersons = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController= TextEditingController();

  PersonCubit() : super(PersonInitialState());

  void addPerson(String name, String address) {
    lstpersons.add(Person(name, address));
    nameController.clear();
    addressController.clear();
    emit(PersonUpdatedState(lstpersons));
  }

  void removePerson(int index) {
    lstpersons.removeAt(index);

    if (lstpersons.isEmpty) {
      emit(PersonInitialState());
    } else {
      emit(PersonUpdatedState(lstpersons));
    }
  }

  void dispose() {
    nameController.dispose();
    addressController.dispose();
  }
}
