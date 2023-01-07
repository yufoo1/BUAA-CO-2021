import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class GRF extends Module {
    val io = IO(new Bundle {
        val A1: UInt = Input(UInt(5.W))
        val A2: UInt = Input(UInt(5.W))
        val A3: UInt = Input(UInt(5.W))
        val WE: UInt = Input(UInt(1.W))
        val WD: UInt = Input(UInt(32.W))
        val PC: UInt = Input(UInt(32.W))
        val O1: UInt = Output(UInt(32.W))
        val O2: UInt = Output(UInt(32.W))
    })

    val i: UInt = 0.U
    val reg: Vec[UInt] = Reg(Vec(32, UInt(32.W)))
    when (reset.asBool) {
        for (i <- 0 to 31) {
            reg(i) := 0.U
        }
    } .elsewhen(io.A3 =/= 0.U && io.WE === 1.U) {
        reg(io.A3) := io.WD
        printf(p"@0x${Hexadecimal(io.PC)}: ${io.A3} <= 0x${Hexadecimal(io.WD)}\n")
    }

    io.O1 := reg(io.A1)
    io.O2 := reg(io.A2)
}

object GenerateGRF {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/GRF", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new GRF)))
    }
}