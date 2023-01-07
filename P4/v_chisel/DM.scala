import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class DM extends Module{
    val io = IO(new Bundle {
        val Addr: UInt = Input(UInt(32.W))
        val WD: UInt = Input(UInt(32.W))
        val WE: UInt = Input(UInt(1.W))
        val PC: UInt = Input(UInt(32.W))
        val RD: UInt = Output(UInt(32.W))
    })
    val RAM: Mem[UInt] = Mem(1024, UInt(32.W))
    val i: UInt = 0.U

    when (reset.asBool) {
        for (i <- 0 to 1023) {
            RAM(i) := 0.U
        }
    } .elsewhen(io.WE === 1.U) {
        RAM.write(io.Addr(11, 2), io.WD)
        printf(p"@0x${Hexadecimal(io.PC)}: 0x${Hexadecimal(io.Addr)} <= 0x${Hexadecimal(io.WD)}\n")
    }
    io.RD := RAM.read(io.Addr(11, 2))

}

object GenerateDM {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/DM", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new DM)))
    }
}