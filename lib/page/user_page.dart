import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../utils/user_simple_preferences.dart';
import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class UserPage extends StatefulWidget {
    final String? idUser;

    const UserPage({
        Key? key,
        this.idUser,
    }) : super(key: key);

    @override
    _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String email = '';
    String password = '';

    @override
    void initState() {
        super.initState();

        name = UserSimplePrefernces.getUsername() ?? "";
        email = UserSimplePrefernces.getEmail() ?? "";
        password = UserSimplePrefernces.getPassword() ?? "";
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Finurja Registration'),
            backgroundColor: Colors.amber[500],
            centerTitle: true,
        ),
        body: Form(
            key: formKey,
            child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget> [
                    TitleWidget(text: 'Sign Up Form'),
                    SizedBox(height: 32),
                    buildName(),
                    SizedBox(height: 32),
                    buildEmail(),
                    SizedBox(height: 32),
                    buildPassword(),
                    SizedBox(height: 32),
                    buildButton(),
                ],
            ),
        ),
    );

    Widget buildName() => buildTitle(
        title: 'Username',
        child: TextFormField(
            initialValue: name,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Username'
            ),
            validator: (value) {
                if(value == null || value.isEmpty) {
                    return 'Please enter a valid username';
                }
                return null;
            },
            onChanged: (name) => setState(() => this.name = name),
        ),
    );

    Widget buildEmail() => buildTitle(
        title: 'Email',
        child: TextFormField(
            initialValue: email,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Email Address'
            ),
            validator: ValidationBuilder().email().build(),
            onChanged: (email) => setState(() => this.email = email),
        ),
    );

    Widget buildPassword() => buildTitle(
        title: 'Password',
        child: TextFormField(
            initialValue: password,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Password'
            ),
            validator: ValidationBuilder().minLength(8).build(),
            onChanged: (password) => setState(() => this.password = password),
        ),
    );

    Widget buildButton() => ButtonWidget(
        text: 'Sign Up',
        onClicked: () async {
            await UserSimplePrefernces.setUsername(name);
            await UserSimplePrefernces.setEmail(email);
            await UserSimplePrefernces.setPassword(password);

            if(formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Details Collected')
                    ),
                );
            }
        });

    Widget buildTitle({
        @required String? title,
        @required Widget? child,
    }) => 
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Text(
                    title ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                child ?? SizedBox.shrink(),
            ],
        );
}