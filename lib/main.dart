import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_counter_bloc/blocs/counter/counter_bloc.dart';
import 'package:my_counter_bloc/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      // BlocProvider 를 Global Access로 적용하여 CounterBloc을 생성
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Counter Bloc',
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Counter Bloc'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterBloc, CounterState>(
        // 단발성 Event 와 반복성 Event 처리를 위한 BlocConsumer
        listener: (context, state) {
          // listener 는 단발성 Event 처리
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  'Bloc Counter is ${state.counter}.',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            );
          } else if (state.counter <= -1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OtherPage()));
          }
        },
        builder: (context, state) {
          // builder 는 반복성 Event 처리
          return Center(
            child: Text(
              '${state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                  CounterIncresedEvent()); // CounterBloc 를 구해서 add( Event ) 호출
            },
            heroTag: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(
                  CounterDecresedEvent()); // CounterBloc 를 구해서 add( Event ) 호출
            },
            heroTag: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
