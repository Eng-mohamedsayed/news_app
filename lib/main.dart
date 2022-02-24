import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/layouts/notizia_home_layout.dart';
import 'package:notizia/shared/network/remote/bloc_observer.dart';
import 'package:flutter/services.dart';
import 'package:notizia/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  //code code code



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NotiziaCubit()
         ),
      ],
      child: BlocConsumer<NotiziaCubit, NotiziaStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NotiziaCubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    color:Colors.black,
                    fontSize: 18

                  )
                ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    iconTheme: IconThemeData(color: Colors.black, size: 32),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                  )),
              darkTheme: ThemeData(
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(color: Colors.white, fontSize: 18)),
                  scaffoldBackgroundColor: const Color(0xFF292929),
                  appBarTheme: const AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xFF292929),
                        statusBarIconBrightness: Brightness.light),
                    iconTheme: IconThemeData(color: Colors.white, size: 32),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Color(0xFF292929),
                    elevation: 0.0,
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    unselectedItemColor: Colors.white,
                    backgroundColor: Color(0xFF292929),
                  )),
              themeMode:
                  cubit.isLight == true ? ThemeMode.light : ThemeMode.dark,
              home:  NotiziaLayout());
        },  
      ),
    );
  }
}
