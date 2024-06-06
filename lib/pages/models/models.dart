
class Livro {
  final String nome;
  final int capitulos;
  Livro({required this.nome, required this.capitulos});
}

class Versiculo {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  Versiculo({required this.book, required this.chapter, required this.verse, required this.text});

  factory Versiculo.fromJson(Map<String, dynamic> json) {
    return Versiculo(
      book: json['book'],
      chapter: int.parse(json['chapter']),
      verse: int.parse(json['verse']),
      text: json['text'],
    );
  }
}

enum UserType{
  creator,
  follower,
  offline
}

// class Reference {
//   String sender;
//   String roomCode;
//   String book;
//   int chapter;

//   Reference({
//     required this.sender,
//     required this.roomCode,
//     required this.book,
//     required this.chapter,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'sender': sender,
//       'roomCode': sender,
//       'book': book,
//       'chapter': chapter,
//     };
//   }

//   factory Reference.fromJson(Map<String, dynamic> json) {
//     return Reference(
//       sender: json['sender'] as String,
//       roomCode: json['roomCode'] as String,
//       book: json['book'] as String,
//       chapter: json['chapter'] as int,
//     );
//   }

//   @override
//   String toString() => "Reference(sender: $sender, roomCode: $roomCode, book: $book, chapter: $chapter)";

//   @override
//   int get hashCode => Object.hash(sender, roomCode, book, chapter);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Reference &&
//           runtimeType == other.runtimeType &&
//           sender == other.sender &&
//           roomCode == other.roomCode &&
//           book == other.book &&
//           chapter == other.chapter;
// }


List<Livro> antigoTestamento = [
    Livro(nome: 'Genesis', capitulos: 50),
    Livro(nome: 'Exodus', capitulos: 40),
    Livro(nome: 'Leviticus', capitulos: 27),
    Livro(nome: 'Numbers', capitulos: 36),
    Livro(nome: 'Deuteronomy', capitulos: 34),
    Livro(nome: 'Joshua', capitulos: 24),
    Livro(nome: 'Judges', capitulos: 21),
    Livro(nome: 'Ruth', capitulos: 4),
    Livro(nome: '1 Samuel', capitulos: 31),
    Livro(nome: '2 Samuel', capitulos: 24),
    Livro(nome: '1 Kings', capitulos: 22),
    Livro(nome: '2 Kings', capitulos: 25),
    Livro(nome: '1 Chronicles', capitulos: 29),
    Livro(nome: '2 Chronicles', capitulos: 36),
    Livro(nome: 'Ezra', capitulos: 10),
    Livro(nome: 'Nehemiah', capitulos: 13),
    Livro(nome: 'Esther', capitulos: 10),
    Livro(nome: 'Job', capitulos: 42),
    Livro(nome: 'Psalms', capitulos: 150),
    Livro(nome: 'Proverbs', capitulos: 31),
    Livro(nome: 'Ecclesiastes', capitulos: 12),
    Livro(nome: 'Song of Solomon', capitulos: 8),
    Livro(nome: 'Isaiah', capitulos: 66),
    Livro(nome: 'Jeremiah', capitulos: 52),
    Livro(nome: 'Lamentations', capitulos: 5),
    Livro(nome: 'Ezekiel', capitulos: 48),
    Livro(nome: 'Daniel', capitulos: 12),
    Livro(nome: 'Hosea', capitulos: 14),
    Livro(nome: 'Joel', capitulos: 3),
    Livro(nome: 'Amos', capitulos: 9),
    Livro(nome: 'Obadiah', capitulos: 1),
    Livro(nome: 'Jonah', capitulos: 4),
    Livro(nome: 'Micah', capitulos: 7),
    Livro(nome: 'Naum', capitulos: 3),
    Livro(nome: 'Habakkuk', capitulos: 3),
    Livro(nome: 'Zephaniah', capitulos: 3),
    Livro(nome: 'Haggai', capitulos: 2),
    Livro(nome: 'Zechariah', capitulos: 14),
    Livro(nome: 'Malachi', capitulos: 4)
];

List<Livro> novoTestamento = [
    Livro(nome: 'Matthew', capitulos: 28),
    Livro(nome: 'Mark', capitulos: 16),
    Livro(nome: 'Luke', capitulos: 24),
    Livro(nome: 'John', capitulos: 21),
    Livro(nome: 'Acts', capitulos: 28),
    Livro(nome: 'Romans', capitulos: 16),
    Livro(nome: '1 Corinthians', capitulos: 16),
    Livro(nome: '2 Corinthians', capitulos: 13),
    Livro(nome: 'Galatians', capitulos: 6),
    Livro(nome: 'Ephesians', capitulos: 6),
    Livro(nome: 'Philippians', capitulos: 4),
    Livro(nome: 'Colossians', capitulos: 4),
    Livro(nome: '1 Thessalonians', capitulos: 5),
    Livro(nome: '2 Thessalonians', capitulos: 3),
    Livro(nome: '1 Timothy', capitulos: 6),
    Livro(nome: '2 Timothy', capitulos: 4),
    Livro(nome: 'Titus', capitulos: 3),
    Livro(nome: 'Philemon', capitulos: 1),
    Livro(nome: 'Hebrews', capitulos: 13),
    Livro(nome: 'James', capitulos: 5),
    Livro(nome: '1 Peter', capitulos: 5),
    Livro(nome: '2 Peter', capitulos: 3),
    Livro(nome: '1 John', capitulos: 5),
    Livro(nome: '2 John', capitulos: 1),
    Livro(nome: '3 John', capitulos: 1),
    Livro(nome: 'Jude', capitulos: 1),
    Livro(nome: 'Revelation', capitulos: 22)
];

List<Livro> bible = antigoTestamento + novoTestamento;