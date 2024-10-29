import 'package:fitdemo/fitGoalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<FitDemoProvider>(
      create: (_) => FitDemoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  double _value = 0.0;

  final List<Map<String,dynamic>> _scores =[
    {"name": "Person1", "pushup": 29},
    { "name": "Team2", "pushup": 40},
    { "name": "Person2", "pushup": 5},
    {"name": "Team 2", "pushup": 35},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Team Fit App"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Team Manager",
                ),
                Tab(
                  text: "Team Members",
                )
              ],
            ),
          ),
          body: Consumer<FitDemoProvider>(
            builder: (context, provider, child) {
              return TabBarView(
                children: [
                  Tab(
                      child: leaderBoad(context, provider)),
                  Tab(
                    child: Text("Team Members"),
                  )
                ],
              );
            },
          )),
    );
  }


  Widget leaderBoad(BuildContext context, FitDemoProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width *0.50,
                  child: Slider(
                      min: 0.0,
                      max: 100.0,
                      label: _value.round().toString(),
                      value: _value,
                      onChanged: (double newValue) {
                        setState(() {
                          _value = newValue;
                        });
                        goal(_value.toInt());
                      }),
                ),
                TextButton(
                  child: Text("${_value.round().toString()}  pushups"),
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Goal is set")));
                  },
                ),
              ],
            )),
         Container(
           height: MediaQuery.sizeOf(context).height *0.50,
           child: ListView.builder(itemCount: _scores.length.toInt(),
              itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  leading: Text(_scores[index]["name"].toString()),
                  trailing: Text(_scores[index]["pushup"].toString()),
                ),
              );
              },
                   ),
         )

      ],
    );
  }
  Iterable<Map<String, dynamic>> goal(int value){
    print(value);
    var result =_scores.where((mem) => mem["pushup"] > value);
    return result;
  }
}
