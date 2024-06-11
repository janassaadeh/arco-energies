import 'package:company_pages/Screens/Admin/New%20Deposit/companies_deposit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/payment_method_select.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/input_field.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Widgets/Common/CustomButton.dart';
import '../Manage Companies/Company_Model.dart';

class SelectCompanyBody extends StatefulWidget {
  const SelectCompanyBody({super.key});

  @override
  State<SelectCompanyBody> createState() => _SelectCompanyBodyState();
}

class _SelectCompanyBodyState extends State<SelectCompanyBody> {
  TextEditingController idController = TextEditingController();
  // List<Company> companyList = [];

  @override
  void initState() {
    super.initState();
    // _fetchCompanies();
  }



  @override
  Widget build(BuildContext context) {
     CompanyProvider companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
    return Column(
      children: [
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
                          SelectCompanies(companies: companyProvider.companyList),
                    ),
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
                  if (idController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ErrorPopUp(
                            text: "Make sure you have selected a company!");
                      },
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethodEntry(
                          selectedCompany: idController.text,
                        ),
                      ),
                    );
                  }
                },
                child: CustomButton(buttonText: 'Next'),
              ),
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
