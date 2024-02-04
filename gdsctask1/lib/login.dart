import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'),fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children:[
            Container(
              padding: const EdgeInsets.only(left: 35,top: 130),
              child: const Text(
                  'Welcome\nBack',
                  style: TextStyle(color: Colors.white, fontSize: 33),),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
              right: 35,
              left: 35),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                  const SizedBox(
                    height:30
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('sign in',
                      style:TextStyle(
                        fontSize: 27,fontWeight: FontWeight.w700
                      ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.arrow_forward)
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, 'register');

                        },
                        child:const Text(
                            'signup',
                            style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Colors.grey,
                      ),)),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, 'forgot');
                          },
                          child:const Text(
                            'Forgot Password',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.grey,
                            ),))

                    ],
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

