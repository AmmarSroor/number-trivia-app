import 'package:first_project/features/number_trivia/presentation/numberTriviaBloc/number_trivia_bloc.dart';
import 'package:first_project/features/number_trivia/presentation/widgets/loading_indicator.dart';
import 'package:first_project/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:first_project/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:first_project/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:first_project/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (ctx)=> service_locator<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              BlocBuilder<NumberTriviaBloc,NumberTriviaState>(
                builder: (innerContext ,state) {
                  if(state is Empty){
                    return MessageDisplay(message: 'Start searching ^.^',);
                  } else if(state is Loading){
                    return LoadingIndicator();
                  } else if(state is Loaded){
                    return TriviaDisplay(numberTrivia: state.trivia,);
                  } else if(state is Error){
                    return MessageDisplay(message: state.message,);
                  } else
                    return Center(
                      child: Text('Unexpected State'),
                    );
                },
              ),

              SizedBox(
                height: 20,
              ),
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }

}
