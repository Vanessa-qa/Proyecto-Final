//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module ShiftLeft
(
    input  [31:0] DataIn,
    output [31:0] DataOut
);

assign DataOut = DataIn << 2;

endmodule