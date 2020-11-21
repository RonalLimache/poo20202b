class Colaborador
    attr_reader :documento, :nombreCompleto, :edad
 
    def initialize(documento, nombreCompleto, edad)
          @documento = documento
          @nombreCompleto = nombreCompleto
          @edad = edad
    end
    def calcularSueldo
    end
    def imprimirColaborador
    end
 end
 class Medico < Colaborador
     attr_reader :especialidad, :horasExtras
     def initialize(documento, nombreCompleto, edad, especialidad, horasExtras)
         super(documento, nombreCompleto, edad)
         @especialidad = especialidad
         @horasExtras = horasExtras
     end
     def calcularSueldo
         calcularSueldoBase + (horasExtras * 60)
     end
     def imprimirColaborador
        puts "Documento: #{documento} - Nombre Completo: #{nombreCompleto} - Edad: #{edad} " +
            " - Especialidad: #{especialidad} - Horas extras: #{horasExtras} - Sueldo: #{calcularSueldo}"
     end
     def calcularSueldoBase
        sueldoBase = 1500

        if especialidad == "Medicina General"
            sueldoBase += 3500
        elsif especialidad == "Neumología"
            sueldoBase += 4500
        elsif especialidad == "Dermatología"
            sueldoBase += 5500
        elsif especialidad == "Hematología"
            sueldoBase += 6500
        elsif especialidad == "Cardiología"
            sueldoBase += 6900
        end

        return sueldoBase
     end
 end
 class Enfermero < Colaborador
     attr_reader :comisiones
     def initialize(documento, nombreCompleto, edad, comisiones)
        super(documento, nombreCompleto, edad)
         @comisiones = comisiones
     end
     def calcularSueldo
         1900 + comisiones
     end
    def imprimirColaborador
        puts "Documento: #{documento} - Nombre Completo: #{nombreCompleto} - Edad: #{edad} " +
            " - Comisiones: #{comisiones} - Sueldo: #{calcularSueldo}"
    end
 end
 
 class Administrador
    attr_reader :arregloColaboradores
    def initialize
        @arregloColaboradores = []
    end
    def registrar(colaborador)
        arregloColaboradores.push(colaborador)
    end
    def obtenerColaborador(numeroDocumento)
        colaborador = nil

        for item in arregloColaboradores
            if(item.documento == numeroDocumento)
                colaborador = item
            end
        end

        return colaborador
    end
    def imprimirColaborador(numeroDocumento)
        colaborador = obtenerColaborador(numeroDocumento)
        colaborador.imprimirColaborador
    end
    def calcularSumaSueldo
        sumaSueldo = 0
        for colaborador in arregloColaboradores
            sumaSueldo += colaborador.calcularSueldo
        end

        return sumaSueldo
    end
    def obtenerMedicoMejorPagado
        medico = nil;
        mayorSueldo = 0
        for colaborador in arregloColaboradores
            if colaborador.class == Medico && colaborador.calcularSueldo > mayorSueldo
                mayorSueldo = colaborador.calcularSueldo
                medico = colaborador
            end
        end

        return medico
    end
    def obtenerEnfermeroPeorPagado
        enfermero = nil;
        menorSueldo = 0
        for colaborador in arregloColaboradores
            #Podría hacerlo con un do...while
            if(menorSueldo == 0)
                menorSueldo = colaborador.calcularSueldo
            end

            if colaborador.class == Enfermero && colaborador.calcularSueldo < menorSueldo
                menorSueldo = colaborador.calcularSueldo
                enfermero = colaborador
            end
        end

        return enfermero
    end
 end
 ###############
 
 puts "Pregunta A"
 medico1 = Medico.new("00001000", "Jorge Rodriguez", 57, "Neumología", 5)
 medico2 = Medico.new("00002000", "Maria Céspedes", 60, "Hematología", 2)
 medico3 = Medico.new("00003000", "Rocío Samanez", 39, "Medicina general", 0)
 medico4 = Medico.new("00004000", "Julio Pinedo", 30, "Cardiología", 10)

 enfermero1 = Enfermero.new("00005000", "Elizabeth Gonzales", 26, 2000)
 enfermero2 = Enfermero.new("00006000", "Alonso Carpio", 60, 1200)
 enfermero3 = Enfermero.new("00007000", "Teddy Inocente", 39, 980)
 enfermero4 = Enfermero.new("00008000", "Joel Chunga", 30, 1000)
 
 admin = Administrador.new
 admin.registrar(medico1)
 admin.registrar(medico2)
 admin.registrar(medico3)
 admin.registrar(medico4)
 admin.registrar(enfermero1)
 admin.registrar(enfermero2)
 admin.registrar(enfermero3)
 admin.registrar(enfermero4)
 puts "¡Colaboradores Registrados!"
 
 puts "Pregunta B"
puts "Cantidad de Colaboradores: #{admin.arregloColaboradores.length}"

 puts "Pregunta C"
print("Ingrese Documento: ")
numeroDocumento = gets.chomp.to_s
admin.imprimirColaborador(numeroDocumento)

 puts "Pregunta D"
puts "Suma de Sueldos: #{admin.calcularSumaSueldo}"

 puts "Pregunta E"
medico = admin.obtenerMedicoMejorPagado
puts "Médico mejor pagado:"
medico.imprimirColaborador

 puts "Pregunta F"
 puts "Enfermero peor pagado:"
 enfermero = admin.obtenerEnfermeroPeorPagado
enfermero.imprimirColaborador