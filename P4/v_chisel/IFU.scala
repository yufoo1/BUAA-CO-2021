import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.experimental.{loadMemoryFromFile, loadMemoryFromFileInline}


class IFU extends Module{
    val io = IO(new Bundle {
        val NPC: UInt = Input(UInt(32.W))
        val instr: UInt = Output(UInt(32.W))
        val PC: UInt = Output(UInt(32.W))
    })
    val ROM: Mem[UInt] = Mem(1024, UInt(32.W)) // asynchronous read
//    val ROM: SyncReadMem[UInt] = SyncReadMem(1024, UInt(32.W))  Synchronous read
    val r_PC = Reg(UInt(32.W))

    when (reset.asBool) {
        loadMemoryFromFileInline(ROM, "code.txt")
        printf(p"load successfully!")
        r_PC := "h3000".U
    } .otherwise {
        r_PC := io.NPC
    }
    io.PC := r_PC
    io.instr := ROM.read(io.PC(11, 2))

}

object GenerateIFU {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/IFU", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new IFU)))
    }
}