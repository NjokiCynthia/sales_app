import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.all(10),
                        color: Colors.green[700],
                        child: Center(
                          child: Text('Card $index'),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
