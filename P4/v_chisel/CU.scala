import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class CU extends Module {
    val io = IO(new Bundle {
        val instr: UInt = Input(UInt(32.W))
        val IsEq: UInt = Input(UInt(1.W))
        val ALUOp: UInt = Output(UInt(4.W))
        val WEGRF: UInt = Output(UInt(1.W))
        val WEDM: UInt = Output(UInt(1.W))
        val IsBranchType: UInt = Output(UInt(1.W))
        val IsJType: UInt = Output(UInt(1.W))
        val IsJr: UInt = Output(UInt(1.W))
        val ALUSrc: UInt = Output(UInt(1.W))
        val WhichToReg: UInt = Output(UInt(2.W))
        val RegDst: UInt = Output(UInt(2.W))
        val IsSignExt: UInt = Output(UInt(1.W))
    })

    val op: UInt = io.instr(31, 26)
    val func: UInt = io.instr(5, 0)
    val addu, subu, ori, lw, sw, beq, lui, j, jal, jr, RType = Wire(UInt(1.W))



    when (op === 0.U) {
        RType := 1.U
    } .otherwise {
        RType := 0.U
    }

    when (RType === 1.U && func === "b100001".U) {
        addu := 1.U
    } .otherwise {
        addu := 0.U
    }

    when (RType === 1.U && func === "b100011".U) {
        subu := 1.U
    } .otherwise {
        subu := 0.U
    }

    when (op === "b001101".U) {
        ori := 1.U
    } .otherwise {
        ori := 0.U
    }

    when (op === "b100011".U) {
        lw := 1.U
    } .otherwise {
        lw := 0.U
    }

    when (op === "b101011".U) {
        sw := 1.U
    } .otherwise {
        sw := 0.U
    }

    when (op === "b000100".U) {
        beq := 1.U
    } .otherwise {
        beq := 0.U
    }

    when (op === "b001111".U) {
        lui := 1.U
    } .otherwise {
        lui := 0.U
    }

    when (op === "b000010".U) {
        j := 1.U
    } .otherwise {
        j := 0.U
    }

    when (op === "b000011".U) {
        jal := 1.U
    } .otherwise {
        jal := 0.U
    }

    when (RType === 1.U && func === "b001000".U) {
        jr := 1.U
    } .otherwise {
        jr := 0.U
    }

    when (subu === 1.U) {
        io.ALUOp := 1.U
    } .elsewhen (ori === 1.U) {
        io.ALUOp := 3.U
    } .elsewhen (lui === 1.U) {
        io.ALUOp := 4.U
    } .otherwise {
        io.ALUOp := 0.U
    }

    when ((addu | subu | ori | lw | lui | jal) === 1.U) {
        io.WEGRF := 1.U
    } .otherwise {
        io.WEGRF := 0.U
    }

    when (sw === 1.U) {
        io.WEDM := 1.U
    } .otherwise {
        io.WEDM := 0.U
    }

    when ((beq & io.IsEq) === 1.U) {
        io.IsBranchType := 1.U
    } .otherwise {
        io.IsBranchType := 0.U
    }

    when ((j | jal) === 1.U) {
        io.IsJType := 1.U
    } .otherwise {
        io.IsJType := 0.U
    }

    when (jr === 1.U) {
        io.IsJr := 1.U
    } .otherwise {
        io.IsJr := 0.U
    }

    when ((ori | lui | lw | sw) === 1.U) {
        io.ALUSrc := 1.U
    } .otherwise {
        io.ALUSrc := 0.U
    }

    when (lw === 1.U) {
        io.WhichToReg := 1.U
    } .elsewhen (jal === 1.U) {
        io.WhichToReg := 2.U
    } .otherwise {
        io.WhichToReg := 0.U
    }

    when ((ori | lui | lw) === 1.U) {
        io.RegDst := 1.U
    } .elsewhen (jal === 1.U) {
        io.RegDst := 2.U
    } .otherwise {
        io.RegDst := 0.U
    }

    when ((beq | lw | sw) === 1.U) {
        io.IsSignExt := 1.U
    } .otherwise {
        io.IsSignExt := 0.U
    }

}

object GenerateCU {
    def main(args: Array[String]): Unit = {
        println("The module is generating...")
        (new chisel3.stage.ChiselStage).execute(
            Array("--target-dir", "generated/CU", "verilog"),
            Seq(ChiselGeneratorAnnotation(() => new CU)))
    }
}