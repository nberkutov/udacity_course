import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _backgroundColor = Color.fromRGBO(250, 250, 250, 1);
final _padding = 15.0;

class HomePage extends StatelessWidget {
  final appBar = AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {},
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ],
    elevation: 2,
    backgroundColor: _backgroundColor,
    title: Text(
      'Альбом',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: _padding, vertical: 10.0),
              height: 180.0,
              child: Row(
                children: [
                  Container(
                    width: 160.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.purple[100],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Author',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          Text(
                            'Хип-хоп, 2020',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.0,
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.red[100],
                              child: Text(
                                'ДОБАВЛЕН',
                                style: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: List.generate(7, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('${index + 1}'),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Track ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Author',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.file_download),
                                  Icon(Icons.more_vert),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Container(
              //padding: EdgeInsets.all(_padding),
              width: double.infinity,
              height: 290,
              color: Colors.black12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(_padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Другие альбомы',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 230,
                    child: ListView(
                      padding: EdgeInsets.all(_padding),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(10, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Title',
                            ),
                            Text(
                              'Author',
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 12.0,
                                  color: Colors.black54),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
