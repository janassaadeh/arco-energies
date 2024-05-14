import 'package:company_pages/Screens/Admin/New%20Deposit/cash_value_entry.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/companies_deposit.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/payment_method_select.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/input_field.dart';

// import '../../../Widgets/Operator/next_button.dart';
import '../../../Widgets/Common/CustomButton.dart';
// import '../../../Widgets/Common/j_next_button.dart';
import '../Manage Companies/Company_Model.dart';
import '../../../Provider/company_provider.dart';

import 'package:provider/provider.dart';

class SelectCompanyBody extends StatefulWidget {
  const SelectCompanyBody({super.key});

  @override
  State<SelectCompanyBody> createState() => _SelectCompanyBodyState();
}

class _SelectCompanyBodyState extends State<SelectCompanyBody> {
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Company> companyList =
        Provider.of<CompanyProvider>(context).companyList;

    return Column(
      children: [
        // const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Select Company", "1"),
              const SizedBox(height: 2),
              buildText("Input the company name into the search bar."),
              const SizedBox(height: 12),
              buildImageContainer("assets/images/select_company.png", true),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final id = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SelectCompanies(companies: companyList)),
                  );
                  if (id != null) {
                    setState(() {
                      idController.text = id;
                    });
                  }
                },
                child: buildInputF(
                  '  Search...',
                  Image.asset(
                    "assets/images/Search.png",
                    width: 25,
                  ),
                  true,
                  idController,
                ),
              ),
              const SizedBox(height: 5),
              buildSecondText(
                  "Verify your selected payment method to ensure accuracy."),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethodEntry(
                              selectedCompany: idController.text)),
                    );
                  },
                  child: CustomButton(buttonText: 'Next')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildInputF(String hintText, Widget widgetAtLeft, bool withBorder,
    TextEditingController textEditingController,
    {bool isPressable = false}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: withBorder
          ? Border.all(
              color: Colors.black,
              width: 1,
            )
          : Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: isPressable
                ? const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18)
                : const EdgeInsets.symmetric(horizontal: 18.0),
            child: isPressable
                ? Text(
                    hintText,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                : TextFormField(
                    enabled: false,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                  ),
          ),
        ),
        widgetAtLeft,
        const SizedBox(
          width: 15,
        )
      ],
    ),
  );
}
