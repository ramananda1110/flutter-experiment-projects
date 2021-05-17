import 'package:bloc_stream/constants/enums.dart';
import 'package:bloc_stream/logic/cubit/counter_cubit.dart';
import 'package:bloc_stream/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.bloc<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.bloc<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        key: homeScreenKey,
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (internetCubitBuilderContext, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.green,
                          ),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.red,
                          ),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.grey,
                          ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Divider(
                height: 24,
              ),
              Builder(
                builder: (context) {
                  final counterState = context.watch<CounterCubit>().state;
                  final internetState = context.watch<InternetCubit>().state;

                  if (internetState is InternetConnected &&
                      internetState.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Mobile',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else if (internetState is InternetConnected &&
                      internetState.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Wifi',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Disconnected',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    homeScreenKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    homeScreenKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: Text('${widget.title}'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: Text('${widget.title} 2nd'),
                    onPressed: () {
                      // BlocProvider.of<CounterCubit>(context).increment();
                      context.bloc<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/second',
                    arguments: homeScreenKey,
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/third',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
