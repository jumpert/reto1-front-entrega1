import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  fetchData() async {
    var url;
    url = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US"));
    return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 50, 56),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'APP Reto I',
            style: TextStyle(
                fontSize: 25.0, color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,
          ),
          elevation: 0.0,
          backgroundColor: Color(0xff191826),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 100, right: 100),
          child: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Container(
                            height: 250,
                            margin: EdgeInsets.all(40),
                            alignment: Alignment.centerLeft,
                            child: Card(
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w500" +
                                      snapshot.data[index]['poster_path']),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data[index]["original_title"],
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data[index]["release_date"],
                                    style: TextStyle(color: Color(0xff868597)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 100,
                                    child: Text(
                                      snapshot.data[index]["overview"],
                                      style:
                                          TextStyle(color: Color(0xff868597)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }
}
