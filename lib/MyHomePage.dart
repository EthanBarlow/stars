import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:picture_of_the_day/FullScreenImagePage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const _radius = 50.0;
const _dateFontSize = 30.0;
const _explanationFontSize = 16.0;
const _textInset = 20.0;
const _iconSize = 24.0;

class _MyHomePageState extends State<MyHomePage> {
  String apiKey = "api";
  String explanation =
      "Who knows what evil lurks in the eyes of galaxies? The Hubble knows -- or in the case of spiral galaxy M64 -- is helping to find out. Messier 64, also known as the Evil Eye or Sleeping Beauty Galaxy, may seem to have evil in its eye because all of its stars rotate in the same direction as the interstellar gas in the galaxy's central region, but in the opposite direction in the outer regions. Captured here in great detail by the Earth-orbiting Hubble Space Telescope, enormous dust clouds obscure the near-side of M64's central region, which are laced with the telltale reddish glow of hydrogen associated with star formation.  M64 lies about 17 million light years away, meaning that the light we see from it today left when the last common ancestor between humans and chimpanzees roamed the Earth.  The dusty eye and bizarre rotation are likely the result of a billion-year-old merger of two different galaxies.";
  final imageUrl =
      'https://apod.nasa.gov/apod/image/2103/M8_HLA_F125wF160w_Nachman.jpg';
  void main() async {
    await DotEnv.load();
    apiKey = DotEnv.env['API_KEY'];
    print(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    main();
    return Scaffold(
      body: SafeArea(
              child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight / 2.0,
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, _explanationFontSize * 3),
                child: Container(
                  color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today, size: _iconSize,),
                          onPressed: () {
                            print('calendar');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share, size: _iconSize),
                          onPressed: () {
                            print('sharing');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.download_rounded, size: _iconSize,),
                          onPressed: () {
                            print('download');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenImagePage(imageUrl: this.imageUrl),
                      ),
                    )
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(widget.title),
              // actions: [
              //   IconButton(
              //     icon: Icon(Icons.refresh),
              //     onPressed: () {
              //       print('refreshing');
              //     },
              //   ),
              // ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: _textInset, left: _textInset, right: _textInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                      width: double.infinity,
                    ),
                    Text(
                      'Title of photo',
                      style: TextStyle(
                        fontSize: _dateFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                      width: double.infinity,
                    ),
                    Text(
                      'March 29, 2021',
                      style: TextStyle(fontSize: _dateFontSize / 1.2),
                    ),
                    SizedBox(
                      height: 15.0,
                      width: double.infinity,
                    ),
                    Text(
                      explanation,
                      style: TextStyle(
                        fontSize: _explanationFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
