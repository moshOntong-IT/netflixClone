import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import 'package:flutter_netflix_responsive_ui/screen/screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/widgets/content_header.dart';
import 'package:flutter_netflix_responsive_ui/widgets/content_list.dart';
import 'package:flutter_netflix_responsive_ui/widgets/custom_app_bar.dart';
import 'package:flutter_netflix_responsive_ui/widgets/previews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffSet(_scrollController.offset);
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true, //to extend the body of featured content
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 60),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffSet) {
            return CustomAppBar(
              scrollOffSet: scrollOffSet,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey[850],
        child: Icon(Icons.cast),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: ContentList(
            key: PageStorageKey('myList'),
            title: 'My List',
            contentList: myList,
          )),
          SliverToBoxAdapter(
              key: PageStorageKey('originals'),
              child: ContentList(
                title: 'Netflix Original',
                contentList: originals,
                isOriginals: true,
              )),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
                child: ContentList(
              key: PageStorageKey('trending'),
              title: 'Trending',
              contentList: trending,
            )),
          ),
        ],
      ),
    );
  }
}
