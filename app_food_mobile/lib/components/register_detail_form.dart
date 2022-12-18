import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'default_button.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';

class RegisterDetailForm extends StatefulWidget {
  const RegisterDetailForm({
    super.key,
    required this.register,
    required this.usernameController,
    required this.phoneController,
    required this.addressController,
    required this.nameController,
    required this.dateOfBith,
  });

  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController nameController;
  final String dateOfBith;
  final VoidCallback register;

  @override
  State<RegisterDetailForm> createState() => _RegisterDetailFormState();
}

class _RegisterDetailFormState extends State<RegisterDetailForm> {
  bool remember = false;
  DateTime selectedDate = DateTime.now();
  late List<String> errors = [];
  File? _image;

  //get date of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // widget.dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  //get image
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        SizedBox(height: 20),

        //email
        BuildTextField(
          controller: widget.usernameController,
          labelText: "Email",
          hintText: "Nhập email",
          iconText: "Mail.svg",
        ),
        SizedBox(height: 20),

        //name

        BuildTextField(
          controller: widget.nameController,
          labelText: "Họ và tên",
          hintText: "Nhập họ và tên",
          iconText: "User Icon.svg",
        ),
        SizedBox(height: 20),

        //so dien thoai
        BuildTextField(
          controller: widget.phoneController,
          labelText: "Số điện thoại",
          hintText: "Nhập số điện thoại",
          iconText: "Phone.svg",
        ),
        SizedBox(height: 20),

        //ngay sinh
        Row(
          children: [
            Text(
              "Chọn ngày sinh",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
                child: new Icon(Icons.calendar_today),
                onTap: () {
                  _selectDate(context);
                  print(
                      'chekc date offf birtfffh ${DateFormat('yyyy-MM-dd').format(selectedDate)}');
                }),
            SizedBox(
              width: 20,
            ),
            Text(DateFormat('yyyy-MM-dd').format(selectedDate))
          ],
        ),

        //dia chi
        SizedBox(height: 20),
        BuildTextField(
          controller: widget.addressController,
          labelText: "Địa chỉ",
          hintText: "Nhập địa chỉ",
          iconText: "map.svg",
        ),
        SizedBox(height: 20),

        //hinh anh

        Column(
          children: [
            Row(
              children: [
                Text("Chọn hình ảnh",
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: getImage,
                  child: Row(children: [
                    Icon(Icons.image_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Thêm ảnh")
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                  )
                : Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeAKvlSuCAVIu5B45Fgjsdrasym0LWbSzbVQ&usqp=CAU',
                    width: 100,
                  ),
          ],
        ),

        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          press: widget.register,
          text: "Đăng ký",
        )
      ]),
    );
  }

  //firstname text form field
  TextFormField buildFirstnameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/person.svg"),
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconText,
    required this.controller,
  });
  final String labelText, hintText, iconText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/$iconText"),
        ));
  }
}
