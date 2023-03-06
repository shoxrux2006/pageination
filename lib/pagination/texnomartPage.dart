import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pageination/pagination/bloc/texnomart/texnomart_bloc.dart';
import 'package:pageination/pagination/data/texnomartData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TexnomartPage extends StatefulWidget {
  const TexnomartPage({Key? key}) : super(key: key);

  @override
  State<TexnomartPage> createState() => _TexnomartPageState();
}

class _TexnomartPageState extends State<TexnomartPage> {
  final bloc = TexnomartBloc();
  final controller = RefreshController();
  final textController = TextEditingController();

  @override
  void initState() {
    bloc.add(TexnomartInitEvent(""));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<TexnomartBloc, TexnomartState>(
        listener: (context, state) {
          textController.addListener(() {
            EasyDebounce.debounce(
                'my-debouncer', const Duration(milliseconds: 300), () async {
              bloc.add(TexnomartSearchEvent(textController.text));
            });
          });
          if (state.status == Status.success) {
            controller.refreshCompleted();
            controller.loadComplete();
          }
        },
        builder: (context, state) {
          return Container(
              color: Colors.grey[300],
              child: SafeArea(
                bottom: false,
                child: Scaffold(
                  appBar: AppBar(
                    title: TextField(
                      controller: textController,
                      decoration: InputDecoration(icon: Icon(Icons.search)),
                    ),
                  ),
                  body: SmartRefresher(
                      controller: controller,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () => bloc.add(TexnomartInitEvent(textController.text)),
                      onLoading: () => bloc
                          .add(TexnomartNextEvent(text: textController.text)),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductItem(state.products[index]);
                          })),
                ),
              ));
        },
      ),
    );
  }

  Widget ProductItem(Item product) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(children: [
              CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: "https://backend.texnomart.uz/${product.image}"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(color: Colors.purple),
                child: Text(
                  "",
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar.builder(
            initialRating: product.reviewsMiddleRate.toDouble(),
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 20,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
          Center(
              child: Text(
            product.fSalePrice,
            style: TextStyle(color: Colors.black, fontSize: 15),
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            product.axiomMonthlyPrice,
            style: TextStyle(color: Colors.black, fontSize: 15),
          )),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Kupit",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
