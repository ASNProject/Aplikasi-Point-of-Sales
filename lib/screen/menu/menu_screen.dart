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
  bool _validate = false;
  bool isEditing = false;

  late final Box dataBox;

  @override
  void dispose() {
    nameProductController.dispose();
    priceProductController.dispose();
    super.dispose();
  }

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowData(
              leftWidget: const Text(
                'Nama Produk',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),
            if (_validate)
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  const Text(
                    'Nama produk harus diisi',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowData(
              leftWidget: const Text(
                'Harga Produk',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              rightWidget: Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 35),
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    textAlignVertical: TextAlignVertical.top,
                    controller: priceProductController,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: 'Masukkan harga produk',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),
            if (_validate)
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  const Text(
                    'Harga produk harus diisi',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
          ],
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
                    hintStyle: const TextStyle(fontWeight: FontWeight.w200),
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
                    hintStyle: const TextStyle(fontWeight: FontWeight.w200),
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
                    hintStyle: const TextStyle(fontWeight: FontWeight.w200),
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
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '*Catatan',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              '1. Nama dan harga produk harus diisi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              '2. Isi harga produk dengan bilang/angka tanpa koma atau titik',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              '3. Isi gambar dengan link contoh: https://img.iproperty.com.my/angel-legacy/1110x624-crop/static/2021/05/Paku-Jenis-Ukuran-dan-Harga-Paku-2021.png',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                nameProductController.text.isEmpty
                    ? _validate = true
                    : _validate = false;
              });
              _validate == false ? _createProduct() : null;
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
