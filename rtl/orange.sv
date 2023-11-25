`include "../rtl/reg_file.sv"
`include "../rtl/data_memory.sv"
`include "../rtl/alu.sv"

module orange #(
    parameter DATA_WIDTH = 32
) (
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [DATA_WIDTH-1:0] ImmExt,
    input logic [DATA_WIDTH-1:0] PCPlus4,
    input logic clk,
    input logic AluSrc,
    input logic [2:0] ALUControl,
    input logic MemWrite,
    input logic [1:0] ResultSrc,
    input logic shift_right_type,
    output logic zero,
);

    logic [DATA_WIDTH-1:0] ALUresult;
    logic [DATA_WIDTH-1:0] ReadData;
    logic [DATA_WIDTH-1:0] RD2;
    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Reg_DATA_IN;

    always_comb begin
        case(ResultSrc)
            2'b00: Reg_DATA_IN = ALUresult;
            2'b01: Reg_DATA_IN = ReadData;
            2'b10: Reg_DATA_IN = PCPlus4;   // need to have option of adding pc + 4 to ra
        endcase
    end

    reg_file RegFile(
        // inputs
        .clk(clk),
        .AD1(rs1),
        .AD2(rs2),
        .AD3(rd),
        .WD3(Reg_DATA_IN),

        // outputs
        .RD1(SrcA),
        .RD2(RD2)
    );

    alu ALU(
        // inputs
        .ALUControl(ALUControl),
        .SRCA(SrcA),
        .SRCB(AluSrc ? ImmExt : RD2),
        .shift_right_type(shift_right_type),

        // outputs
        .zero(zero),
        .ALUresult(ALUresult)
    );

    data_mem DATA_MEMORY(
        // inputs
        .clk(clk),
        .WE(MemWrite),
        .addr(ALUresult),

        // outputs
        .RD(ReadData)
    );
    
endmodule