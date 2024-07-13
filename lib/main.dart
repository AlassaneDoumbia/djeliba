import 'package:djeliba/models/auth_data.model.dart';
import 'package:djeliba/router.dart';
import 'package:djeliba/router_generator.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/services/base.service.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:djeliba/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  final storageService = locator<SecureStorageService>();
  AuthData authData = await storageService.getAuthData();
  // define the initial route based on whether the user is logged in or not
  String initialRoute = (authData != null && authData.accessToken != null) ? '/home' : '/login';
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('fr', 'FR'), Locale('en', 'US'), Locale('de', 'DE')],
        path: 'assets/i18n', // <-- change the path of the translation files
        fallbackLocale: const Locale('fr', 'FR'),
        child: MyApp(initialRoute: initialRoute,)
    ),
    // Text('title').tr() //Text widget
    // print('title'.tr()); //String
    // var title = tr('title') //Static function
    // Text(context.tr('title')) //Extension on BuildContex
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({super.key, required this.initialRoute});

  // final HttpLink httpLink = HttpLink("https://YOUR_GRAPHQL_URL");

  // final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  //     GraphQLClient(
  //       link: HttpLink("https://lol-api-dev.herokuapp.com/graphql"),
  //       cache: GraphQLCache(),
  //     ),
  // );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      // client: client,
      client: locator<BaseService>().clientNotifier,
      child: ChangeNotifierProvider.value(
        value: locator<AuthService>(),
        child: MaterialApp(
          title: 'title'.tr(),
          theme: ThemeData(
            // This is the theme of your application.
            //
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: initialRoute,
          onGenerateRoute:RouteGenerator.generateRoute ,
          // home: const home: const LoginView(),
          // home: const LoginScreen(),
          // routes: routers,
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      )


    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(tr('welcome')+ widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
