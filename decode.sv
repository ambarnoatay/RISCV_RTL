`include "RISCV_Lib.sv"
module decode
#(
    parameter OUT_WIDTH = 5
)
(
    input logic clk,
    input logic rst,
    input logic [31:0] instr,
    input logic stall_off,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [OUT_WIDTH-1:0] operation,
    output logic [11:0] imm_alu,
    output logic stall_decode

);

    //STALL 
    logic stall;
    //assign stall_decode = stall_off==1'b0?stall:1'b0;
    assign stall_decode = stall;
    always_comb begin
        if(!rst) 
            stall = 1'b0;
        else begin 
            if(stall_off) stall = 1'b0;

        end
    end

    // Internal signals
    logic [2:0] funct3_t;
    logic [6:0] funct7_t;
    logic [11:0] imm;
    logic [9:0] funct_comb;
    logic [OUT_WIDTH-1:0] oper;
    logic [31:0] curr_instr;
    logic [6:0] opcode_t;
    assign opcode_t = curr_instr[6:0];
    // Assign funct_comb based on funct3_t and funct7_t
    assign funct_comb = {funct3_t, funct7_t};

    logic [6:0] imm_high ;
    assign imm_high = curr_instr[31:25];
    //R TYPE
    logic [4:0] rs1_R;
    assign rs1_R = curr_instr[19:15];
    
    logic [4:0] rs2_R ;
    logic [4:0] rd_R ;
    logic [2:0] funct3_R ;
    logic [6:0] funct7_R ;

    assign rs2_R = curr_instr[24:20];
    assign rd_R = curr_instr[11:7];
    assign funct3_R = curr_instr[14:12];
    assign funct7_R = curr_instr[31:25];

    //I TYPE
    logic [4:0] rs1_I ;
    assign rs1_I = curr_instr[19:15];
    logic [4:0] rd_I;
    assign rd_I = curr_instr[11:7];

    logic [2:0] funct3_I ;
    logic [11:0] imm_I ;

    assign funct3_I = curr_instr[14:12];
    assign imm_I = curr_instr[31:20];

    //S TYPE
    logic [4:0] rs1_S ;
    logic [4:0] rs2_S ;
    logic [2:0] funct3_S ;
    logic [11:0] imm_S ;

    assign rs1_S = curr_instr[19:15];
    assign rs2_S = curr_instr[24:20];
    assign funct3_S = curr_instr[14:12];
    assign imm_S = {curr_instr[31:25], curr_instr[11:7]};
    
    //Next instruction
    
    logic [6:0] opcode_nxt;
    assign opcode_nxt = instr[6:0];
     
    logic [4:0] rs1_R_nxt;
    assign rs1_R_nxt = instr[19:15];
    
    logic [4:0] rs2_R_nxt ;
    logic [4:0] rd_R_nxt;

    assign rs2_R_nxt = instr[24:20];
    assign rd_R_nxt = instr[11:7];

    logic [4:0] rs1_I_nxt ;
    assign rs1_I_nxt = instr[19:15];
    logic [4:0] rd_I_nxt;
    assign rd_I_nxt = instr[11:7];

    logic [4:0] rs1_S_nxt ;
    logic [4:0] rs2_S_nxt ;
    assign rs1_S_nxt = instr[19:15];
    assign rs2_S_nxt = instr[24:20];
    always_comb begin
        if(!rst) 
            stall = 1'b1;
        else begin 
            case(opcode_t)
                `R_TYPE: begin
                    case(opcode_nxt)
                        `R_TYPE: if(rd_R == rs1_R_nxt || rd_R == rs2_R_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        `I_TYPE: if(rd_R == rs1_I_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        `S_TYPE: if(rd_R == rs1_S_nxt || rd_R == rs2_S_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        default: stall = 1'b0;
                    endcase
                    end
                `I_TYPE: begin
                    case(opcode_nxt)
                        `R_TYPE: if(rd_I == rs1_R_nxt || rd_I == rs2_R_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        `I_TYPE: if(rd_I == rs1_I_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        `S_TYPE: if(rd_I == rs1_S_nxt || rd_I == rs2_S_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        default: stall = 1'b0;
                    endcase
                    end
                `S_TYPE: begin
                    case(opcode_nxt)
                        `R_TYPE: if(rd_R_nxt == rs1_S || rs2_S == rd_R_nxt) stall = 1'b1;
                                else stall = 1'b0;
                        `I_TYPE: if(rd_I_nxt == rs1_S || rd_I_nxt == rs2_S) stall = 1'b1;
                                else stall = 1'b0;
                        
                        
                        default: stall = 1'b0;
                    endcase
                end
                
                
                default: stall = 1'b0;
            endcase
        end
    end
    // Sequential logic block for resetting and capturing instruction data
    
    always_comb begin
        if (!rst) begin
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd = 5'b0;
            funct3_t = 3'b0;
            funct7_t = 7'b0;
            imm = 12'b0;
            oper = {{(OUT_WIDTH-1){1'b0}}, 1'b0};
            curr_instr = 32'b0;
            //next_instr <= 32'b0;
        end 
        else begin

            //curr_instr = next_instr;
            case (opcode_t)
                `R_TYPE: begin
                    rs1 = rs1_R;
                    rs2 = rs2_R;
                    rd = rd_R;

                    funct3_t = funct3_R;
                    funct7_t = funct7_R;
                    imm = 12'b0; // R-type instructions don't use immediates

//                    $display("time = %d instr =%h opcode = %b funct3_t = %b funct7_t = %b rs2=%b IN R",$time,instr,opcode_t,funct3_t,funct7_t,rs2);
                    
                end
                `I_TYPE: begin

                    rs1 = rs1_I;
                    //$display("instr = %h opcode = %b time = %d rs1=%b IN I",instr,opcode_t,$time,rs1_t);
                    rd = rd_I;
                    funct3_t = funct3_I;
                    imm = imm_I;
                    rs2= 5'b0; // I-type instructions don't use rs2
                end
                `S_TYPE: begin
                    rs1 =  rs1_S;
                    rs2 =  rs2_S;
                    //$display("instr = %h opcode = %b time = %d rs1=%b IN S",opcode_t,instr,$time,rs1_t);
                    funct3_t =  funct3_S;
                    imm =  imm_S;
                    rd = 5'b0; // S-type instructions don't use rd
                end
                default: begin
                    // Default reset values for unsupported instructions
                    rs1 = 5'b0;
                    rs2 = 5'b0;
                    rd = 5'b0;
                    funct3_t = 3'b0;
                    funct7_t = 7'b0;
                    imm = 12'b0;
                end
            endcase
        end
    end
    //LOGIC TO SET NEXT INSTRUCTION
    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            curr_instr <= 32'b0;
        end 
        else if(!stall) begin
            curr_instr <= instr;

        end 

    end        
    // Combinational logic block for decoding operation codes
    always_comb begin
    
        oper = (opcode_t == `R_TYPE) ? (
            (funct_comb == `func_ADD) ? `ADD :
            (funct_comb == `func_SLL) ? `SLL :
            (funct_comb == `func_SLT) ? `SLT :
            (funct_comb == `func_SLTU) ? `SLTU :
            (funct_comb == `func_XOR) ? `XOR :
            (funct_comb == `func_SRL) ? `SRL :
            (funct_comb == `func_OR) ? `OR :
            (funct_comb == `func_AND) ? `AND :
            (funct_comb == `func_SUB) ? `SUB :
            (funct_comb == `func_SRA) ? `SRA :
            (funct_comb == `func_MUL) ? `MUL :
            (funct_comb == `func_DIV) ? `DIV :
            {{(OUT_WIDTH-1){1'b0}}, 1'b0}
        ) : (

            (opcode_t == `I_TYPE) ? (
                (funct3_t == `funct3_ADDI) ? `ADDI :
                (funct3_t == `funct3_SLTI) ? `SLTI :
                (funct3_t == `funct3_SLTIU) ? `SLTIU :
                (funct3_t == `funct3_XORI) ? `XORI :
                (funct3_t == `funct3_ORI) ? `ORI :
                (funct3_t == `funct3_ANDI) ? `ANDI :
                (funct3_t == `funct3_SLLI && imm_high == 7'b0) ? `SLLI :
                (funct3_t == `funct3_SRLI && imm_high == 7'b0) ? `SRLI :
                (funct3_t == `funct3_SRAI && imm_high == 7'b0100000) ? `SRAI :
                {{(OUT_WIDTH-1){1'b0}}, 1'b0}
            ) : (
                (opcode_t == `S_TYPE) ? (
                    (funct3_t == `funct3_SB) ? `SB :
                    (funct3_t == `funct3_SH) ? `SH :
                    (funct3_t == `funct3_SW) ? `SW :
                    {{(OUT_WIDTH-1){1'b0}}, 1'b0}
                ) : {{(OUT_WIDTH-1){1'b0}}, 1'b0}
            )
        );
    
    end
logic [6:0] opc_tmp_CI;
logic [6:0] opc_tmp_NI;
    // Combinational logic to drive output signals
    always_comb begin
        //rs1 = rs1_t;
       // rs2 = rs2_t;
    
      //  rd = rd_t;
        operation = oper;
        imm_alu = imm;
        
        
    end

endmodule
