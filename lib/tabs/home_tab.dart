import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBackground() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
    );

    Widget _buildAppBar() => SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Novidades'),
        centerTitle: true,
      ),
    );

    Widget _buildProgressIndicator() =>  SliverToBoxAdapter(
      child: Container(
        height: 200.0,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );

    Widget _buildGrid(List<DocumentSnapshot> documents) => SliverStaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      staggeredTiles: documents.map((document) => StaggeredTile.count(document.data['x'], document.data['y'])).toList(),
      children: documents.map((document) => FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: document.data['image'],
          fit: BoxFit.cover,
        ),
      ).toList(),
    );
    
    return Stack(
      children: <Widget>[
        _buildBodyBackground(),
        CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection('home').orderBy('position').getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return _buildProgressIndicator();
                else return _buildGrid(snapshot.data.documents);
              },
            ),
          ],
        ),
      ],
    );
  }
}
