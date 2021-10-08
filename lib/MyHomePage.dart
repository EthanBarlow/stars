import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:picture_of_the_day/Api.dart';
import 'package:picture_of_the_day/FullScreenImagePage.dart';
import 'package:picture_of_the_day/StarPicture.dart';

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

const tempJson = {
    "date": "2021-07-14",
    "explanation": "What happens when a black hole destroys a neutron star? Analyses indicate that just such an event created gravitational wave event GW200115, detected in 2020 January by LIGO and Virgo observatories. To better understand the unusual event, the featured visualization was created from a computer simulation. The visualization video starts with the black hole (about 6 times the Sun's mass) and neutron star (about 1.5 times the Sun's mass) circling each other, together emitting an increasing amount of gravitational radiation. The picturesque pattern of gravitational wave emission is shown in blue. The duo spiral together increasingly fast until the neutron star becomes completely absorbed by the black hole.  Since the neutron star did not break apart during the collision, little light escaped -- which matches the lack of an observed optical counterpart. The remaining black hole rings briefly, and as that dies down so do the emitted gravitational waves.  The 30-second time-lapse video may seem short, but it actually lasts about 1000 times longer than the real merger event.    Astrophysicists: Browse 2,500+ codes in the Astrophysics Source Code Library",
    "media_type": "video",
    "service_version": "v1",
    "title": "GW200115: Simulation of a Black Hole Merging with a Neutron Star",
    "url": "https://www.youtube.com/embed/V_Kd4YBNs7c?rel=0"
};

class _MyHomePageState extends State<MyHomePage> {
  String apiKey = "api";
  String explanation =
      "Who knows what evil lurks in the eyes of galaxies? The Hubble knows -- or in the case of spiral galaxy M64 -- is helping to find out. Messier 64, also known as the Evil Eye or Sleeping Beauty Galaxy, may seem to have evil in its eye because all of its stars rotate in the same direction as the interstellar gas in the galaxy's central region, but in the opposite direction in the outer regions. Captured here in great detail by the Earth-orbiting Hubble Space Telescope, enormous dust clouds obscure the near-side of M64's central region, which are laced with the telltale reddish glow of hydrogen associated with star formation.  M64 lies about 17 million light years away, meaning that the light we see from it today left when the last common ancestor between humans and chimpanzees roamed the Earth.  The dusty eye and bizarre rotation are likely the result of a billion-year-old merger of two different galaxies.";
  String _imageUrl =
      'https://apod.nasa.gov/apod/image/2103/M8_HLA_F125wF160w_Nachman.jpg';
  StarPicture _starPicture = StarPicture.fromJson(tempJson); 
  Future<StarPicture> futureStarPicture;
  ApiHelper helper = ApiHelper();
  // helper.
  void main() async {
    await DotEnv.load();
    apiKey = DotEnv.env['API_KEY'];
    print(apiKey);
  }

  @override
  void initState() {
    super.initState();
    futureStarPicture = helper.get(DateTime.now().subtract(new Duration(days: 2)));
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
                            FullScreenImagePage(imageUrl: this._imageUrl),
                      ),
                    )
                  },
                  child: Image.network(
                    _imageUrl,
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
              child: FutureBuilder<Object>(
                future: helper.get(DateTime.now().subtract(new Duration(days: 2))),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _starPicture = StarPicture.fromJson(snapshot.data);
                    this._imageUrl = _starPicture.hdUrl ?? _starPicture.url;
                  }
                  return Padding(
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
                          _starPicture.title,
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
                          _starPicture.returnedDate.toLocal().toString(),
                          style: TextStyle(fontSize: _dateFontSize / 1.2),
                        ),
                        SizedBox(
                          height: 15.0,
                          width: double.infinity,
                        ),
                        Text(
                          _starPicture.explanation,
                          style: TextStyle(
                            fontSize: _explanationFontSize,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
