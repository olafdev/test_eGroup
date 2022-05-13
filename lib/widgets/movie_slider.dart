import 'package:testforegroup/models/models.dart';
import 'package:testforegroup/providers/movie_provider.dart';
import 'package:testforegroup/routes/routes.dart';
import 'package:provider/provider.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider({Key? key, required this.movies, this.title, required this.onNextPage}) : super(key: key);

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  late ScrollController scrollController = ScrollController();

  int flag = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent - 600) {
        flag++;
        if (flag == 1) widget.onNextPage();
      } else {
        flag = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width,
      height: size.height-80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16),
              child: Text(widget.title!, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
            ),

          Flexible(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, int index) => _MoviePoster(
                movie: widget.movies[index],
                title: widget.title ?? 'undefined',
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({Key? key, required this.movie, required this.title, required this.index}) : super(key: key);

  final Movie movie;
  final String title;
  final int index;


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    movie.heroId = '$title-${movie.id}-$index-${movie.id - index}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery. of(context).size.width,
      child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, DetailsScreen.routeName, arguments: movie),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textTheme.headline5,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      movie.overview,
                      style: textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
