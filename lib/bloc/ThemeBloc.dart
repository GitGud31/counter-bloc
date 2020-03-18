import 'package:counter_bloc/util/ThemeEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeData>{

  @override
  ThemeData get initialState => ThemeData.light();

  @override
  Stream<ThemeData> mapEventToState(event) async*{
    switch(event){
      case ThemeEvents.toggle:
        yield state == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
        break;
    }
  }

}