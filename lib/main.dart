import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  //Clase a la qual cridam el nostre provider.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //
      providers: [
        ChangeNotifierProvider(
          create: ((_) =>
              MoviesProvider()), //Cream la instacia del nostre provider.
          lazy: false,
        )
      ],
      child: MyApp(), //Criam myApp ja que sino no funcionaria correctament.
    );
  }
}

// Clase principal la qual tenim la primera ruta que s'iniciara.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pel·lícules',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'details': (BuildContext context) => DetailsScreen()
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
