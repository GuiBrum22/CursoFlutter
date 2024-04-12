import 'package:flutter/material.dart'; // Importa o pacote Flutter Material
import 'package:sa_2_guibrum/Model/User.dart'; // Importa a classe User do pacote sa_2_guibrum
import 'package:shared_preferences/shared_preferences.dart'; // Importa o pacote SharedPreferences

class HomeView extends StatefulWidget {
  final User user; // Declaração do usuário como atributo final

  HomeView({required this.user}); // Construtor que recebe um usuário obrigatoriamente

  @override
  _HomeViewState createState() => _HomeViewState(); // Método para criar o estado da tela
}

class _HomeViewState extends State<HomeView> {
  late String _userId; // Declaração do ID do usuário como atributo
  late int _selectedImageIndex; // Declaração do índice da imagem selecionada como atributo
  late double _fontSize; // Declaração do tamanho da fonte como atributo

  @override
  void initState() {
    super.initState();
    _userId = widget.user.username; // Obtém o nome de usuário do widget pai
    _loadSettings(); // Carrega as configurações iniciais
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance(); // Obtém as preferências do aplicativo
    setState(() {
      _selectedImageIndex = prefs.getInt('$_userId:selected_image_index') ?? 0; // Carrega o índice da imagem selecionada ou usa o padrão 0
      _fontSize = prefs.getDouble('$_userId:font_size') ?? 20; // Carrega o tamanho da fonte ou usa o padrão 20
    });
  }

  void _changeBackgroundImage(int index) {
    setState(() {
      _selectedImageIndex = index; // Altera o índice da imagem selecionada
    });
    _saveSelectedImageIndex(index); // Salva o índice da imagem selecionada nas preferências
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2; // Aumenta o tamanho da fonte
    });
    _saveFontSize(); // Salva o tamanho da fonte nas preferências
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize -= 2; // Reduz o tamanho da fonte
    });
    _saveFontSize(); // Salva o tamanho da fonte nas preferências
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          _selectedBackgroundImage(), // Exibe a imagem de fundo selecionada
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selecione uma imagem de fundo:',
                  style: TextStyle(fontSize: _fontSize), // Aplica o tamanho da fonte
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageButton(0), // Botão para selecionar a imagem 0
                    _buildImageButton(1), // Botão para selecionar a imagem 1
                    _buildImageButton(2), // Botão para selecionar a imagem 2
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _increaseFontSize, // Botão para aumentar o tamanho da fonte
                  child: Text('Aumentar Fonte'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _decreaseFontSize, // Botão para reduzir o tamanho da fonte
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
        return Image.asset('lib/assets/imagem1.png'); // Retorna a imagem 1
      case 1:
        return Image.asset('lib/assets/imagem2.png'); // Retorna a imagem 2
      case 2:
        return Image.asset('lib/assets/imagem3.png'); // Retorna a imagem 3
      default:
        return Image.asset('lib/assets/imagem1.png'); // Retorna a imagem padrão (1)
    }
  }

  Widget _buildImageButton(int index) {
    return GestureDetector(
      onTap: () => _changeBackgroundImage(index), // Ao tocar no botão, muda a imagem de fundo
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: index == _selectedImageIndex ? Colors.grey : Colors.transparent, // Define a cor do contorno do botão
          border: Border.all(color: Colors.black), // Define a cor do contorno do botão
          borderRadius: BorderRadius.circular(10), // Define a borda do botão
        ),
        child: Center(child: Text('Imagem $index')), // Exibe o texto do botão
      ),
    );
  }

  void _saveSelectedImageIndex(int index) async {
    final prefs = await SharedPreferences.getInstance(); // Obtém as preferências do aplicativo
    prefs.setInt('$_userId:selected_image_index', index); // Salva o índice da imagem selecionada
  }

  void _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance(); // Obtém as preferências do aplicativo
    prefs.setDouble('$_userId:font_size', _fontSize); // Salva o tamanho da fonte
  }
}
