import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pageination/pagination/data/leBazarData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/pagination_bloc.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  final bloc = PaginationBloc();
  final controller = RefreshController();
  final textController = TextEditingController();

  @override
  void initState() {
    bloc.add(PaginationInitEvent());
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
    final children = <Widget>[];
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<PaginationBloc, PaginationState>(
        listener: (context, state) {
          textController.addListener(() {
            EasyDebounce.debounce(
                'my-debouncer', const Duration(milliseconds: 300), () async {
              bloc.add(PaginationSearchEvent(textController.text));
            });
          });
          if (state.status == Status.success) {
            controller.refreshCompleted();
            controller.loadComplete();
          }
        },
        builder: (context, state) {
          children.clear();
          for (int i = 0; i < state.products.length; i++) {
            children.add(ProductItem(state.products[i]));
          }
          return Container(
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
                          onRefresh: () => bloc.add(PaginationInitEvent()),
                          onLoading: () => bloc.add(
                              PaginationNextEvent(text: textController.text)),
                          child:GridView.builder(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: state.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductItem(state.products[index]);
                              })
                      ))));
        },
      ),
    );
  }

  Widget ProductItem(LeBazarData product) {
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
                  imageUrl:
                      "https://web.lebazar.uz/${product.images[0].mediumUrl}"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.yellow),
                child: Text(
                  product.price.toString(),
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Color(0xffe7e9e8),
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
