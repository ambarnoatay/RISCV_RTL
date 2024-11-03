`define R_TYPE                                                      7'b0110011
`define I_TYPE                                                      7'b0010011
`define S_TYPE                                                      7'b0100011
`define WIDTH                                                       5
`define funct3_ADD                                                  3'b000
`define funct3_SLL                                                  3'b001
`define funct3_SLT                                                  3'b010
`define funct3_SLTU                                                 3'b011
`define funct3_XOR                                                  3'b100
`define funct3_SRL                                                  3'b101
`define funct3_OR                                                   3'b110
`define funct3_AND                                                  3'b111
`define funct3_SUB                                                  3'b000
`define funct3_SRA                                                  3'b101
`define funct3_MUL                                                  3'b000

`define funct3_ADDI                                                 3'b000
`define funct3_SLTI                                                 3'b010
`define funct3_SLTIU                                                3'b011
`define funct3_XORI                                                 3'b100
`define funct3_ORI                                                  3'b110
`define funct3_ANDI                                                 3'b111
`define funct3_SLLI                                                 3'b001
`define funct3_SRLI                                                 3'b101
`define funct3_SRAI                                                 3'b101

`define funct3_LB                                                   3'b000
`define funct3_LH                                                   3'b001
`define funct3_LW                                                   3'b010
`define funct3_LBU                                                  3'b100
`define funct3_LHU                                                  3'b101

`define funct3_SB                                                   3'b000
`define funct3_SH                                                   3'b001
`define funct3_SW                                                   3'b010


`define funct7_SLL                                                  7'b0000000
`define funct7_SRL                                                  7'b0000000
`define funct7_SRA                                                  7'b0100000
`define funct7_ADD                                                  7'b0000000
`define funct7_SUB                                                  7'b0100000
`define funct7_XOR                                                  7'b0000000
`define funct7_AND                                                  7'b0000000
`define funct7_OR                                                   7'b0000000
`define funct7_SLT                                                  7'b0000000
`define funct7_SLTU                                                 7'b0000000
`define funct7_MUL                                                  7'b0000001


`define func_ADD                                                  10'b0000000000
`define func_SLL                                                  10'b0010000000
`define func_SLT                                                  10'b0100000000
`define func_SLTU                                                 10'b0110000000
`define func_XOR                                                  10'b1000000000
`define func_SRL                                                  10'b1010000000
`define func_OR                                                   10'b1100000000
`define func_AND                                                  10'b1110000000
`define func_SUB                                                  10'b0000100000
`define func_SRA                                                  10'b1010100000
`define func_MUL                                                  10'b0000000001
`define func_DIV                                                  10'b1000000001    

`define func_SLLI                                                 {funct3_SLLI,7'b0}
`define func_SRLI                                                 {funct3_SRLI,7'b0}
`define func_SRAI                                                 {funct3_SRAI,7'b0100000}





`define ADD                                                        5'b11110
`define SLL                                                         5'b00001
`define SLT                                                        5'b00010
`define SLTU                                                       5'b00011
`define XOR                                                        5'b00100
`define SRL                                                        5'b00101
`define OR                                                         5'b00110
`define AND                                                        5'b00111
`define SUB                                                        5'b01000
`define SRA                                                        5'b01001
`define ADDI                                                       5'b01010
`define SLTI                                                       5'b01011
`define SLTIU                                                      5'b01100
`define XORI                                                       5'b01101
`define ORI                                                        5'b01110
`define ANDI                                                       5'b01111
`define SLLI                                                       5'b10000
`define SRLI                                                       5'b10001
`define SRAI                                                       5'b10010
`define LB                                                         5'b10011
`define LH                                                         5'b10100
`define LW                                                         5'b10101
`define LBU                                                        5'b10110
`define LHU                                                        5'b10111
`define SB                                                         5'b11000
`define SH                                                         5'b11001
`define SW                                                         5'b11010
`define MUL                                                        5'b11011
`define DIV                                                        5'b11100