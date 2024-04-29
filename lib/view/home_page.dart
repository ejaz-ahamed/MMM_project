import 'package:flutter/material.dart';
import 'package:mmm_project/core/provider/post_provider.dart';
import 'package:mmm_project/view/details_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Provider.of<PostProvider>(context, listen: false).fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Posts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<PostProvider>(context, listen: false).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = Provider.of<PostProvider>(context).posts;
            return ListView.builder(
              controller: scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (Provider.of<PostProvider>(context).isLast &&
                    index == posts.length) {
                  return const Center(
                    child: Text("No More data to Load"),
                  );
                }
                if (index == posts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            postId: posts[index].id,
                          ),
                        ));
                  },
                  leading: CircleAvatar(
                    child: Text(posts[index].id.toString()),
                  ),
                  title: Text(posts[index].title),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went Wrong .try again'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
