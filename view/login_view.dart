import 'package:flutter/material.dart';
import 'package:weather_news_aggregator_app/common/shared_storage.dart';
import 'package:weather_news_aggregator_app/view/dashboard_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
            key: loginKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                Image.asset(
                  'assets/images/weather-app-logo.png',
                  height: 150,
                  width: 150,
                ),
                TextFormField(
                  controller: usernameController,
                   decoration: const InputDecoration(
                    labelText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(15))
                    
                  ),
                ),
                  
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Fill the username";
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                 
                   decoration: const InputDecoration(
                    labelText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(15))
                  ),
                ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Fill the password";
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {});
                  },
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text("Forget password?"),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                    width: size.width * 0.75,
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (loginKey.currentState!.validate()) {
                            await SharedStorage.setString(
                                "username", usernameController.text);
                            if (context.mounted) {
                              var route = MaterialPageRoute(
                                  builder: (_) => const DashboardView());
                              Navigator.pushAndRemoveUntil(context, route,(r)=>false);
                            }
                          }
                        },
                        child: const Text("Login"))),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            )),
      )),
    );
  }
}
