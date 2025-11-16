import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tasspeh_state.dart';

class TasspehCubit extends Cubit<TasspehState> {
  TasspehCubit() : super(TasspehInitial());
  int counter = 0;
  static int index = 0;
  List<String> taspeeh = [
    'سُبْحَانَ اللَّهِ',
    'الْحَمْدُ لِلَّهِ',
    'اللَّهُ أَكْبَرُ',
  ];
  upCount() {
    if (counter == 33) {
      counter = 0;
      index == 2 ? index = 0 : index++;
    } else {
      counter++;
    }
    emit(TasspehCounterUp(count: counter, txt: taspeeh[index]));
  }

  void repeat() {
    counter = 0;
    index = 0;
    emit(TasspehCounterUp(count: counter, txt: taspeeh[index]));
  }
}
