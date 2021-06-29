import 'package:flutter/material.dart';
import 'package:flutter_shimmer_animation/custom_widget.dart';
import 'package:flutter_shimmer_animation/data/movie_data.dart';
import 'package:flutter_shimmer_animation/model/movie_model.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieModel> movies = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    movies = List.of(allMovies);
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text("Shimmer Animation Effect"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: loadData)
        ],
      ),
      body: ListView.builder(
          itemCount: isLoading? 5: movies.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return buildMovieShimmer();
            } else {
              final movie = movies[index];
              return buildMovieList(movie);
            }
          }
      ),

    );
  }

  Widget buildMovieList(MovieModel model) =>
      ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(model.urlImg),
        ),
        title: Text(model.title, style: TextStyle(fontSize: 16),),
        subtitle: Text(
          model.detail, style: TextStyle(fontSize: 14), maxLines: 1,),
      );

  Widget buildMovieShimmer() =>
      ListTile(
        leading: CustomWidget.circular(height: 64, width: 64),
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomWidget.rectangular(height: 16,
            width: MediaQuery.of(context).size.width*0.3,),
        ),
        subtitle: CustomWidget.rectangular(height: 14),
      );

}