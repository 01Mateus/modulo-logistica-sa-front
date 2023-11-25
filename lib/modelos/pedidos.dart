class Pedidos {
  dynamic enderecoPedido;
  dynamic fretePedido;
  dynamic clientePedido;
  dynamic nomeItensPedido;
  dynamic quantidadeItensPedido;
  dynamic imagemRestaurantePedido;


Pedidos(this.clientePedido, this.enderecoPedido, this.fretePedido, this.nomeItensPedido,this.quantidadeItensPedido, this.imagemRestaurantePedido);

  Pedidos.iniciar() {
    enderecoPedido = "";
    fretePedido = 0;
    clientePedido = "";
    nomeItensPedido = "";
    quantidadeItensPedido = 0;
    imagemRestaurantePedido = "";
  }
}