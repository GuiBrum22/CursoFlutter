import 'package:flutter/material.dart';
import 'package:sa_2_guibrum/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  final User user;

  HomeView({required this.user});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late String _userId;
  late int _selectedImageIndex;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _userId = widget.user.username; // Usando o nome de usuário como identificador único
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedImageIndex = prefs.getInt('$_userId:selected_image_index') ?? 0;
      _fontSize = prefs.getDouble('$_userId:font_size') ?? 20;
    });
  }

  void _changeBackgroundImage(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
    _saveSelectedImageIndex(index);
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2;
    });
    _saveFontSize();
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize -= 2;
    });
    _saveFontSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          _selectedBackgroundImage(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selecione uma imagem de fundo:',
                  style: TextStyle(fontSize: _fontSize),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageButton(0),
                    _buildImageButton(1),
                    _buildImageButton(2),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _increaseFontSize,
                  child: Text('Aumentar Fonte'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _decreaseFontSize,
                  child: Text('Reduzir Fonte'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectedBackgroundImage() {
    switch (_selectedImageIndex) {
      case 0:
        return Image.asset('lib/assets/imagem1.png');
      case 1:
        return Image.asset('lib/assets/imagem2.png');
      case 2:
        return Image.asset('lib/assets/imagem3.png');
      default:
        return Image.asset('lib/assets/imagem1.png');
    }
  }

  Widget _buildImageButton(int index) {
    return GestureDetector(
      onTap: () => _changeBackgroundImage(index),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: index == _selectedImageIndex ? Colors.grey : Colors.transparent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text('Image $index')),
      ),
    );
  }

  void _saveSelectedImageIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('$_userId:selected_image_index', index);
  }

  void _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('$_userId:font_size', _fontSize);
  }
}
