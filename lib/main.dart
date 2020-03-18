import 'package:counter_bloc/bloc/CounterBloc.dart';
import 'package:counter_bloc/bloc/ThemeBloc.dart';
import 'package:counter_bloc/util/ThemeEvents.dart';
import 'package:counter_bloc/util/counterEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            theme: theme,
            title: 'Flutter Counter BLoC',
            /* Using the BlocProvider widget from flutter_bloc in order to make the instance of CounterBloc 
            available to the entire subtree (CounterPage). BlocProvider also handles closing the CounterBloc 
            automatically so we don't need to use a StatefulWidget. */
            home: BlocProvider(
              create: (context) => CounterBloc(),
              child: CounterPage(),
            ),
          );
        },
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    /*We can access the CounterBloc instance using 
     BlocProvider.of<CounterBloc>(context) since we wrapped 
     the CounterPage in a BlocProvider */

    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Counter BLoC',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                context.bloc<ThemeBloc>().add(ThemeEvents.toggle);
              },
              child: Icon(
                Icons.brightness_medium,
                color: Colors.white,
              )),
        ],
      ),
      body: BlocBuilder<CounterBloc, int>(builder: (context, count) {
        return Center(
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                counterBloc.add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                counterBloc.add(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
