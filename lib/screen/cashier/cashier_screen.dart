import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_bloc.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_event.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_state.dart';
import 'package:aplikasi_point_of_sales/core/models/list_product_model.dart';
import 'package:aplikasi_point_of_sales/core/repo/repositories.dart';
import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class CashierScreen extends StatelessWidget {
  const CashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListProductBloc>(
          create: (BuildContext context) =>
              ListProductBloc(ListProductRepository()),
        ),
      ],
      child: const CashierScreenContent(),
    );
  }
}

class CashierScreenContent extends StatefulWidget {
  const CashierScreenContent({Key? key}) : super(key: key);

  @override
  State<CashierScreenContent> createState() => _CashierScreenContentState();
}

class _CashierScreenContentState extends State<CashierScreenContent> {
  final TextEditingController _priceValue = TextEditingController();
  List<String> items = [];
  List<List> saveData = [];
  String priceInput = '';
  int? sumInput;
  String initialPriceValue = '';
  String? previousPriceValue;

  @override
  void dispose() {
    _priceValue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 14,
          child: Column(
            children: [
              _topMenu(
                title: 'Toko Bangunan Dua Putri',
                subTitle: '${DateTime.now()}',
                action: _search(),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => ListProductBloc(
                  ListProductRepository(),
                )..add(LoadListProductEvent()),
                child: BlocBuilder<ListProductBloc, ListProductState>(
                  builder: (context, state) {
                    if (state is ListProductLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ListProductErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    if (state is ListProductLoadedState) {
                      List<ListProductModel> listProduct = state.listProducts;
                      return Expanded(
                          child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: listProduct.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: _item(
                              image: 'assets/items/1.png',
                              title: '${listProduct[index].product}',
                              price:
                                  intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                                      .format(listProduct[index].price),
                              item: '${listProduct[index].description}',
                            ),
                          );
                        },
                      ));
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _topMenu(
                title: 'Pembelian',
                subTitle: 'Pembelian dapat disesuaikan dengan kebutuhan',
                action: Container(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _itemOrder(
                      image: 'assets/items/1.png',
                      title: 'Orginal Burger',
                      qty: '2',
                      price: '\$5.99',
                    ),
                    _itemOrder(
                      image: 'assets/items/2.png',
                      title: 'Double Burger',
                      qty: '3',
                      price: '\$10.99',
                    ),
                    _itemOrder(
                      image: 'assets/items/6.png',
                      title: 'Special Black Burger',
                      qty: '2',
                      price: '\$8.00',
                    ),
                    _itemOrder(
                      image: 'assets/items/4.png',
                      title: 'Special Cheese Burger',
                      qty: '2',
                      price: '\$12.99',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xff1f2029),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '\$40.32',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '\$4.32',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 2,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '\$44.64',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.print, size: 16),
                              SizedBox(width: 6),
                              Text('Cetak')
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close, size: 16),
                              SizedBox(width: 6),
                              Text('Clear')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemOrder({
    required String image,
    required String title,
    required String qty,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xff1f2029),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Text(
            '$qty x',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String image,
    required String title,
    required String price,
    required String item,
  }) {
    return InkWell(
      onTap: () {
        _showInputDialogOrder(context, title);
        _priceValue.text = parseFormattedCurrencyToInt(price).toString();
        initialPriceValue = parseFormattedCurrencyToInt(price.toString()).toString();
          items = [];
       },
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff1f2029),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _itemTab(
  //     {required String icon, required String title, required bool isActive}) {
  //   return Container(
  //     width: 180,
  //     margin: const EdgeInsets.only(right: 26),
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: const Color(0xff1f2029),
  //       border: isActive
  //           ? Border.all(color: Colors.deepOrangeAccent, width: 3)
  //           : Border.all(color: const Color(0xff1f2029), width: 3),
  //     ),
  //     child: Row(
  //       children: [
  //         Image.asset(
  //           icon,
  //           width: 38,
  //         ),
  //         const SizedBox(width: 8),
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _topMenu({
    required String title,
    required String subTitle,
    required Widget action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Expanded(flex: 1, child: Container(width: double.infinity)),
        Expanded(flex: 5, child: action),
      ],
    );
  }

  Widget _search() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff1f2029),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white54,
            ),
            SizedBox(width: 10),
            Text(
              'Cari disini...',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            )
          ],
        ));
  }

  Future<void> _showInputDialogOrder(BuildContext context, String name) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Text(name),
          content: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jumlah',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Counter(
                      min: 0,
                      max: 9999999,
                      bound: 1,
                      step: 1,
                      onValueChanged: (value) {
                        sumInput = value.toInt();
                        // _addItem(sumInput.toString());
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: initialPriceValue,
                  onChanged: (value) {
                    initialPriceValue = value;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff1f2029),
                    )),
                    labelText: 'Harga',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1f2029)),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem(name);
                _addItem(sumInput.toString());
                _addItem(initialPriceValue);
                _saveItem(items);
                print(saveData);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1f2029)),
              child: const Text('Simpan'),
            )
          ],
        );
      },
    );
  }

  double parseFormattedCurrencyToInt(String formattedCurrency) {
    int a = 100;
    String digitsOnly = formattedCurrency.replaceAll(RegExp(r'[^\d]'), '');
    double intValue = int.parse(digitsOnly) / a;
    return intValue;
  }


  void _addItem(String value) {
    setState(() {
      items.add(value);
    });
  }

  void _saveItem(List data) {
    setState(() {
      saveData.add(data);
    });
  }
}
