class Dispensadora
    attr_reader :codigoUnico, :numeroSerie, :numeroBandejas, :numeroCanales

    def initialize(codigoUnico, numeroSerie, numeroBandejas, numeroCanales)
        @codigoUnico = codigoUnico
        @numeroSerie = numeroSerie
        @numeroBandejas = numeroBandejas
        @numeroCanales = numeroCanales
    end
    def obtenerCapacidadTotal
    end
    def imprimir
    end
end

class ModeloAmericano < Dispensadora
    attr_reader :aceptaTarjeta
    def initialize(codigoUnico, numeroSerie, numeroBandejas, numeroCanales, aceptaTarjeta)
        super(codigoUnico, numeroSerie, numeroBandejas, numeroCanales)
        @aceptaTarjeta = aceptaTarjeta
    end
    def capacidadCanal
        numeroCanales * 20
    end
    def estimarTotalVenta
        obtenerCapacidadTotal * 3 * (aceptaTarjeta ? 1.25 : 1.00)
    end
    def obtenerCapacidadTotal
        numeroBandejas * numeroCanales * capacidadCanal
    end
    def imprimir
        puts "Código: #{codigoUnico} - Serie: #{numeroSerie} - Bandejas: #{numeroBandejas} " +
            " - Canales: #{numeroCanales} - Capacidad: #{obtenerCapacidadTotal} - ¿Acepta Tarjeta?: #{aceptaTarjeta ? "Sí" : "No"}"
    end
end

class ModeloNacional < Dispensadora
    attr_reader :colorExterior
    def initialize(codigoUnico, numeroSerie, numeroBandejas, numeroCanales, colorExterior)
        super(codigoUnico, numeroSerie, numeroBandejas, numeroCanales)
        @colorExterior = colorExterior
    end
    def capacidadCanal
        numeroCanales * 10
    end
    def obtenerCapacidadTotal
        numeroBandejas * numeroCanales * capacidadCanal
    end
    def imprimir
        puts "Código: #{codigoUnico} - Serie: #{numeroSerie} - Bandejas: #{numeroBandejas} " +
            " - Canales: #{numeroCanales} - Capacidad: #{obtenerCapacidadTotal} - Color: #{colorExterior}"
    end
end

class Administrador
    attr_reader :arregloDispensadoras
    def initialize
        @arregloDispensadoras = []
    end
    def registrar(dispensadora)
        arregloDispensadoras.push(dispensadora)
    end
    def imprimirDispensadora
        for dispensadora in arregloDispensadoras
            dispensadora.imprimir
        end
    end
    def obtenerPromedioCapacidad
        sumaCapacidadTotal = 0
        for dispensadora in arregloDispensadoras
            sumaCapacidadTotal += dispensadora.obtenerCapacidadTotal
        end

        return (sumaCapacidadTotal * 1.0) / arregloDispensadoras.length
    end
    def listarEstimadoVenta
        for dispensadora in arregloDispensadoras
            if dispensadora.class == ModeloAmericano
                puts "Código: #{dispensadora.codigoUnico} - Estimado de Venta: #{dispensadora.estimarTotalVenta}"
            else
                puts "Funcionalidad no incluida en la máquina de código #{dispensadora.codigoUnico}"
            end
        end
    end
 end

 puts "Pregunta A"
 #codigoUnico, numeroSerie, numeroBandejas, numeroCanales, aceptaTarjeta
 americana1 = ModeloAmericano.new("001", "991", 5, 1, true)
 americana2 = ModeloAmericano.new("002", "992", 2, 1, false)
 americana3 = ModeloAmericano.new("003", "993", 4, 3, true)

 #codigoUnico, numeroSerie, numeroBandejas, numeroCanales, colorExterior
 nacional1 = ModeloNacional.new("004", "994", 1, 2, "Verde")
 nacional2 = ModeloNacional.new("005", "995", 7, 1, "Azul")
 nacional3 = ModeloNacional.new("006", "996", 3, 1, "Amarillo")

 admin = Administrador.new
 admin.registrar(americana1)
 admin.registrar(americana2)
 admin.registrar(americana3)
 admin.registrar(nacional1)
 admin.registrar(nacional2)
 admin.registrar(nacional3)
 puts "¡Dispensadoras Registradas!"

 puts "Pregunta B"
 admin.imprimirDispensadora

 puts "Pregunta C"
 puts "Promedio de Capacidad Total: #{admin.obtenerPromedioCapacidad}"

 puts "Pregunta D"
 admin.listarEstimadoVenta
