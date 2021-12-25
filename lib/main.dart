import 'package:flutter/material.dart';
import 'package:hive_basics/login_list.dart';
import 'package:hive_basics/login_model.dart';
import 'package:hive_basics/themes/theme_constants.dart';
import 'package:hive_basics/themes/theme_manager.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LoginDetailsAdapter());

  await Hive.openBox('loginInfo');
  await Hive.openBox('themeInfo');
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Box themeBox;
  @override
  void initState() {
    super.initState();
    themeManager.addListener(() {
      setState(() {});
    });
    themeBox = Hive.box('themeInfo');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTHeme,
      themeMode: themeBox.get('isDark') ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomeApp(),
      routes: {'/login_details': (_) => const LoginList()},
    );
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  late final Box box, themeBox;

  @override
  void initState() {
    super.initState();
    box = Hive.box('loginInfo');
    themeBox = Hive.box('themeInfo');
  }

  @override
  void dispose() {
    Hive.close();

    // Hive.box('loginDetails').close();
    super.dispose();
  }

  void addLoginInfo(String name, String password) {
    final loginDetail = LoginDetails(name, password);

    box.add(loginDetail);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor:
                      themeBox.get('isDark') ? Colors.white38 : Colors.black12,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          themeManager.toggleTheme();
                          themeBox.put('isDark', themeManager.isDark);
                        });
                      },
                      icon: themeManager.isDark
                          ? const Icon(
                              Icons.brightness_5_rounded,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.brightness_3,
                              color: Colors.black,
                            )),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  'https://ouch-cdn2.icons8.com/b-f3FVCtUgTqXejtpfRaK-uWXAEgjnCUCbw9oncLwCU/rs:fit:196:192/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: Icon(
                      Icons.person,
                      color:
                          themeBox.get('isDark') ? Colors.white : Colors.black,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(
                      Icons.vpn_key_rounded,
                      color:
                          themeBox.get('isDark') ? Colors.white : Colors.black,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => addLoginInfo(
                        nameController.text, passwordController.text),
                    child: const Text('Login'),
                    style: themeBox.get('isDark')
                        ? ElevatedButton.styleFrom(
                            onPrimary: Colors.black, primary: Colors.white)
                        : ElevatedButton.styleFrom(
                            primary: Colors.black, onPrimary: Colors.white),
                  )),
              const SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login_details');
                    },
                    child: const Text(
                      'Show details',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
