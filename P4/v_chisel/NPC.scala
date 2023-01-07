import Chisel.Cat
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class NPC extends Module{
    val io = IO(new Bundle {
        val PC: UInt = Input(UInt(32.W))
        val IsBranchType: UInt = Input(UInt(1.W))
        val IsJType: UInt = Input(UInt(1.W))
        val instr: UInt = Input(UInt(32.W))
        val IsJr: UInt = Input(UInt(1.W))
        val JrAddr: UInt = Input(UInt(32.W))
        val imm32: UInt = Input(UInt(32.W))
        val NPC: UInt = Output(UInt(32.W))
    })

    when (io.IsBranchType === 1.U){
        io.NPC := io.PC + 4.U + (io.imm32 << 2.U)
    } .elsewhen (io.IsJType === 1.U) {
        io.NPC := Cat(io.PC(31, 28), io.instr(25, 0), 0.U(2.W))
    } .elsewhen (io.IsJr === 1.U) {
        io.NPC := io.JrAddr
    } .otherwise {
        io.NPC := io.PC + 4.U
    }
}

object GenerateNPC {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/NPC", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new NPC)))
    }
}
