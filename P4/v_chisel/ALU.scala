import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation

class ALU extends Module{

    val io = IO(new Bundle{
        val A1: UInt = Input(UInt(32.W))
        val A2: UInt = Input(UInt(32.W))
        val ALUOp: UInt = Input(UInt(4.W))
        val O: UInt = Output(UInt(32.W))
        val IsEq: UInt = Output(UInt(1.W))
    })

    io.O := 0.U
    switch (io.ALUOp) {
        is (0.U) {
            io.O := io.A1 + io.A2 // ADD
        }
        is (1.U) {
            io.O := io.A1 - io.A2 // SUB
        }
        is (2.U) {
            io.O := io.A1 & io.A2 // AND
        }
        is (3.U) {
            io.O := io.A1 | io.A2 // ORI
        }
        is (4.U) {
            io.O := io.A2 << 16 // LUI
        }
    }

    when (io.A1 === io.A2) {
        io.IsEq := 1.U
    } .otherwise {
        io.IsEq := 0.U
    }

}

object GenerateALU {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/ALU", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new ALU)))
    }
}
