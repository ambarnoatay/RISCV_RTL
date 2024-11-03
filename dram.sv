module dram #(
    parameter ADDR_WIDTH = 12,  // Address width
    parameter DATA_WIDTH = 32   // Data width
)(
    input logic clk,            // Clock
    input logic reset,          // Reset
    input logic wr_en,          // Write enable
    input logic rd_en,          // Read enable
    input logic [ADDR_WIDTH-1:0] addr, // Address
    input logic [DATA_WIDTH-1:0] wdata, // Write data
    output logic [DATA_WIDTH-1:0] rdata  // Read data
);

    // Memory array
    logic [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    // Read and write operations
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Optionally initialize memory or handle reset
        end else begin
            if (wr_en) begin
                mem[addr] <= wdata;
            end
        end
    end

    always_comb begin
        if (rd_en) begin
            rdata = mem[addr];
        end else begin
            rdata = '0;
        end
    end

endmodule