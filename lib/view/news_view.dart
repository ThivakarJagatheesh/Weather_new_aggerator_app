import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_aggregator_app/view_controller/news_view_controller.dart';

class NewsView extends ConsumerWidget {
  const NewsView({super.key, required this.express});
  final String express;

  @override
  Widget build(BuildContext context, ref) {
    final newsApiProvider = ref.watch(fetchProvider(express));
    return newsApiProvider.when(
        data: (news) => news.articles!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.articles?[index].author ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(news.articles?[index].title ?? "hello"),
                          InkWell(
                            child: const Text(
                              "view article",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            onTap: () async {
                              if (news.articles?[index].url != null) {
                                final Uri url =
                                    Uri.parse(news.articles?[index].url ?? '');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: news.articles?.length,
              )
            : const Center(
                child: Text("No Record Found.."),
              ),
        error: (object, stack) {
          debugPrint("object is $object");
          debugPrint("stack is $stack");
          return const Text("something went wrong!!!");
        },
        loading: () => const CircularProgressIndicator());
  }
}
