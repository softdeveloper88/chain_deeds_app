import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_bloc.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_event.dart';
import 'package:chain_deeds_app/widgets/custom_phone_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/cod_model/get_member_model.dart';
import 'bloc/code_state.dart';

class SendTokenScreen extends StatefulWidget {
  @override
  _SendTokenScreenState createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends State<SendTokenScreen> {
  List<Members> selectedMembers = [];
  // List<String> allMembers = ['One', 'Two', 'Three', 'Four', 'Five'];
  List<Members> filteredMembers = [];
  bool isAutomated = true;
  String selectedInterval = "Day"; // Default value for dropdown
  CODBloc codBloc = CODBloc();
  TextEditingController amountTextEditingController=TextEditingController();
  TextEditingController phoneEditingController=TextEditingController();
  String dialCode = '+1';
  String countryCode = "US";
  @override
  void initState() {
    super.initState();
    filteredMembers = codBloc.getMemberModel?.data?.members??[];
    codBloc.add(GetMemberDataEvent());
    // Initially display all members
  }

  void filterSearchResults(String query) {
    List<Members>? filteredList = [];
    if (query.isNotEmpty) {
      filteredList = codBloc.getMemberModel?.data?.members?.where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredMembers = filteredList??[];
      });
    } else {
      setState(() {
        filteredMembers = codBloc.getMemberModel!.data!.members!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          elevation: 0,
          leading: InkWell(
              onTap: () {
                NavigatorService.goBack();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              )),
          title: const Text(
            'Send Token',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocListener<CODBloc, CODState>(
          bloc: codBloc,
          listener: (context, state) {
            if (state is CODFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is CODSuccess) {
              if (state.response['status']) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.response['message'] ?? '')),
                );
              } else {
                if (state.response.containsKey('errors')) {
                  showErrorDialog(state.response['errors'], context);
                } else if (state.response.containsKey('message')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Member add  failed!${state.response['message']}')),
                  );
                }
              }
            }
          },
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MultiSelectDropdown(
                    label: "",
                    items: codBloc.getMemberModel?.data?.members??[],
                    selectedItems: selectedMembers,
                    filteredItems: filteredMembers,
                    onSelectionChanged: (List<Members> members) {
                      setState(() {
                        selectedMembers = members;
                      });
                    },
                    onSearchChanged: filterSearchResults,
                  ),
                  const SizedBox(height: 20),
                  CustomPhoneTextFieldWidget(
                    initialCountryCode: 'US',
                    favoriteCountries: const ["+1", "US"],
                    controller: phoneEditingController,
                    onChange: (code) {
                      dialCode = code.dialCode ?? "+1";
                      countryCode = code.code ?? "US";
                    },
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Search by email, User Id or Mobile number',
                  //     labelStyle: const TextStyle(color: Colors.grey),
                  //     filled: true,
                  //     fillColor: const Color(0xFFF3F7FF),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Send Token",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: amountTextEditingController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter number of Token',
                            labelStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color(0xFFF3F7FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Automated'),
                          value: true,
                          groupValue: isAutomated,
                          onChanged: (value) {
                            setState(() {
                              isAutomated = value!;
                            });
                          },
                        ),
                      ),
                      const Text('or'),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('One Time Token'),
                          value: false,
                          groupValue: isAutomated,
                          onChanged: (value) {
                            setState(() {
                              isAutomated = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                 if(isAutomated) DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F7FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: selectedInterval,
                    items: ["Day","Week", "Month"].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedInterval = value!;
                        isAutomated = value == "Automated";
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: MaterialButton(
                      elevation: 0,
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        String member='';
                        for (var e in selectedMembers) {
                          if(member ==''){
                            member = "${e.id}";
                          }else {
                            member = "$member,${e.id}";
                          }
                        }
                        if(int.parse(amountTextEditingController.text)<=0){
                          toasty(context, 'Token should be greater then zero',bgColor: Colors.red,textColor: Colors.white);
                          return;
                        }
                        String donationType=isAutomated?'automated':'ott';
                        codBloc.add(SendTokenEvent(amountTextEditingController.text, donationType, selectedInterval.toLowerCase(), member, phoneEditingController.text, countryCode, dialCode));
                      },
                      color: const Color(0xFFFFD319),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final List<Members> items;
  final List<Members> selectedItems;
  final List<Members> filteredItems;
  final Function(List<Members>) onSelectionChanged;
  final Function(String) onSearchChanged;

  const MultiSelectDropdown({
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.filteredItems,
    required this.onSelectionChanged,
    required this.onSearchChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F7FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Wrap(
                children: widget.selectedItems.map((item) {
                  return Chip(
                    label: Text(item.name??''),
                    onDeleted: () {
                      setState(() {
                        widget.selectedItems.remove(item);
                        widget.onSelectionChanged(widget.selectedItems);
                      });
                    },
                  );
                }).toList(),
              ),
              TextField(
                onChanged: (value) {
                  widget.onSearchChanged(value);
                  setState(() {
                    isDropdownVisible = value.isNotEmpty;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Select Members (one or more members)',
                  border: InputBorder.none,
                ),
              ),
              Visibility(
                visible: isDropdownVisible,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F7FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: widget.filteredItems.map((item) {
                      return ListTile(
                        title: Text(item.name??""),
                        onTap: () {
                          if (!widget.selectedItems.contains(item)) {
                            setState(() {
                              widget.selectedItems.add(item);
                              widget.onSelectionChanged(widget.selectedItems);
                              isDropdownVisible = false;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
