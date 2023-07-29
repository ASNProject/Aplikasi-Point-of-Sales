import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_bloc.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_event.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_state.dart';
import 'package:aplikasi_point_of_sales/core/models/list_product_model.dart';
import 'package:aplikasi_point_of_sales/core/repo/repositories.dart';
import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              ListProductBloc(ListProductRepository())
                ..add(
                  LoadListProductEvent(),
                ),
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
  List<List<dynamic>> saveData = [];
  int? sumInput;
  String initialPriceValue = '';

  @override
  void dispose() {
    _priceValue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0.0;
    for (List<dynamic> rowData in saveData) {
      totalAmount += double.parse(rowData[2].toString());
    }
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
                subTitle:
                    intl.DateFormat('dd-MMMM-yyyy').format(DateTime.now()),
                action: _search(),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ListProductBloc, ListProductState>(
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
                            price: intl.NumberFormat.simpleCurrency(
                                    locale: 'id_ID')
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
                subTitle: 'Harga pembelian dapat disesuaikan dengan kebutuhan',
                action: Container(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: saveData.length,
                  itemBuilder: (_, index) {
                    String product;
                    String total;
                    double amount;
                    if (saveData.isNotEmpty) {
                      List<dynamic> rowData = saveData[index];
                      product = rowData[0];
                      total = rowData[1];
                      amount = double.parse(rowData[2].toString());
                      return _itemOrder(
                        image: 'assets/items/1.png',
                        title: product,
                        qty: total,
                        price: intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                            .format(amount),
                      );
                    } else {
                      return Container();
                    }
                  },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                                  .format(totalAmount),
                              style: const TextStyle(
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
                              'Dibayar',
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
                              'Kembali',
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
                          onPressed: () {
                            setState(() {
                              saveData = [];
                            });
                          },
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
        initialPriceValue =
            parseFormattedCurrencyToInt(price.toString()).toString();
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
                _handleSaveData(name);
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

  void _handleSaveData(String name) {
    double totalPrice =
        double.parse(sumInput.toString()) * double.parse(initialPriceValue);
    _addItem(name);
    _addItem(sumInput.toString());
    _addItem(totalPrice.toString());
    _saveItem(items);
    print(saveData);
  }
}
