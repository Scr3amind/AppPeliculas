import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = "";

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Justice League',
    'Parasite',
    'Scooby doo'
  ];

  final peliculasRecientes = [
    'Scooby Doo',
    'Wonder Woman 1984',
    'Mulan'
    'Super Man'

  ];



  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de Appbar
    return[
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
         query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono izquierda de appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ),
      onPressed: () {
        close(
          context, 
          null
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se mostraran
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al escribir

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),

      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );

        }
      },
    );

  }

}