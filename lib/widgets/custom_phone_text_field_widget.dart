import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:chain_deeds_app/core/utils/app_colors.dart';

class CustomPhoneTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String initialCountryCode;
  final List<String> favoriteCountries;
  final Function(CountryCode)? onChange;

  const CustomPhoneTextFieldWidget({
    Key? key,
    this.controller,
    this.initialCountryCode = 'US',
    this.favoriteCountries = const ['+1', 'US'],
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.backgroundScreenColor,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: '             Phone number',
          labelStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: CountryCodePicker(
            onChanged: (countryCode)=>onChange!(countryCode),
            initialSelection: initialCountryCode,
            favorite: favoriteCountries,
            showCountryOnly: true,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
          filled: true,
          fillColor: AppColors.backgroundScreenColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
