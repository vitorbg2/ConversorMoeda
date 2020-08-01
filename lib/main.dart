import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in8/data/providers/conversao_provider.dart';
import 'package:in8/data/repositories/conversao_repository.dart';
import 'package:in8/ui/screens/login_screen.dart';

import 'data/bloc/conversao_bloc/conversao_bloc.dart';

void main() {
  final ConversaoProvider conversaoProvider = ConversaoProvider();
  final ConversaoRepository conversaoRepository =
      ConversaoRepository(conversaoProvider: conversaoProvider);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<ConversaoBloc>(
      create: (context) =>
          ConversaoBloc(conversaoRepository: conversaoRepository),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
