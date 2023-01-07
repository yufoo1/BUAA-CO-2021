import chisel3.DontCare.<>
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class MIPS extends Module {
    val CU_Module: CU = Module(new CU)
    val DataPath_Module: DataPath = Module(new DataPath)
    CU_Module.io <> DataPath_Module.io
}

object GenerateMIPS {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/MIPS", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new MIPS)))
    }
}