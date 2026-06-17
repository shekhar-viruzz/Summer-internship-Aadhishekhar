module apb_slave
(
    input  logic        PCLK,
    input  logic        PRESETn,

    input  logic        PSEL,
    input  logic        PENABLE,
    input  logic        PWRITE,

    input  logic [7:0]  PADDR,
    input  logic [31:0] PWDATA,

    output logic [31:0] PRDATA,
    output logic        PREADY,
    output logic        PSLVERR
);

logic [31:0] mem [0:255];

typedef enum logic [1:0]
{
    IDLE,
    SETUP,
    ACCESS
} state_t;

state_t state,next_state;

//------------------------------------------------
// State Register
//------------------------------------------------
always_ff @(posedge PCLK or negedge PRESETn)
begin
    if(!PRESETn)
        state <= IDLE;
    else
        state <= next_state;
end

//------------------------------------------------
// Next State Logic
//------------------------------------------------
always_comb
begin
    next_state = state;

    case(state)

        IDLE:
        begin
            if(PSEL)
                next_state = SETUP;
        end

        SETUP:
        begin
            next_state = ACCESS;
        end

        ACCESS:
        begin
            if(PREADY)
            begin
                if(PSEL)
                    next_state = SETUP;
                else
                    next_state = IDLE;
            end
            else
                next_state = ACCESS;
        end

    endcase
end

//------------------------------------------------
// Output Logic
//------------------------------------------------
always_ff @(posedge PCLK or negedge PRESETn)
begin
    if(!PRESETn)
    begin
        PRDATA  <= 0;
        PREADY  <= 0;
        PSLVERR <= 0;
    end
    else
    begin

        PREADY  <= 0;
        PSLVERR <= 0;

        case(state)

            ACCESS:
            begin

                // wait-state generation
                PREADY <= 1;

                // invalid address
                if(PADDR > 8'hFF)
                begin
                    PSLVERR <= 1;
                end
                else
                begin

                    if(PWRITE)
                    begin
                        mem[PADDR] <= PWDATA;
                    end
                    else
                    begin
                        PRDATA <= mem[PADDR];
                    end

                end
            end

        endcase
    end
end

endmodule
