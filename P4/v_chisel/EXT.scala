import Chisel.Cat
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class EXT extends Module {
    val io = IO(new Bundle {
        val imm16: UInt = Input(UInt(16.W))
        val IsSignEXT: UInt = Input(UInt(1.W))
        val imm32: UInt = Output(UInt(32.W))
    })
    io.imm32 := 0.U
    when (io.IsSignEXT === 1.U && io.imm16(15) === 1.U) {
        io.imm32 := Cat("hffff".U(16.W), io.imm16)
    } .otherwise {
        io.imm32 := Cat(0.U(16.W), io.imm16)
    }
}

object GenerateEXT {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/EXT", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new EXT)))
    }
}