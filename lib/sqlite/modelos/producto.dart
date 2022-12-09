class Producto{
  final int? id;
  final String nombre;
  final String varianteId;
  final String enStock;

  Producto({this.id,required this.nombre, required this.varianteId, required this.enStock});

  Map<String,dynamic> toMap(){
    return{
      'nombre':this.nombre,
      'varianteId':this.varianteId,
      'enStock':this.enStock
    };
  }
}