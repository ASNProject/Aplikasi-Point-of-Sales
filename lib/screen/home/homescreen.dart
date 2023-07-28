import 'package:aplikasi_point_of_sales/screen/cashier/cashier_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pageActive = 'Home';

  _pageView() {
    switch (pageActive) {
      case 'Cashier':
        return const CashierScreen();
      case 'Menu':
        return Container();
      case 'History':
        return Container();

      default:
        return const CashierScreen();
    }
  }

  _setPage(String page) {
    setState(() {
      pageActive = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1f2029),
        body: Row(
          children: [
            Container(
              width: 70,
              padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
              height: MediaQuery.of(context).size.height,
              child: _sideMenu(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 24, right: 12),
                padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color(0xff17181f),
                ),
                child: _pageView(),
              ),
            )
          ],
        ));
  }

  Widget _sideMenu() {
    return Column(
      children: [
        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Text(
            'POS APP',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),

          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView(
            children: [
              _itemMenu(
                menu: 'Cashier',
                icon: Icons.computer,
              ),
              _itemMenu(
                menu: 'Menu',
                icon: Icons.format_list_bulleted_rounded,
              ),
              _itemMenu(
                menu: 'History',
                icon: Icons.history_toggle_off_rounded,
              ),
              _itemMenu(
                menu: 'Promosi',
                icon: Icons.discount_outlined,
              ),
              _itemMenu(
                menu: 'Settings',
                icon: Icons.settings,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _itemMenu({required String menu, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: GestureDetector(
        onTap: () => _setPage(menu),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: pageActive == menu
                  ? Colors.deepOrangeAccent
                  : Colors.transparent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.slowMiddle,
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  menu,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
