import 'package:first_project/features/number_trivia/presentation/numberTriviaBloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key? key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  TextEditingController _controller = TextEditingController();
  String inputString = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Input a number'),
          onChanged: (value) {
            inputString = value;
          },
          onSubmitted: (_){
            dispatchConcreteTrivia();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text('Search'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor,
                  ),
                ),
                onPressed: dispatchConcreteTrivia,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton(
                child: Text('get random trivia'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor,
                  ),
                ),
                onPressed: dispatchRandomTrivia,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchConcreteTrivia() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetConcreteNumberTriviaEvent(inputString),
    );
  }

  void dispatchRandomTrivia() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetRandomNumberTriviaEvent(),
    );
  }
}
