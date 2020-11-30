import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print('bloc error!');
    print(error);
    super.onError(cubit, error, stackTrace);
  }
  // @override
  // void onTransition(Transition transition) {
  //   print(transition);
  // }
  //
  // @override
  // void onError(Object error, StackTrace stacktrace) {
  //   print(error);
  // }
}
