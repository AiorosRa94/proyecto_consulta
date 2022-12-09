class Cliente {
  final String id;
  final String agente;
  final String nombre;
  final String proveedor;
  final String numeroTelefono;

Cliente({required this.id,required this.agente,required this.nombre,required this.proveedor,required this.numeroTelefono});

  Map<String,dynamic> toMap(){
    return{
      'id':this.id,
      'agente':this.agente,
      'nombre':this.nombre,
      'proveedor':this.proveedor,
      'numeroTelefono':this.numeroTelefono
    };
  }
}