import 'package:flutter/material.dart';
import 'package:mmm_project/core/provider/post_details_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final int postId;
  const DetailsPage({super.key, required this.postId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void dispose() {
    super.dispose();
    Provider.of<PostDetailsProvider>(context, listen: false).dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<PostDetailsProvider>(context, listen: false).clearComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post ${widget.postId}"),
      ),
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<PostDetailsProvider>(context, listen: false)
              .getPostDetails(widget.postId),
          Provider.of<PostDetailsProvider>(context, listen: false)
              .getComments(widget.postId),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final postDetails = Provider.of<PostDetailsProvider>(context).post;
            final comments = Provider.of<PostDetailsProvider>(context).comments;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      postDetails?.title ?? "",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      postDetails?.body ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    Text(
                      "Comments",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    ListView.builder(
                      itemCount: comments.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comments[index].email),
                            Text(comments[index].name),
                          ],
                        ),
                        subtitle: Text(comments[index].body),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
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
