// RGB cycle

module mp1(
    input logic     clk,
    output logic    RGB_R,
    output logic    RGB_G,
    output logic    RGB_B
);

    // CLK frequency is 12MHz, so 2,000,000 CLK cycles is 1/6 of a second
    parameter COLOR_INTERVAL = 2000000;

    // LED timer
    logic [$clog2(COLOR_INTERVAL) - 1:0] count = 0;

    // RGB states
    logic [2:0] index = 0;

    // LED states
    logic red, green, blue;

    initial begin
        red = 1'b0;
        green = 1'b0;
        blue = 1'b0;
    end

    always_ff @(posedge clk) begin
        if (count == COLOR_INTERVAL - 1) begin
            count <= 0;
            index <= (index == 5) ? 0 : index + 1;
        end

        else begin
            count <= count + 1;
        end
    end

    always_comb begin
        case (index)
            // RED
            3'b000 : begin
                red = 1'b1;
                green = 1'b0;
                blue = 1'b0;
            end
            // YELLOW
            3'b001 : begin
                red = 1'b1;
                green = 1'b1;
                blue = 1'b0;
            end
            // GREEN
            3'b010 : begin
                red = 1'b0;
                green = 1'b1;
                blue = 1'b0;
            end
            // CYAN
            3'b011 : begin
                red = 1'b0;
                green = 1'b1;
                blue = 1'b1;
            end
            // BLUE
            3'b100 : begin
                red = 1'b0;
                green = 1'b0;
                blue = 1'b1;
            end
            // MAGENTA
            3'b101 : begin
                red = 1'b1;
                green = 1'b0;
                blue = 1'b1;
            end
            // default: all off
            default: begin
                red = 1'b0;
                green = 1'b0;
                blue = 1'b0;
            end
        endcase

    end

    assign RGB_R = ~red;
    assign RGB_G = ~green;
    assign RGB_B = ~blue;


endmodule
