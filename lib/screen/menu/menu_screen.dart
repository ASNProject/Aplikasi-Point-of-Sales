import 'package:aplikasi_point_of_sales/core/models/hive/product_model.dart';
import 'package:aplikasi_point_of_sales/widget/cards/list_product_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: MenuScreenContent(),
    );
  }
}

class MenuScreenContent extends StatefulWidget {
  const MenuScreenContent({
    super.key,
  });

  @override
  State<MenuScreenContent> createState() => _MenuScreenContentState();
}

class _MenuScreenContentState extends State<MenuScreenContent> {
  final nameProductController = TextEditingController();
  final priceProductController = TextEditingController();
  final descriptionProductController = TextEditingController();
  final categotyProductController = TextEditingController();
  final imageProductController = TextEditingController();
  bool isEditing = false;

  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
  }

  _createProduct() {
    ProductModel newData = ProductModel(
      name: nameProductController.text,
      price: priceProductController.text,
      description: descriptionProductController.text,
      category: categotyProductController.text,
      imageUrl: imageProductController.text,
    );

    dataBox.add(newData);

    nameProductController.clear();
    priceProductController.clear();
    descriptionProductController.clear();
    categotyProductController.clear();
    imageProductController.clear();
  }

  _deleteProduct(int index) {
    dataBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Masukkan Produk Baru',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRowData(
          leftWidget: const Text(
            'Nama Produk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          rightWidget: Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 35),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                textAlignVertical: TextAlignVertical.top,
                controller: nameProductController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'Masukkan nama produk',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk harus diisi';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRowData(
          leftWidget: const Text(
            'Harga Produk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          rightWidget: Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 35),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                textAlignVertical: TextAlignVertical.top,
                controller: priceProductController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'Masukkan harga produk',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga produk harus diisi';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRowData(
          leftWidget: const Text(
            'Deskripsi Produk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          rightWidget: Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 35),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                textAlignVertical: TextAlignVertical.top,
                controller: descriptionProductController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'Masukkan deskripsi produk',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRowData(
          leftWidget: const Text(
            'Category Produk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          rightWidget: Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 35),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                textAlignVertical: TextAlignVertical.top,
                controller: categotyProductController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'Masukkan harga produk',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _buildRowData(
          leftWidget: const Text(
            'Gambar Produk',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          rightWidget: Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 35),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                textAlignVertical: TextAlignVertical.top,
                controller: imageProductController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'Masukkan link gambar produk',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () async {
              _createProduct();
            },
            child: const Text('SIMPAN PRODUK'),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        const Text(
          'Data Produk',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          child: ValueListenableBuilder(
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
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataBox.length,
                  itemBuilder: (context, index) {
                    var getData = box.getAt(index) as ProductModel;

                    return ListProductCard(
                      name: getData.name,
                      price: getData.price,
                      description: getData.description,
                      category: getData.category,
                      image: getData.imageUrl,
                      deletePressed: () {
                        _deleteProduct(index);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  /// WIDGET
  Widget _buildRowData({
    required Widget leftWidget,
    Widget? rightWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .1,
          child: leftWidget,
        ),
        if (rightWidget != null) rightWidget,
      ],
    );
  }
}
