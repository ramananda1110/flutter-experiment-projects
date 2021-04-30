import 'package:bloc/bloc.dart';

void main() {

  /*Stream<int> data = boatStream();

//  print(data);

  data.listen((event) {
    print('Received boat no. ' + event.toString());
  });*/


  final cubit = CounterCubit();

  print(cubit.state);

  cubit.increment();

  print(cubit.state);


  cubit.increment();

  print(cubit.state);

  cubit.decrement();
  print(cubit.state);

  cubit.increment();
  cubit.increment();
  cubit.increment();
  print(cubit.state);


}

Stream<int> boatStream() async* {
  for (int i = 0; i < 10; i++) {
    print('SENT boat no. ' + i.toString());
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(10);

  void increment() => emit(state +1);
  void decrement() => emit(state -1);
}
