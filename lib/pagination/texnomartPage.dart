import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pageination/pagination/bloc/texnomart/texnomart_bloc.dart';
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
    bloc.add(TexnomartInitEvent());
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
                  onRefresh: () => bloc.add(TexnomartInitEvent()),
                  onLoading: () =>
                      bloc.add(TexnomartNextEvent(text: textController.text)),
                  child: ListView.separated(
                    itemCount: state.products.length,
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.grey[300],
                        child: Text(
                          state.products[i].name,
                          style: const TextStyle(fontSize: 32),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
