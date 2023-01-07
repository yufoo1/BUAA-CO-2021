import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.MuxCase

class DataPath extends Module {
    val io = IO(new Bundle {
        val WEGRF: UInt = Input(UInt(1.W))
        val WEDM: UInt = Input(UInt(1.W))
        val RegDst: UInt = Input(UInt(2.W))
        val WhichToReg: UInt = Input(UInt(2.W))
        val ALUOp: UInt = Input(UInt(4.W))
        val ALUSrc: UInt = Input(UInt(1.W))
        val IsSignExt: UInt = Input(UInt(1.W))
        val IsBranchType: UInt = Input(UInt(1.W))
        val IsJType: UInt = Input(UInt(1.W))
        val IsJr: UInt = Input(UInt(1.W))
        val instr: UInt = Output(UInt(32.W))
        val IsEq: UInt = Output(UInt(1.W))
    })

    val IFU_Module: IFU = Module(new IFU)
    val NPC_Module: NPC = Module(new NPC)
    val GRF_Module: GRF = Module(new GRF)
    val ALU_Module: ALU = Module(new ALU)
    val DM_Module: DM = Module(new DM)
    val EXT_Module: EXT = Module(new EXT)

    IFU_Module.io.NPC := NPC_Module.io.NPC

    NPC_Module.io.PC := IFU_Module.io.PC
    NPC_Module.io.IsBranchType := io.IsBranchType
    NPC_Module.io.IsJType := io.IsJType
    NPC_Module.io.instr := IFU_Module.io.instr
    NPC_Module.io.IsJr := io.IsJr
    NPC_Module.io.JrAddr := GRF_Module.io.O1
    NPC_Module.io.imm32 := EXT_Module.io.imm32

    val GRFWriteAddr: UInt = MuxCase(0.U, Array((io.RegDst === 0.U) -> IFU_Module.io.instr(15, 11),
                                               (io.RegDst === 1.U) -> IFU_Module.io.instr(20, 16),
                                               (io.RegDst === 2.U) -> 31.U))
    val GRFWrite: UInt = MuxCase(0.U, Array((io.WhichToReg === 0.U) -> ALU_Module.io.O,
                                            (io.WhichToReg === 1.U) -> DM_Module.io.RD,
                                            (io.WhichToReg === 2.U) -> (IFU_Module.io.PC + 4.U)))

    GRF_Module.io.A1 := IFU_Module.io.instr(25, 21)
    GRF_Module.io.A2 := IFU_Module.io.instr(20, 16)
    GRF_Module.io.A3 := GRFWriteAddr
    GRF_Module.io.WE := io.WEGRF
    GRF_Module.io.WD := GRFWrite
    GRF_Module.io.PC := IFU_Module.io.PC

    val ALURead2: UInt = MuxCase(0.U, Array((io.ALUSrc === 0.U) -> GRF_Module.io.O2,
                                            (io.ALUSrc === 1.U) -> EXT_Module.io.imm32))

    ALU_Module.io.A1 := GRF_Module.io.O1
    ALU_Module.io.A2 := ALURead2
    ALU_Module.io.ALUOp := io.ALUOp

    DM_Module.io.Addr := ALU_Module.io.O
    DM_Module.io.WD := GRF_Module.io.O2
    DM_Module.io.WE := io.WEDM
    DM_Module.io.PC := IFU_Module.io.PC

    EXT_Module.io.imm16 := IFU_Module.io.instr(15, 0)
    EXT_Module.io.IsSignEXT := io.IsSignExt

    io.instr := IFU_Module.io.instr
    io.IsEq := ALU_Module.io.IsEq
}


object GenerateDataPath {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/DataPath", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new DataPath)))
    }
}