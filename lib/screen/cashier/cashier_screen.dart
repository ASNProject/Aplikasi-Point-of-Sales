import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_bloc.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_event.dart';
import 'package:aplikasi_point_of_sales/blocs/list_product/list_product_state.dart';
import 'package:aplikasi_point_of_sales/core/models/hive/product_model.dart';
import 'package:aplikasi_point_of_sales/core/models/list_product_model.dart';
import 'package:aplikasi_point_of_sales/core/repo/repositories.dart';
import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final TextEditingController _totalPaidController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<String> items = [];
  List<List<dynamic>> saveData = [];
  int? sumInput;
  String initialPriceValue = '';
  String initialNote = '';
  double totalPaid = 0.0;
  String initialTotalPaid = '';
  List<ProductModel> searchResult = [];

  late final Box dataBox;

  @override
  void dispose() {
    _priceValue.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _totalPaidController.text = '';
    dataBox = Hive.box('data_box');
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() async {
    final query = _searchController.text.toLowerCase();
    final result = await _searchProducts(query);
    setState(() {
      searchResult = result;
    });
  }

  Future<List<ProductModel>> _searchProducts(String query) async {
    final List<ProductModel> results = [];

    for (var key in dataBox.keys) {
      final productData = dataBox.get(key);
      if (productData != null) {
        final product = ProductModel(
          name: productData.name,
          description: productData.description,
          price: productData.price,
          imageUrl: productData.imageUrl,
        );

        if (product.name!.toLowerCase().contains(query)) {
          results.add(product);
        }
      }
    }
    print('Hasilnya ${results.map((e) => e.name)}');
    return results;
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
              //MODE
              // _buildOnlineMode()
              _buildOfflineMode(),
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
                    String image;
                    String note;
                    if (saveData.isNotEmpty) {
                      List<dynamic> rowData = saveData[index];
                      product = rowData[0];
                      total = rowData[1];
                      image = rowData[3];
                      amount = double.parse(rowData[2].toString());
                      note = rowData[4];
                      return _itemOrder(
                        image: image,
                        title: product,
                        qty: total,
                        price: intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                            .format(amount),
                        note: note,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(vertical: 2),
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
                                intl.NumberFormat.simpleCurrency(
                                        locale: 'id_ID')
                                    .format(totalAmount),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Dibayar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxHeight: 35),
                                  child: TextFormField(
                                    controller: _totalPaidController,
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 5),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    onChanged: (value) {
                                      try {
                                        setState(() {
                                          totalPaid = double.parse(value);
                                          initialTotalPaid = value;
                                        });
                                      } catch (e) {
                                        e.toString();
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            height: 2,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Kembali',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              _handleRefundAmount(totalAmount, totalPaid)
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
                            onPressed: () {
                              _clearData();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.print, size: 16),
                                SizedBox(width: 6),
                                Text('Bayar & Cetak')
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
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
                              _clearData();
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
    required String note,
  }) {
    return InkWell(
      onTap: () {
        _showDialogItemOrder(context, title);
      },
      child: Container(
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
                image: const DecorationImage(
                  // image: NetworkImage(image),
                  image: AssetImage('assets/items/image.png'),
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 10,
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
        _showInputDialogOrder(context, title, image);
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
                aspectRatio: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      // image: NetworkImage(image),
                      image: AssetImage('assets/items/image.png'),
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 35),
      child: TextFormField(
        textDirection: TextDirection.rtl,
        textAlignVertical: TextAlignVertical.top,
        controller: _searchController,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w100,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.white,
          hintTextDirection: TextDirection.rtl,
          hintText: 'Cari disini',
          hintStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          fillColor: Colors.transparent,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showInputDialogOrder(
      BuildContext context, String name, String image) async {
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
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onChanged: (value) {
                    initialNote = value;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff1f2029),
                    )),
                    labelText: 'Keterangan',
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
                _handleSaveData(name, image);
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

  Future<void> _showDialogItemOrder(BuildContext context, String name) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Text(name),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1f2029),
              ),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  saveData.removeWhere((row) => row[0] == name);
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Hapus'),
            ),
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

  void _clearData() {
    setState(() {
      saveData = [];
      totalPaid = 0.0;
      _totalPaidController.text = '';
    });
  }

  void _handleSaveData(String name, String image) {
    double totalPrice =
        double.parse(sumInput.toString()) * double.parse(initialPriceValue);
    _addItem(name);
    _addItem(sumInput.toString());
    _addItem(totalPrice.toString());
    _addItem(image);
    _addItem(initialNote);
    _saveItem(items);
  }

  Widget _handleRefundAmount(double totalAmount, double payment) {
    double refaundAmount = payment - totalAmount;
    return Text(
      intl.NumberFormat.simpleCurrency(locale: 'id_ID').format(refaundAmount),
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  ///ONLINE OR OFFLINE
  // Online
  _buildOnlineMode() {
    return BlocBuilder<ListProductBloc, ListProductState>(
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.8,
            ),
            itemCount: listProduct.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: _item(
                  image: '${listProduct[index].image}',
                  title: '${listProduct[index].product}',
                  price: intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                      .format(listProduct[index].price),
                  item: '${listProduct[index].description}',
                ),
              );
            },
          ));
        }
        return Container();
      },
    );
  }

  // OfflineMode
  _buildOfflineMode() {
    return ValueListenableBuilder(
      valueListenable: dataBox.listenable(),
      builder: (context, Box<dynamic> box, child) {
        if (box.isEmpty) {
          return const Center(
            child: Text(
              'Database kosong',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          return Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.8,
            ),
            itemCount:
                searchResult.isNotEmpty ? searchResult.length : dataBox.length,
            itemBuilder: (_, index) {
              var getData = searchResult.isNotEmpty
                  ? searchResult[index]
                  : box.getAt(index) as ProductModel;
              return Padding(
                padding: const EdgeInsets.all(1),
                child: _item(
                  image: getData.imageUrl.toString(),
                  title: getData.name.toString(),
                  price: intl.NumberFormat.simpleCurrency(locale: 'id_ID')
                      .format(double.parse(getData.price!)),
                  item: getData.description.toString(),
                ),
              );
            },
          ));
        }
      },
    );
  }
}
