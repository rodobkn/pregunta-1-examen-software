class VendedorMotos

  attr_accessor :commissions, :padrino, :n_padrinos

  def initialize
    @commissions = 0
    @n_padrinos = 0
    @padrino = nil
  end

  def pagar_padrino(commission)
    @commissions += commission
    if @padrino
      @padrino.pagar_padrino(commission)
    end
  end

  def complete_sale(amount)
    porcentaje = 0.03
    commission = porcentaje * amount  #sacamos la comision correspondiente

    @commissions += commission * 10/(@n_padrinos + 10)  #le sumamos el dinero al atributo @comissions

    #Si tiene un padrino asociado, le pasamos la comisión correspondiente a su padrino.
    if @padrino
      @padrino.pagar_padrino(commission * 1/(@n_padrinos + 10))  
    end
  end


end

class VendedorCarros

  attr_accessor :commissions, :padrino, :n_padrinos

  def initialize
    @commissions = 0
    @n_padrinos = 0
    @padrino = nil
  end

  def pagar_padrino(commission)
    @commissions += commission
    if @padrino
      @padrino.pagar_padrino(commission)
    end
  end

  def complete_sale(amount)

  	#Vemos si el monto es mayor a 20.000.000 para así darle el 5% de comision, de lo contrario 2%
  	if amount < 20000000
  		porcentaje = 0.02
  	else
  		porcentaje = 0.05
  	end

  	comission = amount * porcentaje

  	#Verificamos si la comision no excede el tope de 2.000.000. Si es así le asignamos 2.000.000
  	if comission > 2000000
  		comission = 2000000
  	end


    @commissions += commission * 10/(@n_padrinos + 10) #Recibe la comisión correspondiente

    #Si tiene un padrino asociado, le pasamos la comisión correspondiente a su padrino.
    if @padrino
      @padrino.pagar_padrino(commission * 1/(@n_padrinos + 10))
    end
  end


end


class SalesmanFactory
  attr_accessor :vendedores

  def initialize
  	#Lista con los vendedores de la agencia
    @vendedores = []
  end

  def create_salesman
    # creamos el vendedor de motos o de carros con probabilidad de 50% los dos.
    if rand < 0.5
      vendedor = VendedorMotos.new
    else
      vendedor = VendedorCarros.new
    end

    # Elegimo un padrino de la lista de vendedores que ya tenemos de forma aleatoria. Si la lista esta vacia, se asigna un nil.
    padrino_asociado = @vendedores.sample

    vendedor.padrino = padrino_asociado

    # Revisamos cuantos padrinos en cadena tiene, y se lo asignamos
    current_vendedor = vendedor
    while current_vendedor.padrino

      current_vendedor = current_vendedor.padrino
      vendedor.n_padrinos += 1

    end

    # Por último, agregamos a nuestra lista de vendedores, al vendedor recien creado
    @vendedores << vendedor
  end
end