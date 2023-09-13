import 'package:cash_whiz/core/models/hive/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: SaleScreenContent(),
    );
  }
}

class SaleScreenContent extends StatefulWidget {
  const SaleScreenContent({super.key});

  @override
  State<SaleScreenContent> createState() => _SaleScreenContentState();
}

class _SaleScreenContentState extends State<SaleScreenContent> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Penjualan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: Hive.openBox('data_history'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final dataSale = Hive.box('data_history');
                    return Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        child: DataTable(
                          columnSpacing: 120,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Tanggal Pembelian',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nama Barang',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Jumlah',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Harga',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Keterangan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            dataSale.length,
                            (index) {
                              final getData =
                                  dataSale.getAt(index) as SaleModel;
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                    getData.date ?? '-',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataCell(Text(
                                    getData.name ?? '-',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataCell(Text(
                                    getData.quantity.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataCell(Text(
                                    getData.price.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  DataCell(Text(
                                    getData.note ?? '-',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
