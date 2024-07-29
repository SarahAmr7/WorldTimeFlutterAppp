import 'package:flutter/material.dart';
import '';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data: ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgImage= data['isDaytime']? 'day.jpeg': 'night.jpeg';
    Color? bgColor= data['isDaytime']? Colors.teal[100]: Colors.indigo[900] ;
    Color textColor= data['isDaytime']? Colors.black: Colors.white;



    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                       dynamic result= await Navigator.pushNamed(context, '/location');
                       if(result!=null) {
                         setState(() {
                           data = {
                             'location': result['location'],
                             'flag': result['flag'],
                             'time': result['time'],
                             'isDaytime': result['isDaytime']
                           };
                         });
                       }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.edit_location,
                          color: textColor,),
                          Text(
                              'Edit Location',
                            style: TextStyle(
                              color: textColor
                            ),
                          )
                        ],
                      ),

                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: textColor
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      data['time'],
                  style: TextStyle(
                    fontSize: 66,
                    color: textColor
                  ),)


                ],
              ),
            ),
          )
      )
    );
  }
}
