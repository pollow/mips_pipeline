module PipeIF(input clk, input reset,
    input [1:0] io_pcsource,
    input [31:0] io_bpc,
    input [31:0] io_jpc,
    input [31:0] io_jrpc,
    input  io_stall,
    input  io_brt,
    input [31:0] io_imem,
    output[31:0] io_inst,
    output[31:0] io_pc
);

  reg [31:0] pc_r;
  wire[31:0] T12;
  wire[31:0] T0;
  wire[31:0] next_pc;
  wire[31:0] T1;
  wire[31:0] T2;
  wire[31:0] T3;
  wire[31:0] T4;
  wire T5;
  wire T6;
  wire T7;
  wire[31:0] pc_plus_4;
  wire T8;
  wire T9;
  wire[31:0] T10;
  reg [31:0] inst_r;
  wire[31:0] T13;
  wire[31:0] T11;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    pc_r = {1{$random}};
    inst_r = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_pc = pc_r;
  assign T12 = reset ? 32'h0 : T0;
  assign T0 = T9 ? next_pc : pc_r;
  assign next_pc = T1;
  assign T1 = T8 ? pc_plus_4 : T2;
  assign T2 = T7 ? io_jpc : T3;
  assign T3 = T6 ? io_bpc : T4;
  assign T4 = T5 ? io_jrpc : pc_plus_4;
  assign T5 = io_pcsource == 2'h3;
  assign T6 = io_pcsource == 2'h1;
  assign T7 = io_pcsource == 2'h2;
  assign pc_plus_4 = pc_r + 32'h4;
  assign T8 = io_pcsource == 2'h0;
  assign T9 = io_stall ^ 1'h1;
  assign io_inst = T10;
  assign T10 = io_brt ? 32'h0 : inst_r;
  assign T13 = reset ? 32'h0 : T11;
  assign T11 = T9 ? io_imem : inst_r;

  always @(posedge clk) begin
    if(reset) begin
      pc_r <= 32'h0;
    end else if(T9) begin
      pc_r <= next_pc;
    end
    if(reset) begin
      inst_r <= 32'h0;
    end else if(T9) begin
      inst_r <= io_imem;
    end
  end
endmodule

module RegisterFile(input clk, input reset,
    input [4:0] io_addr_a,
    output[31:0] io_data_a,
    input [4:0] io_addr_b,
    output[31:0] io_data_b,
    input [4:0] io_addr_t,
    output[31:0] io_data_t,
    input [4:0] io_addr_w,
    input [31:0] io_data_w,
    input  io_wen,
    output[1023:0] io_regs
);

  wire[1023:0] T0;
  wire[1023:0] T1;
  wire[511:0] T2;
  wire[255:0] T3;
  wire[127:0] T4;
  wire[63:0] T5;
  reg [31:0] regfile_0;
  wire[31:0] T325;
  wire[31:0] T6;
  wire T7;
  wire T8;
  wire[31:0] T9;
  wire[4:0] T10;
  wire T11;
  wire T12;
  reg [31:0] regfile_1;
  wire[31:0] T326;
  wire[31:0] T13;
  wire T14;
  wire T15;
  wire[63:0] T16;
  reg [31:0] regfile_2;
  wire[31:0] T327;
  wire[31:0] T17;
  wire T18;
  wire T19;
  reg [31:0] regfile_3;
  wire[31:0] T328;
  wire[31:0] T20;
  wire T21;
  wire T22;
  wire[127:0] T23;
  wire[63:0] T24;
  reg [31:0] regfile_4;
  wire[31:0] T329;
  wire[31:0] T25;
  wire T26;
  wire T27;
  reg [31:0] regfile_5;
  wire[31:0] T330;
  wire[31:0] T28;
  wire T29;
  wire T30;
  wire[63:0] T31;
  reg [31:0] regfile_6;
  wire[31:0] T331;
  wire[31:0] T32;
  wire T33;
  wire T34;
  reg [31:0] regfile_7;
  wire[31:0] T332;
  wire[31:0] T35;
  wire T36;
  wire T37;
  wire[255:0] T38;
  wire[127:0] T39;
  wire[63:0] T40;
  reg [31:0] regfile_8;
  wire[31:0] T333;
  wire[31:0] T41;
  wire T42;
  wire T43;
  reg [31:0] regfile_9;
  wire[31:0] T334;
  wire[31:0] T44;
  wire T45;
  wire T46;
  wire[63:0] T47;
  reg [31:0] regfile_10;
  wire[31:0] T335;
  wire[31:0] T48;
  wire T49;
  wire T50;
  reg [31:0] regfile_11;
  wire[31:0] T336;
  wire[31:0] T51;
  wire T52;
  wire T53;
  wire[127:0] T54;
  wire[63:0] T55;
  reg [31:0] regfile_12;
  wire[31:0] T337;
  wire[31:0] T56;
  wire T57;
  wire T58;
  reg [31:0] regfile_13;
  wire[31:0] T338;
  wire[31:0] T59;
  wire T60;
  wire T61;
  wire[63:0] T62;
  reg [31:0] regfile_14;
  wire[31:0] T339;
  wire[31:0] T63;
  wire T64;
  wire T65;
  reg [31:0] regfile_15;
  wire[31:0] T340;
  wire[31:0] T66;
  wire T67;
  wire T68;
  wire[511:0] T69;
  wire[255:0] T70;
  wire[127:0] T71;
  wire[63:0] T72;
  reg [31:0] regfile_16;
  wire[31:0] T341;
  wire[31:0] T73;
  wire T74;
  wire T75;
  reg [31:0] regfile_17;
  wire[31:0] T342;
  wire[31:0] T76;
  wire T77;
  wire T78;
  wire[63:0] T79;
  reg [31:0] regfile_18;
  wire[31:0] T343;
  wire[31:0] T80;
  wire T81;
  wire T82;
  reg [31:0] regfile_19;
  wire[31:0] T344;
  wire[31:0] T83;
  wire T84;
  wire T85;
  wire[127:0] T86;
  wire[63:0] T87;
  reg [31:0] regfile_20;
  wire[31:0] T345;
  wire[31:0] T88;
  wire T89;
  wire T90;
  reg [31:0] regfile_21;
  wire[31:0] T346;
  wire[31:0] T91;
  wire T92;
  wire T93;
  wire[63:0] T94;
  reg [31:0] regfile_22;
  wire[31:0] T347;
  wire[31:0] T95;
  wire T96;
  wire T97;
  reg [31:0] regfile_23;
  wire[31:0] T348;
  wire[31:0] T98;
  wire T99;
  wire T100;
  wire[255:0] T101;
  wire[127:0] T102;
  wire[63:0] T103;
  reg [31:0] regfile_24;
  wire[31:0] T349;
  wire[31:0] T104;
  wire T105;
  wire T106;
  reg [31:0] regfile_25;
  wire[31:0] T350;
  wire[31:0] T107;
  wire T108;
  wire T109;
  wire[63:0] T110;
  reg [31:0] regfile_26;
  wire[31:0] T351;
  wire[31:0] T111;
  wire T112;
  wire T113;
  reg [31:0] regfile_27;
  wire[31:0] T352;
  wire[31:0] T114;
  wire T115;
  wire T116;
  wire[127:0] T117;
  wire[63:0] T118;
  reg [31:0] regfile_28;
  wire[31:0] T353;
  wire[31:0] T119;
  wire T120;
  wire T121;
  reg [31:0] regfile_29;
  wire[31:0] T354;
  wire[31:0] T122;
  wire T123;
  wire T124;
  wire[63:0] T125;
  reg [31:0] regfile_30;
  wire[31:0] T355;
  wire[31:0] T126;
  wire T127;
  wire T128;
  reg [31:0] regfile_31;
  wire[31:0] T356;
  wire[31:0] T129;
  wire T130;
  wire T131;
  wire[31:0] T132;
  wire[31:0] T133;
  wire[31:0] T134;
  wire[31:0] T135;
  wire[31:0] T136;
  wire T137;
  wire[4:0] T138;
  wire[31:0] T139;
  wire T140;
  wire T141;
  wire[31:0] T142;
  wire[31:0] T143;
  wire T144;
  wire[31:0] T145;
  wire T146;
  wire T147;
  wire T148;
  wire[31:0] T149;
  wire[31:0] T150;
  wire[31:0] T151;
  wire T152;
  wire[31:0] T153;
  wire T154;
  wire T155;
  wire[31:0] T156;
  wire[31:0] T157;
  wire T158;
  wire[31:0] T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire[31:0] T164;
  wire[31:0] T165;
  wire[31:0] T166;
  wire[31:0] T167;
  wire T168;
  wire[31:0] T169;
  wire T170;
  wire T171;
  wire[31:0] T172;
  wire[31:0] T173;
  wire T174;
  wire[31:0] T175;
  wire T176;
  wire T177;
  wire T178;
  wire[31:0] T179;
  wire[31:0] T180;
  wire[31:0] T181;
  wire T182;
  wire[31:0] T183;
  wire T184;
  wire T185;
  wire[31:0] T186;
  wire[31:0] T187;
  wire T188;
  wire[31:0] T189;
  wire T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire[31:0] T195;
  wire[31:0] T196;
  wire[31:0] T197;
  wire[31:0] T198;
  wire[31:0] T199;
  wire[31:0] T200;
  wire T201;
  wire[4:0] T202;
  wire[31:0] T203;
  wire T204;
  wire T205;
  wire[31:0] T206;
  wire[31:0] T207;
  wire T208;
  wire[31:0] T209;
  wire T210;
  wire T211;
  wire T212;
  wire[31:0] T213;
  wire[31:0] T214;
  wire[31:0] T215;
  wire T216;
  wire[31:0] T217;
  wire T218;
  wire T219;
  wire[31:0] T220;
  wire[31:0] T221;
  wire T222;
  wire[31:0] T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire[31:0] T228;
  wire[31:0] T229;
  wire[31:0] T230;
  wire[31:0] T231;
  wire T232;
  wire[31:0] T233;
  wire T234;
  wire T235;
  wire[31:0] T236;
  wire[31:0] T237;
  wire T238;
  wire[31:0] T239;
  wire T240;
  wire T241;
  wire T242;
  wire[31:0] T243;
  wire[31:0] T244;
  wire[31:0] T245;
  wire T246;
  wire[31:0] T247;
  wire T248;
  wire T249;
  wire[31:0] T250;
  wire[31:0] T251;
  wire T252;
  wire[31:0] T253;
  wire T254;
  wire T255;
  wire T256;
  wire T257;
  wire T258;
  wire T259;
  wire[31:0] T260;
  wire[31:0] T261;
  wire[31:0] T262;
  wire[31:0] T263;
  wire[31:0] T264;
  wire[31:0] T265;
  wire T266;
  wire[4:0] T267;
  wire[31:0] T268;
  wire T269;
  wire T270;
  wire[31:0] T271;
  wire[31:0] T272;
  wire T273;
  wire[31:0] T274;
  wire T275;
  wire T276;
  wire T277;
  wire[31:0] T278;
  wire[31:0] T279;
  wire[31:0] T280;
  wire T281;
  wire[31:0] T282;
  wire T283;
  wire T284;
  wire[31:0] T285;
  wire[31:0] T286;
  wire T287;
  wire[31:0] T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  wire[31:0] T293;
  wire[31:0] T294;
  wire[31:0] T295;
  wire[31:0] T296;
  wire T297;
  wire[31:0] T298;
  wire T299;
  wire T300;
  wire[31:0] T301;
  wire[31:0] T302;
  wire T303;
  wire[31:0] T304;
  wire T305;
  wire T306;
  wire T307;
  wire[31:0] T308;
  wire[31:0] T309;
  wire[31:0] T310;
  wire T311;
  wire[31:0] T312;
  wire T313;
  wire T314;
  wire[31:0] T315;
  wire[31:0] T316;
  wire T317;
  wire[31:0] T318;
  wire T319;
  wire T320;
  wire T321;
  wire T322;
  wire T323;
  wire T324;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regfile_0 = {1{$random}};
    regfile_1 = {1{$random}};
    regfile_2 = {1{$random}};
    regfile_3 = {1{$random}};
    regfile_4 = {1{$random}};
    regfile_5 = {1{$random}};
    regfile_6 = {1{$random}};
    regfile_7 = {1{$random}};
    regfile_8 = {1{$random}};
    regfile_9 = {1{$random}};
    regfile_10 = {1{$random}};
    regfile_11 = {1{$random}};
    regfile_12 = {1{$random}};
    regfile_13 = {1{$random}};
    regfile_14 = {1{$random}};
    regfile_15 = {1{$random}};
    regfile_16 = {1{$random}};
    regfile_17 = {1{$random}};
    regfile_18 = {1{$random}};
    regfile_19 = {1{$random}};
    regfile_20 = {1{$random}};
    regfile_21 = {1{$random}};
    regfile_22 = {1{$random}};
    regfile_23 = {1{$random}};
    regfile_24 = {1{$random}};
    regfile_25 = {1{$random}};
    regfile_26 = {1{$random}};
    regfile_27 = {1{$random}};
    regfile_28 = {1{$random}};
    regfile_29 = {1{$random}};
    regfile_30 = {1{$random}};
    regfile_31 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_regs = T0;
  assign T0 = T1;
  assign T1 = {T69, T2};
  assign T2 = {T38, T3};
  assign T3 = {T23, T4};
  assign T4 = {T16, T5};
  assign T5 = {regfile_1, regfile_0};
  assign T325 = reset ? 32'h0 : T6;
  assign T6 = T7 ? io_data_w : regfile_0;
  assign T7 = T11 & T8;
  assign T8 = T9[1'h0:1'h0];
  assign T9 = 1'h1 << T10;
  assign T10 = io_addr_w;
  assign T11 = io_wen & T12;
  assign T12 = io_addr_w != 5'h0;
  assign T326 = reset ? 32'h0 : T13;
  assign T13 = T14 ? io_data_w : regfile_1;
  assign T14 = T11 & T15;
  assign T15 = T9[1'h1:1'h1];
  assign T16 = {regfile_3, regfile_2};
  assign T327 = reset ? 32'h0 : T17;
  assign T17 = T18 ? io_data_w : regfile_2;
  assign T18 = T11 & T19;
  assign T19 = T9[2'h2:2'h2];
  assign T328 = reset ? 32'h0 : T20;
  assign T20 = T21 ? io_data_w : regfile_3;
  assign T21 = T11 & T22;
  assign T22 = T9[2'h3:2'h3];
  assign T23 = {T31, T24};
  assign T24 = {regfile_5, regfile_4};
  assign T329 = reset ? 32'h0 : T25;
  assign T25 = T26 ? io_data_w : regfile_4;
  assign T26 = T11 & T27;
  assign T27 = T9[3'h4:3'h4];
  assign T330 = reset ? 32'h0 : T28;
  assign T28 = T29 ? io_data_w : regfile_5;
  assign T29 = T11 & T30;
  assign T30 = T9[3'h5:3'h5];
  assign T31 = {regfile_7, regfile_6};
  assign T331 = reset ? 32'h0 : T32;
  assign T32 = T33 ? io_data_w : regfile_6;
  assign T33 = T11 & T34;
  assign T34 = T9[3'h6:3'h6];
  assign T332 = reset ? 32'h0 : T35;
  assign T35 = T36 ? io_data_w : regfile_7;
  assign T36 = T11 & T37;
  assign T37 = T9[3'h7:3'h7];
  assign T38 = {T54, T39};
  assign T39 = {T47, T40};
  assign T40 = {regfile_9, regfile_8};
  assign T333 = reset ? 32'h0 : T41;
  assign T41 = T42 ? io_data_w : regfile_8;
  assign T42 = T11 & T43;
  assign T43 = T9[4'h8:4'h8];
  assign T334 = reset ? 32'h0 : T44;
  assign T44 = T45 ? io_data_w : regfile_9;
  assign T45 = T11 & T46;
  assign T46 = T9[4'h9:4'h9];
  assign T47 = {regfile_11, regfile_10};
  assign T335 = reset ? 32'h0 : T48;
  assign T48 = T49 ? io_data_w : regfile_10;
  assign T49 = T11 & T50;
  assign T50 = T9[4'ha:4'ha];
  assign T336 = reset ? 32'h0 : T51;
  assign T51 = T52 ? io_data_w : regfile_11;
  assign T52 = T11 & T53;
  assign T53 = T9[4'hb:4'hb];
  assign T54 = {T62, T55};
  assign T55 = {regfile_13, regfile_12};
  assign T337 = reset ? 32'h0 : T56;
  assign T56 = T57 ? io_data_w : regfile_12;
  assign T57 = T11 & T58;
  assign T58 = T9[4'hc:4'hc];
  assign T338 = reset ? 32'h0 : T59;
  assign T59 = T60 ? io_data_w : regfile_13;
  assign T60 = T11 & T61;
  assign T61 = T9[4'hd:4'hd];
  assign T62 = {regfile_15, regfile_14};
  assign T339 = reset ? 32'h0 : T63;
  assign T63 = T64 ? io_data_w : regfile_14;
  assign T64 = T11 & T65;
  assign T65 = T9[4'he:4'he];
  assign T340 = reset ? 32'h0 : T66;
  assign T66 = T67 ? io_data_w : regfile_15;
  assign T67 = T11 & T68;
  assign T68 = T9[4'hf:4'hf];
  assign T69 = {T101, T70};
  assign T70 = {T86, T71};
  assign T71 = {T79, T72};
  assign T72 = {regfile_17, regfile_16};
  assign T341 = reset ? 32'h0 : T73;
  assign T73 = T74 ? io_data_w : regfile_16;
  assign T74 = T11 & T75;
  assign T75 = T9[5'h10:5'h10];
  assign T342 = reset ? 32'h0 : T76;
  assign T76 = T77 ? io_data_w : regfile_17;
  assign T77 = T11 & T78;
  assign T78 = T9[5'h11:5'h11];
  assign T79 = {regfile_19, regfile_18};
  assign T343 = reset ? 32'h0 : T80;
  assign T80 = T81 ? io_data_w : regfile_18;
  assign T81 = T11 & T82;
  assign T82 = T9[5'h12:5'h12];
  assign T344 = reset ? 32'h0 : T83;
  assign T83 = T84 ? io_data_w : regfile_19;
  assign T84 = T11 & T85;
  assign T85 = T9[5'h13:5'h13];
  assign T86 = {T94, T87};
  assign T87 = {regfile_21, regfile_20};
  assign T345 = reset ? 32'h0 : T88;
  assign T88 = T89 ? io_data_w : regfile_20;
  assign T89 = T11 & T90;
  assign T90 = T9[5'h14:5'h14];
  assign T346 = reset ? 32'h0 : T91;
  assign T91 = T92 ? io_data_w : regfile_21;
  assign T92 = T11 & T93;
  assign T93 = T9[5'h15:5'h15];
  assign T94 = {regfile_23, regfile_22};
  assign T347 = reset ? 32'h0 : T95;
  assign T95 = T96 ? io_data_w : regfile_22;
  assign T96 = T11 & T97;
  assign T97 = T9[5'h16:5'h16];
  assign T348 = reset ? 32'h0 : T98;
  assign T98 = T99 ? io_data_w : regfile_23;
  assign T99 = T11 & T100;
  assign T100 = T9[5'h17:5'h17];
  assign T101 = {T117, T102};
  assign T102 = {T110, T103};
  assign T103 = {regfile_25, regfile_24};
  assign T349 = reset ? 32'h0 : T104;
  assign T104 = T105 ? io_data_w : regfile_24;
  assign T105 = T11 & T106;
  assign T106 = T9[5'h18:5'h18];
  assign T350 = reset ? 32'h0 : T107;
  assign T107 = T108 ? io_data_w : regfile_25;
  assign T108 = T11 & T109;
  assign T109 = T9[5'h19:5'h19];
  assign T110 = {regfile_27, regfile_26};
  assign T351 = reset ? 32'h0 : T111;
  assign T111 = T112 ? io_data_w : regfile_26;
  assign T112 = T11 & T113;
  assign T113 = T9[5'h1a:5'h1a];
  assign T352 = reset ? 32'h0 : T114;
  assign T114 = T115 ? io_data_w : regfile_27;
  assign T115 = T11 & T116;
  assign T116 = T9[5'h1b:5'h1b];
  assign T117 = {T125, T118};
  assign T118 = {regfile_29, regfile_28};
  assign T353 = reset ? 32'h0 : T119;
  assign T119 = T120 ? io_data_w : regfile_28;
  assign T120 = T11 & T121;
  assign T121 = T9[5'h1c:5'h1c];
  assign T354 = reset ? 32'h0 : T122;
  assign T122 = T123 ? io_data_w : regfile_29;
  assign T123 = T11 & T124;
  assign T124 = T9[5'h1d:5'h1d];
  assign T125 = {regfile_31, regfile_30};
  assign T355 = reset ? 32'h0 : T126;
  assign T126 = T127 ? io_data_w : regfile_30;
  assign T127 = T11 & T128;
  assign T128 = T9[5'h1e:5'h1e];
  assign T356 = reset ? 32'h0 : T129;
  assign T129 = T130 ? io_data_w : regfile_31;
  assign T130 = T11 & T131;
  assign T131 = T9[5'h1f:5'h1f];
  assign io_data_t = T132;
  assign T132 = T194 ? T164 : T133;
  assign T133 = T163 ? T149 : T134;
  assign T134 = T148 ? T142 : T135;
  assign T135 = T141 ? T139 : T136;
  assign T136 = T137 ? regfile_1 : regfile_0;
  assign T137 = T138[1'h0:1'h0];
  assign T138 = io_addr_t;
  assign T139 = T140 ? regfile_3 : regfile_2;
  assign T140 = T138[1'h0:1'h0];
  assign T141 = T138[1'h1:1'h1];
  assign T142 = T147 ? T145 : T143;
  assign T143 = T144 ? regfile_5 : regfile_4;
  assign T144 = T138[1'h0:1'h0];
  assign T145 = T146 ? regfile_7 : regfile_6;
  assign T146 = T138[1'h0:1'h0];
  assign T147 = T138[1'h1:1'h1];
  assign T148 = T138[2'h2:2'h2];
  assign T149 = T162 ? T156 : T150;
  assign T150 = T155 ? T153 : T151;
  assign T151 = T152 ? regfile_9 : regfile_8;
  assign T152 = T138[1'h0:1'h0];
  assign T153 = T154 ? regfile_11 : regfile_10;
  assign T154 = T138[1'h0:1'h0];
  assign T155 = T138[1'h1:1'h1];
  assign T156 = T161 ? T159 : T157;
  assign T157 = T158 ? regfile_13 : regfile_12;
  assign T158 = T138[1'h0:1'h0];
  assign T159 = T160 ? regfile_15 : regfile_14;
  assign T160 = T138[1'h0:1'h0];
  assign T161 = T138[1'h1:1'h1];
  assign T162 = T138[2'h2:2'h2];
  assign T163 = T138[2'h3:2'h3];
  assign T164 = T193 ? T179 : T165;
  assign T165 = T178 ? T172 : T166;
  assign T166 = T171 ? T169 : T167;
  assign T167 = T168 ? regfile_17 : regfile_16;
  assign T168 = T138[1'h0:1'h0];
  assign T169 = T170 ? regfile_19 : regfile_18;
  assign T170 = T138[1'h0:1'h0];
  assign T171 = T138[1'h1:1'h1];
  assign T172 = T177 ? T175 : T173;
  assign T173 = T174 ? regfile_21 : regfile_20;
  assign T174 = T138[1'h0:1'h0];
  assign T175 = T176 ? regfile_23 : regfile_22;
  assign T176 = T138[1'h0:1'h0];
  assign T177 = T138[1'h1:1'h1];
  assign T178 = T138[2'h2:2'h2];
  assign T179 = T192 ? T186 : T180;
  assign T180 = T185 ? T183 : T181;
  assign T181 = T182 ? regfile_25 : regfile_24;
  assign T182 = T138[1'h0:1'h0];
  assign T183 = T184 ? regfile_27 : regfile_26;
  assign T184 = T138[1'h0:1'h0];
  assign T185 = T138[1'h1:1'h1];
  assign T186 = T191 ? T189 : T187;
  assign T187 = T188 ? regfile_29 : regfile_28;
  assign T188 = T138[1'h0:1'h0];
  assign T189 = T190 ? regfile_31 : regfile_30;
  assign T190 = T138[1'h0:1'h0];
  assign T191 = T138[1'h1:1'h1];
  assign T192 = T138[2'h2:2'h2];
  assign T193 = T138[2'h3:2'h3];
  assign T194 = T138[3'h4:3'h4];
  assign io_data_b = T195;
  assign T195 = T259 ? io_data_w : T196;
  assign T196 = T258 ? T228 : T197;
  assign T197 = T227 ? T213 : T198;
  assign T198 = T212 ? T206 : T199;
  assign T199 = T205 ? T203 : T200;
  assign T200 = T201 ? regfile_1 : regfile_0;
  assign T201 = T202[1'h0:1'h0];
  assign T202 = io_addr_b;
  assign T203 = T204 ? regfile_3 : regfile_2;
  assign T204 = T202[1'h0:1'h0];
  assign T205 = T202[1'h1:1'h1];
  assign T206 = T211 ? T209 : T207;
  assign T207 = T208 ? regfile_5 : regfile_4;
  assign T208 = T202[1'h0:1'h0];
  assign T209 = T210 ? regfile_7 : regfile_6;
  assign T210 = T202[1'h0:1'h0];
  assign T211 = T202[1'h1:1'h1];
  assign T212 = T202[2'h2:2'h2];
  assign T213 = T226 ? T220 : T214;
  assign T214 = T219 ? T217 : T215;
  assign T215 = T216 ? regfile_9 : regfile_8;
  assign T216 = T202[1'h0:1'h0];
  assign T217 = T218 ? regfile_11 : regfile_10;
  assign T218 = T202[1'h0:1'h0];
  assign T219 = T202[1'h1:1'h1];
  assign T220 = T225 ? T223 : T221;
  assign T221 = T222 ? regfile_13 : regfile_12;
  assign T222 = T202[1'h0:1'h0];
  assign T223 = T224 ? regfile_15 : regfile_14;
  assign T224 = T202[1'h0:1'h0];
  assign T225 = T202[1'h1:1'h1];
  assign T226 = T202[2'h2:2'h2];
  assign T227 = T202[2'h3:2'h3];
  assign T228 = T257 ? T243 : T229;
  assign T229 = T242 ? T236 : T230;
  assign T230 = T235 ? T233 : T231;
  assign T231 = T232 ? regfile_17 : regfile_16;
  assign T232 = T202[1'h0:1'h0];
  assign T233 = T234 ? regfile_19 : regfile_18;
  assign T234 = T202[1'h0:1'h0];
  assign T235 = T202[1'h1:1'h1];
  assign T236 = T241 ? T239 : T237;
  assign T237 = T238 ? regfile_21 : regfile_20;
  assign T238 = T202[1'h0:1'h0];
  assign T239 = T240 ? regfile_23 : regfile_22;
  assign T240 = T202[1'h0:1'h0];
  assign T241 = T202[1'h1:1'h1];
  assign T242 = T202[2'h2:2'h2];
  assign T243 = T256 ? T250 : T244;
  assign T244 = T249 ? T247 : T245;
  assign T245 = T246 ? regfile_25 : regfile_24;
  assign T246 = T202[1'h0:1'h0];
  assign T247 = T248 ? regfile_27 : regfile_26;
  assign T248 = T202[1'h0:1'h0];
  assign T249 = T202[1'h1:1'h1];
  assign T250 = T255 ? T253 : T251;
  assign T251 = T252 ? regfile_29 : regfile_28;
  assign T252 = T202[1'h0:1'h0];
  assign T253 = T254 ? regfile_31 : regfile_30;
  assign T254 = T202[1'h0:1'h0];
  assign T255 = T202[1'h1:1'h1];
  assign T256 = T202[2'h2:2'h2];
  assign T257 = T202[2'h3:2'h3];
  assign T258 = T202[3'h4:3'h4];
  assign T259 = io_addr_b == io_addr_w;
  assign io_data_a = T260;
  assign T260 = T324 ? io_data_w : T261;
  assign T261 = T323 ? T293 : T262;
  assign T262 = T292 ? T278 : T263;
  assign T263 = T277 ? T271 : T264;
  assign T264 = T270 ? T268 : T265;
  assign T265 = T266 ? regfile_1 : regfile_0;
  assign T266 = T267[1'h0:1'h0];
  assign T267 = io_addr_a;
  assign T268 = T269 ? regfile_3 : regfile_2;
  assign T269 = T267[1'h0:1'h0];
  assign T270 = T267[1'h1:1'h1];
  assign T271 = T276 ? T274 : T272;
  assign T272 = T273 ? regfile_5 : regfile_4;
  assign T273 = T267[1'h0:1'h0];
  assign T274 = T275 ? regfile_7 : regfile_6;
  assign T275 = T267[1'h0:1'h0];
  assign T276 = T267[1'h1:1'h1];
  assign T277 = T267[2'h2:2'h2];
  assign T278 = T291 ? T285 : T279;
  assign T279 = T284 ? T282 : T280;
  assign T280 = T281 ? regfile_9 : regfile_8;
  assign T281 = T267[1'h0:1'h0];
  assign T282 = T283 ? regfile_11 : regfile_10;
  assign T283 = T267[1'h0:1'h0];
  assign T284 = T267[1'h1:1'h1];
  assign T285 = T290 ? T288 : T286;
  assign T286 = T287 ? regfile_13 : regfile_12;
  assign T287 = T267[1'h0:1'h0];
  assign T288 = T289 ? regfile_15 : regfile_14;
  assign T289 = T267[1'h0:1'h0];
  assign T290 = T267[1'h1:1'h1];
  assign T291 = T267[2'h2:2'h2];
  assign T292 = T267[2'h3:2'h3];
  assign T293 = T322 ? T308 : T294;
  assign T294 = T307 ? T301 : T295;
  assign T295 = T300 ? T298 : T296;
  assign T296 = T297 ? regfile_17 : regfile_16;
  assign T297 = T267[1'h0:1'h0];
  assign T298 = T299 ? regfile_19 : regfile_18;
  assign T299 = T267[1'h0:1'h0];
  assign T300 = T267[1'h1:1'h1];
  assign T301 = T306 ? T304 : T302;
  assign T302 = T303 ? regfile_21 : regfile_20;
  assign T303 = T267[1'h0:1'h0];
  assign T304 = T305 ? regfile_23 : regfile_22;
  assign T305 = T267[1'h0:1'h0];
  assign T306 = T267[1'h1:1'h1];
  assign T307 = T267[2'h2:2'h2];
  assign T308 = T321 ? T315 : T309;
  assign T309 = T314 ? T312 : T310;
  assign T310 = T311 ? regfile_25 : regfile_24;
  assign T311 = T267[1'h0:1'h0];
  assign T312 = T313 ? regfile_27 : regfile_26;
  assign T313 = T267[1'h0:1'h0];
  assign T314 = T267[1'h1:1'h1];
  assign T315 = T320 ? T318 : T316;
  assign T316 = T317 ? regfile_29 : regfile_28;
  assign T317 = T267[1'h0:1'h0];
  assign T318 = T319 ? regfile_31 : regfile_30;
  assign T319 = T267[1'h0:1'h0];
  assign T320 = T267[1'h1:1'h1];
  assign T321 = T267[2'h2:2'h2];
  assign T322 = T267[2'h3:2'h3];
  assign T323 = T267[3'h4:3'h4];
  assign T324 = io_addr_a == io_addr_w;

  always @(posedge clk) begin
    if(reset) begin
      regfile_0 <= 32'h0;
    end else if(T7) begin
      regfile_0 <= io_data_w;
    end
    if(reset) begin
      regfile_1 <= 32'h0;
    end else if(T14) begin
      regfile_1 <= io_data_w;
    end
    if(reset) begin
      regfile_2 <= 32'h0;
    end else if(T18) begin
      regfile_2 <= io_data_w;
    end
    if(reset) begin
      regfile_3 <= 32'h0;
    end else if(T21) begin
      regfile_3 <= io_data_w;
    end
    if(reset) begin
      regfile_4 <= 32'h0;
    end else if(T26) begin
      regfile_4 <= io_data_w;
    end
    if(reset) begin
      regfile_5 <= 32'h0;
    end else if(T29) begin
      regfile_5 <= io_data_w;
    end
    if(reset) begin
      regfile_6 <= 32'h0;
    end else if(T33) begin
      regfile_6 <= io_data_w;
    end
    if(reset) begin
      regfile_7 <= 32'h0;
    end else if(T36) begin
      regfile_7 <= io_data_w;
    end
    if(reset) begin
      regfile_8 <= 32'h0;
    end else if(T42) begin
      regfile_8 <= io_data_w;
    end
    if(reset) begin
      regfile_9 <= 32'h0;
    end else if(T45) begin
      regfile_9 <= io_data_w;
    end
    if(reset) begin
      regfile_10 <= 32'h0;
    end else if(T49) begin
      regfile_10 <= io_data_w;
    end
    if(reset) begin
      regfile_11 <= 32'h0;
    end else if(T52) begin
      regfile_11 <= io_data_w;
    end
    if(reset) begin
      regfile_12 <= 32'h0;
    end else if(T57) begin
      regfile_12 <= io_data_w;
    end
    if(reset) begin
      regfile_13 <= 32'h0;
    end else if(T60) begin
      regfile_13 <= io_data_w;
    end
    if(reset) begin
      regfile_14 <= 32'h0;
    end else if(T64) begin
      regfile_14 <= io_data_w;
    end
    if(reset) begin
      regfile_15 <= 32'h0;
    end else if(T67) begin
      regfile_15 <= io_data_w;
    end
    if(reset) begin
      regfile_16 <= 32'h0;
    end else if(T74) begin
      regfile_16 <= io_data_w;
    end
    if(reset) begin
      regfile_17 <= 32'h0;
    end else if(T77) begin
      regfile_17 <= io_data_w;
    end
    if(reset) begin
      regfile_18 <= 32'h0;
    end else if(T81) begin
      regfile_18 <= io_data_w;
    end
    if(reset) begin
      regfile_19 <= 32'h0;
    end else if(T84) begin
      regfile_19 <= io_data_w;
    end
    if(reset) begin
      regfile_20 <= 32'h0;
    end else if(T89) begin
      regfile_20 <= io_data_w;
    end
    if(reset) begin
      regfile_21 <= 32'h0;
    end else if(T92) begin
      regfile_21 <= io_data_w;
    end
    if(reset) begin
      regfile_22 <= 32'h0;
    end else if(T96) begin
      regfile_22 <= io_data_w;
    end
    if(reset) begin
      regfile_23 <= 32'h0;
    end else if(T99) begin
      regfile_23 <= io_data_w;
    end
    if(reset) begin
      regfile_24 <= 32'h0;
    end else if(T105) begin
      regfile_24 <= io_data_w;
    end
    if(reset) begin
      regfile_25 <= 32'h0;
    end else if(T108) begin
      regfile_25 <= io_data_w;
    end
    if(reset) begin
      regfile_26 <= 32'h0;
    end else if(T112) begin
      regfile_26 <= io_data_w;
    end
    if(reset) begin
      regfile_27 <= 32'h0;
    end else if(T115) begin
      regfile_27 <= io_data_w;
    end
    if(reset) begin
      regfile_28 <= 32'h0;
    end else if(T120) begin
      regfile_28 <= io_data_w;
    end
    if(reset) begin
      regfile_29 <= 32'h0;
    end else if(T123) begin
      regfile_29 <= io_data_w;
    end
    if(reset) begin
      regfile_30 <= 32'h0;
    end else if(T127) begin
      regfile_30 <= io_data_w;
    end
    if(reset) begin
      regfile_31 <= 32'h0;
    end else if(T130) begin
      regfile_31 <= io_data_w;
    end
  end
endmodule

module PipeID(input clk, input reset,
    input [31:0] io_inst,
    input [31:0] io_pc4,
    output[1:0] io_pcsource,
    output[31:0] io_bpc,
    output[31:0] io_jpc,
    output[31:0] io_jrpc,
    input  io_stall,
    output[4:0] io_rs,
    output[4:0] io_rt,
    input  io_wb_rf_wen,
    input [4:0] io_wb_rf_addr,
    input [31:0] io_wb_rf_data,
    output[31:0] io_ctrl_inst,
    output[31:0] io_ctrl_data_a,
    output[31:0] io_ctrl_data_b,
    output[31:0] io_ctrl_imm,
    output[4:0] io_ctrl_shamt,
    output[31:0] io_ctrl_pc4,
    output[3:0] io_ctrl_alu_op,
    output io_ctrl_op1_sel,
    output io_ctrl_op2_sel,
    output[1:0] io_ctrl_wb_sel,
    output[4:0] io_ctrl_wb_dst,
    output[2:0] io_ctrl_br_type,
    output io_ctrl_rf_wen,
    output io_ctrl_mem_ren,
    output io_ctrl_mem_wen,
    output io_ctrl_brt,
    output[4:0] io_ctrl_rs,
    output[4:0] io_ctrl_rt,
    input [4:0] io_rf_addr_t,
    output[31:0] io_rf_data_t,
    output[1023:0] io_regs,
    input [31:0] io_exe_out,
    input [31:0] io_mem_out,
    input [4:0] io_mem_dst
);

  wire[4:0] rt;
  wire[4:0] rs;
  reg [4:0] reg_irt;
  wire[4:0] T386;
  wire[4:0] T0;
  reg [4:0] reg_irs;
  wire[4:0] T387;
  wire[4:0] T1;
  reg  reg_brt;
  wire T388;
  wire brt;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire[4:0] br_type;
  wire[4:0] T6;
  wire[4:0] T7;
  wire[4:0] T8;
  wire[4:0] T9;
  wire[4:0] T10;
  wire[4:0] T11;
  wire[4:0] T12;
  wire[4:0] T13;
  wire[4:0] T14;
  wire[4:0] T15;
  wire[4:0] T16;
  wire[4:0] T17;
  wire[4:0] T18;
  wire[4:0] T19;
  wire[4:0] T20;
  wire[4:0] T21;
  wire[4:0] T22;
  wire[4:0] T23;
  wire[4:0] T24;
  wire[4:0] T25;
  wire[4:0] T26;
  wire[4:0] T27;
  wire[4:0] T28;
  wire[4:0] T29;
  wire[4:0] T30;
  wire[4:0] T31;
  wire[4:0] T32;
  wire[4:0] T33;
  wire[4:0] T34;
  wire[4:0] T35;
  wire[4:0] T36;
  wire[4:0] T37;
  wire T38;
  wire[31:0] T39;
  wire[31:0] inst;
  wire T40;
  wire[31:0] T41;
  wire T42;
  wire[31:0] T43;
  wire T44;
  wire[31:0] T45;
  wire T46;
  wire[31:0] T47;
  wire T48;
  wire[31:0] T49;
  wire T50;
  wire[31:0] T51;
  wire T52;
  wire[31:0] T53;
  wire T54;
  wire[31:0] T55;
  wire T56;
  wire[31:0] T57;
  wire T58;
  wire[31:0] T59;
  wire T60;
  wire[31:0] T61;
  wire T62;
  wire[31:0] T63;
  wire T64;
  wire[31:0] T65;
  wire T66;
  wire[31:0] T67;
  wire T68;
  wire[31:0] T69;
  wire T70;
  wire[31:0] T71;
  wire T72;
  wire[31:0] T73;
  wire T74;
  wire[31:0] T75;
  wire T76;
  wire[31:0] T77;
  wire T78;
  wire[31:0] T79;
  wire T80;
  wire[31:0] T81;
  wire T82;
  wire[31:0] T83;
  wire T84;
  wire[31:0] T85;
  wire T86;
  wire[31:0] T87;
  wire T88;
  wire[31:0] T89;
  wire T90;
  wire[31:0] T91;
  wire T92;
  wire[31:0] T93;
  wire T94;
  wire[31:0] T95;
  wire T96;
  wire[31:0] T97;
  wire T98;
  wire[31:0] T99;
  wire T100;
  wire[31:0] T101;
  wire T102;
  wire T103;
  wire T104;
  wire T105;
  wire equ;
  wire[31:0] op2;
  wire[31:0] T106;
  wire[31:0] T107;
  wire T108;
  wire T109;
  reg [4:0] reg_wb_dst;
  wire[4:0] T389;
  wire[4:0] id_wb_addr;
  wire[4:0] T110;
  wire[4:0] T111;
  wire[4:0] rd;
  wire T112;
  wire[3:0] reg_dst;
  wire[3:0] T113;
  wire[3:0] T114;
  wire[3:0] T115;
  wire[3:0] T116;
  wire[3:0] T117;
  wire[3:0] T118;
  wire[3:0] T119;
  wire[3:0] T120;
  wire[3:0] T121;
  wire[3:0] T122;
  wire[3:0] T123;
  wire[3:0] T124;
  wire[3:0] T125;
  wire[3:0] T126;
  wire[3:0] T127;
  wire[3:0] T128;
  wire[3:0] T129;
  wire[3:0] T130;
  wire[3:0] T131;
  wire[3:0] T132;
  wire[3:0] T133;
  wire[3:0] T134;
  wire[3:0] T135;
  wire[3:0] T136;
  wire[3:0] T137;
  wire[3:0] T138;
  wire[3:0] T139;
  wire[3:0] T140;
  wire[3:0] T141;
  wire[3:0] T142;
  wire[3:0] T143;
  wire[3:0] T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  wire T149;
  wire T150;
  wire T151;
  wire[31:0] op1;
  wire[31:0] T152;
  wire[31:0] T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire T162;
  reg  reg_mem_wen;
  wire T390;
  wire mem_wen;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire T172;
  wire T173;
  wire T174;
  wire T175;
  wire T176;
  wire T177;
  wire T178;
  wire T179;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  wire T184;
  wire T185;
  wire T186;
  wire T187;
  wire T188;
  reg  reg_mem_ren;
  wire T391;
  wire mem_ren;
  wire T189;
  wire T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  wire T196;
  wire T197;
  wire T198;
  wire T199;
  wire T200;
  wire T201;
  wire T202;
  wire T203;
  wire T204;
  wire T205;
  wire T206;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  reg  reg_rf_wen;
  wire T392;
  wire rf_wen;
  wire T214;
  wire T215;
  wire T216;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  wire T221;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire T228;
  wire T229;
  wire T230;
  wire T231;
  wire T232;
  wire T233;
  wire T234;
  wire T235;
  wire T236;
  wire T237;
  wire T238;
  wire T239;
  wire T240;
  wire T241;
  wire T242;
  wire T243;
  wire T244;
  wire[2:0] T393;
  reg [4:0] reg_br_type;
  wire[4:0] T394;
  wire[1:0] T395;
  reg [2:0] reg_wb_sel;
  wire[2:0] T396;
  wire[2:0] wb_sel;
  wire[2:0] T245;
  wire[2:0] T246;
  wire[2:0] T247;
  wire[2:0] T248;
  wire[2:0] T249;
  wire[2:0] T250;
  wire[2:0] T251;
  wire[2:0] T252;
  wire[2:0] T253;
  wire[2:0] T254;
  wire[2:0] T255;
  wire[2:0] T256;
  wire[2:0] T257;
  wire[2:0] T258;
  wire[2:0] T259;
  wire[2:0] T260;
  wire[2:0] T261;
  wire[2:0] T262;
  wire[2:0] T263;
  wire[2:0] T264;
  wire[2:0] T265;
  wire[2:0] T266;
  wire[2:0] T267;
  wire[2:0] T268;
  wire[2:0] T269;
  wire[2:0] T270;
  wire[2:0] T271;
  wire[2:0] T272;
  wire[2:0] T273;
  wire[2:0] T274;
  wire[2:0] T275;
  wire[2:0] T276;
  reg  reg_op2_sel;
  wire T397;
  wire op2_sel;
  wire T277;
  wire T278;
  wire T279;
  wire T280;
  wire T281;
  wire T282;
  wire T283;
  wire T284;
  wire T285;
  wire T286;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  wire T293;
  wire T294;
  wire T295;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  wire T301;
  wire T302;
  wire T303;
  wire T304;
  wire T305;
  reg  reg_op1_sel;
  reg [3:0] reg_alu_op;
  wire[3:0] T398;
  wire[3:0] alu_op;
  wire[3:0] T306;
  wire[3:0] T307;
  wire[3:0] T308;
  wire[3:0] T309;
  wire[3:0] T310;
  wire[3:0] T311;
  wire[3:0] T312;
  wire[3:0] T313;
  wire[3:0] T314;
  wire[3:0] T315;
  wire[3:0] T316;
  wire[3:0] T317;
  wire[3:0] T318;
  wire[3:0] T319;
  wire[3:0] T320;
  wire[3:0] T321;
  wire[3:0] T322;
  wire[3:0] T323;
  wire[3:0] T324;
  wire[3:0] T325;
  wire[3:0] T326;
  wire[3:0] T327;
  wire[3:0] T328;
  wire[3:0] T329;
  wire[3:0] T330;
  wire[3:0] T331;
  wire[3:0] T332;
  wire[3:0] T333;
  wire[3:0] T334;
  wire[3:0] T335;
  reg [31:0] reg_pc4;
  wire[31:0] T399;
  reg [4:0] reg_shamt;
  wire[4:0] T400;
  wire[4:0] sa;
  reg [31:0] reg_imm;
  wire[31:0] T401;
  wire[31:0] id_ext_imm;
  wire[31:0] T336;
  wire[31:0] zero_imm;
  wire[15:0] imm;
  wire T337;
  wire extend_type;
  wire T338;
  wire T339;
  wire T340;
  wire T341;
  wire T342;
  wire T343;
  wire T344;
  wire T345;
  wire T346;
  wire T347;
  wire T348;
  wire T349;
  wire T350;
  wire T351;
  wire T352;
  wire T353;
  wire T354;
  wire T355;
  wire T356;
  wire T357;
  wire T358;
  wire T359;
  wire T360;
  wire T361;
  wire T362;
  wire T363;
  wire T364;
  wire T365;
  wire[31:0] sign_imm;
  wire[15:0] T366;
  wire[15:0] T402;
  wire sign;
  wire T367;
  reg [31:0] reg_data_b;
  wire[31:0] T403;
  reg [31:0] reg_data_a;
  wire[31:0] T404;
  reg [31:0] reg_inst;
  wire[31:0] T405;
  wire[4:0] T368;
  wire[4:0] T369;
  wire[31:0] T370;
  wire[27:0] T371;
  wire[25:0] addr;
  wire[3:0] T372;
  wire[31:0] T406;
  wire[33:0] T373;
  wire[33:0] T374;
  wire[33:0] T407;
  wire[1:0] T375;
  wire[1:0] T376;
  wire[1:0] T377;
  wire[1:0] T378;
  wire[1:0] T379;
  wire[1:0] T380;
  wire T381;
  wire T382;
  wire T383;
  wire T384;
  wire T385;
  wire[31:0] RegisterFile_io_data_a;
  wire[31:0] RegisterFile_io_data_b;
  wire[31:0] RegisterFile_io_data_t;
  wire[1023:0] RegisterFile_io_regs;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    reg_irt = {1{$random}};
    reg_irs = {1{$random}};
    reg_brt = {1{$random}};
    reg_wb_dst = {1{$random}};
    reg_mem_wen = {1{$random}};
    reg_mem_ren = {1{$random}};
    reg_rf_wen = {1{$random}};
    reg_br_type = {1{$random}};
    reg_wb_sel = {1{$random}};
    reg_op2_sel = {1{$random}};
    reg_op1_sel = {1{$random}};
    reg_alu_op = {1{$random}};
    reg_pc4 = {1{$random}};
    reg_shamt = {1{$random}};
    reg_imm = {1{$random}};
    reg_data_b = {1{$random}};
    reg_data_a = {1{$random}};
    reg_inst = {1{$random}};
  end
// synthesis translate_on
`endif

  assign rt = io_inst[5'h14:5'h10];
  assign rs = io_inst[5'h19:5'h15];
  assign io_regs = RegisterFile_io_regs;
  assign io_rf_data_t = RegisterFile_io_data_t;
  assign io_ctrl_rt = reg_irt;
  assign T386 = reset ? 5'h0 : T0;
  assign T0 = io_stall ? 5'h0 : rt;
  assign io_ctrl_rs = reg_irs;
  assign T387 = reset ? 5'h0 : T1;
  assign T1 = io_stall ? 5'h0 : rs;
  assign io_ctrl_brt = reg_brt;
  assign T388 = reset ? 1'h0 : brt;
  assign brt = T162 ? 1'h0 : T2;
  assign T2 = T161 ? equ : T3;
  assign T3 = T105 ? T104 : T4;
  assign T4 = T103 ? 1'h1 : T5;
  assign T5 = br_type == 5'h3;
  assign br_type = T102 ? 5'h0 : T6;
  assign T6 = T100 ? 5'h0 : T7;
  assign T7 = T98 ? 5'h0 : T8;
  assign T8 = T96 ? 5'h0 : T9;
  assign T9 = T94 ? 5'h0 : T10;
  assign T10 = T92 ? 5'h0 : T11;
  assign T11 = T90 ? 5'h0 : T12;
  assign T12 = T88 ? 5'h0 : T13;
  assign T13 = T86 ? 5'h0 : T14;
  assign T14 = T84 ? 5'h0 : T15;
  assign T15 = T82 ? 5'h0 : T16;
  assign T16 = T80 ? 5'h0 : T17;
  assign T17 = T78 ? 5'h0 : T18;
  assign T18 = T76 ? 5'h0 : T19;
  assign T19 = T74 ? 5'h0 : T20;
  assign T20 = T72 ? 5'h0 : T21;
  assign T21 = T70 ? 5'h0 : T22;
  assign T22 = T68 ? 5'h3 : T23;
  assign T23 = T66 ? 5'h3 : T24;
  assign T24 = T64 ? 5'h0 : T25;
  assign T25 = T62 ? 5'h0 : T26;
  assign T26 = T60 ? 5'h0 : T27;
  assign T27 = T58 ? 5'h0 : T28;
  assign T28 = T56 ? 5'h0 : T29;
  assign T29 = T54 ? 5'h0 : T30;
  assign T30 = T52 ? 5'h0 : T31;
  assign T31 = T50 ? 5'h0 : T32;
  assign T32 = T48 ? 5'h0 : T33;
  assign T33 = T46 ? 5'h1 : T34;
  assign T34 = T44 ? 5'h2 : T35;
  assign T35 = T42 ? 5'h0 : T36;
  assign T36 = T40 ? 5'h4 : T37;
  assign T37 = T38 ? 5'h4 : 5'h0;
  assign T38 = T39 == 32'hc000000;
  assign T39 = inst & 32'hfc000000;
  assign inst = io_stall ? 32'h0 : io_inst;
  assign T40 = T41 == 32'h8000000;
  assign T41 = inst & 32'hfc000000;
  assign T42 = T43 == 32'h3c000000;
  assign T43 = inst & 32'hfc000000;
  assign T44 = T45 == 32'h14000000;
  assign T45 = inst & 32'hfc000000;
  assign T46 = T47 == 32'h10000000;
  assign T47 = inst & 32'hfc000000;
  assign T48 = T49 == 32'hac000000;
  assign T49 = inst & 32'hfc000000;
  assign T50 = T51 == 32'h8c000000;
  assign T51 = inst & 32'hfc000000;
  assign T52 = T53 == 32'h24000000;
  assign T53 = inst & 32'hfc000000;
  assign T54 = T55 == 32'h2c000000;
  assign T55 = inst & 32'hfc000000;
  assign T56 = T57 == 32'h28000000;
  assign T57 = inst & 32'hfc000000;
  assign T58 = T59 == 32'h38000000;
  assign T59 = inst & 32'hfc000000;
  assign T60 = T61 == 32'h34000000;
  assign T61 = inst & 32'hfc000000;
  assign T62 = T63 == 32'h30000000;
  assign T63 = inst & 32'hfc000000;
  assign T64 = T65 == 32'h20000000;
  assign T65 = inst & 32'hfc000000;
  assign T66 = T67 == 32'h9;
  assign T67 = inst & 32'hfc00003f;
  assign T68 = T69 == 32'h8;
  assign T69 = inst & 32'hfc00003f;
  assign T70 = T71 == 32'h7;
  assign T71 = inst & 32'hfc00003f;
  assign T72 = T73 == 32'h6;
  assign T73 = inst & 32'hfc00003f;
  assign T74 = T75 == 32'h4;
  assign T75 = inst & 32'hfc00003f;
  assign T76 = T77 == 32'h2b;
  assign T77 = inst & 32'hfc00003f;
  assign T78 = T79 == 32'h3;
  assign T79 = inst & 32'hfc00003f;
  assign T80 = T81 == 32'h2;
  assign T81 = inst & 32'hfc00003f;
  assign T82 = T83 == 32'h0;
  assign T83 = inst & 32'hfc00003f;
  assign T84 = T85 == 32'h2a;
  assign T85 = inst & 32'hfc00003f;
  assign T86 = T87 == 32'h26;
  assign T87 = inst & 32'hfc00003f;
  assign T88 = T89 == 32'h27;
  assign T89 = inst & 32'hfc00003f;
  assign T90 = T91 == 32'h25;
  assign T91 = inst & 32'hfc00003f;
  assign T92 = T93 == 32'h24;
  assign T93 = inst & 32'hfc00003f;
  assign T94 = T95 == 32'h23;
  assign T95 = inst & 32'hfc00003f;
  assign T96 = T97 == 32'h21;
  assign T97 = inst & 32'hfc00003f;
  assign T98 = T99 == 32'h22;
  assign T99 = inst & 32'hfc00003f;
  assign T100 = T101 == 32'h20;
  assign T101 = inst & 32'hfc00003f;
  assign T102 = inst == 32'h0;
  assign T103 = br_type == 5'h4;
  assign T104 = equ ^ 1'h1;
  assign T105 = br_type == 5'h2;
  assign equ = op1 == op2;
  assign op2 = T106;
  assign T106 = T148 ? io_mem_out : T107;
  assign T107 = T108 ? io_exe_out : RegisterFile_io_data_b;
  assign T108 = T147 & T109;
  assign T109 = rt == reg_wb_dst;
  assign T389 = reset ? 5'h0 : id_wb_addr;
  assign id_wb_addr = T146 ? 5'h1f : T110;
  assign T110 = T145 ? rt : T111;
  assign T111 = T112 ? rd : 5'h0;
  assign rd = io_inst[4'hf:4'hb];
  assign T112 = reg_dst == 4'h2;
  assign reg_dst = T102 ? 4'h0 : T113;
  assign T113 = T100 ? 4'h2 : T114;
  assign T114 = T98 ? 4'h2 : T115;
  assign T115 = T96 ? 4'h2 : T116;
  assign T116 = T94 ? 4'h2 : T117;
  assign T117 = T92 ? 4'h2 : T118;
  assign T118 = T90 ? 4'h2 : T119;
  assign T119 = T88 ? 4'h2 : T120;
  assign T120 = T86 ? 4'h2 : T121;
  assign T121 = T84 ? 4'h2 : T122;
  assign T122 = T82 ? 4'h2 : T123;
  assign T123 = T80 ? 4'h2 : T124;
  assign T124 = T78 ? 4'h2 : T125;
  assign T125 = T76 ? 4'h2 : T126;
  assign T126 = T74 ? 4'h2 : T127;
  assign T127 = T72 ? 4'h2 : T128;
  assign T128 = T70 ? 4'h2 : T129;
  assign T129 = T68 ? 4'h0 : T130;
  assign T130 = T66 ? 4'h3 : T131;
  assign T131 = T64 ? 4'h1 : T132;
  assign T132 = T62 ? 4'h1 : T133;
  assign T133 = T60 ? 4'h1 : T134;
  assign T134 = T58 ? 4'h1 : T135;
  assign T135 = T56 ? 4'h1 : T136;
  assign T136 = T54 ? 4'h1 : T137;
  assign T137 = T52 ? 4'h1 : T138;
  assign T138 = T50 ? 4'h1 : T139;
  assign T139 = T48 ? 4'h0 : T140;
  assign T140 = T46 ? 4'h1 : T141;
  assign T141 = T44 ? 4'h1 : T142;
  assign T142 = T42 ? 4'h1 : T143;
  assign T143 = T40 ? 4'h0 : T144;
  assign T144 = T38 ? 4'h3 : 4'h0;
  assign T145 = reg_dst == 4'h1;
  assign T146 = reg_dst == 4'h3;
  assign T147 = rt != 5'h0;
  assign T148 = T147 & T149;
  assign T149 = T151 & T150;
  assign T150 = rt == io_mem_dst;
  assign T151 = T109 ^ 1'h1;
  assign op1 = T152;
  assign T152 = T157 ? io_mem_out : T153;
  assign T153 = T154 ? io_exe_out : RegisterFile_io_data_a;
  assign T154 = T156 & T155;
  assign T155 = rs == reg_wb_dst;
  assign T156 = rs != 5'h0;
  assign T157 = T156 & T158;
  assign T158 = T160 & T159;
  assign T159 = rs == io_mem_dst;
  assign T160 = T155 ^ 1'h1;
  assign T161 = br_type == 5'h1;
  assign T162 = br_type == 5'h0;
  assign io_ctrl_mem_wen = reg_mem_wen;
  assign T390 = reset ? 1'h0 : mem_wen;
  assign mem_wen = T102 ? 1'h0 : T163;
  assign T163 = T100 ? 1'h0 : T164;
  assign T164 = T98 ? 1'h0 : T165;
  assign T165 = T96 ? 1'h0 : T166;
  assign T166 = T94 ? 1'h0 : T167;
  assign T167 = T92 ? 1'h0 : T168;
  assign T168 = T90 ? 1'h0 : T169;
  assign T169 = T88 ? 1'h0 : T170;
  assign T170 = T86 ? 1'h0 : T171;
  assign T171 = T84 ? 1'h0 : T172;
  assign T172 = T82 ? 1'h0 : T173;
  assign T173 = T80 ? 1'h0 : T174;
  assign T174 = T78 ? 1'h0 : T175;
  assign T175 = T76 ? 1'h0 : T176;
  assign T176 = T74 ? 1'h0 : T177;
  assign T177 = T72 ? 1'h0 : T178;
  assign T178 = T70 ? 1'h0 : T179;
  assign T179 = T68 ? 1'h0 : T180;
  assign T180 = T66 ? 1'h0 : T181;
  assign T181 = T64 ? 1'h0 : T182;
  assign T182 = T62 ? 1'h0 : T183;
  assign T183 = T60 ? 1'h0 : T184;
  assign T184 = T58 ? 1'h0 : T185;
  assign T185 = T56 ? 1'h0 : T186;
  assign T186 = T54 ? 1'h0 : T187;
  assign T187 = T52 ? 1'h0 : T188;
  assign T188 = T50 ? 1'h0 : T48;
  assign io_ctrl_mem_ren = reg_mem_ren;
  assign T391 = reset ? 1'h0 : mem_ren;
  assign mem_ren = T102 ? 1'h0 : T189;
  assign T189 = T100 ? 1'h0 : T190;
  assign T190 = T98 ? 1'h0 : T191;
  assign T191 = T96 ? 1'h0 : T192;
  assign T192 = T94 ? 1'h0 : T193;
  assign T193 = T92 ? 1'h0 : T194;
  assign T194 = T90 ? 1'h0 : T195;
  assign T195 = T88 ? 1'h0 : T196;
  assign T196 = T86 ? 1'h0 : T197;
  assign T197 = T84 ? 1'h0 : T198;
  assign T198 = T82 ? 1'h0 : T199;
  assign T199 = T80 ? 1'h0 : T200;
  assign T200 = T78 ? 1'h0 : T201;
  assign T201 = T76 ? 1'h0 : T202;
  assign T202 = T74 ? 1'h0 : T203;
  assign T203 = T72 ? 1'h0 : T204;
  assign T204 = T70 ? 1'h0 : T205;
  assign T205 = T68 ? 1'h0 : T206;
  assign T206 = T66 ? 1'h0 : T207;
  assign T207 = T64 ? 1'h0 : T208;
  assign T208 = T62 ? 1'h0 : T209;
  assign T209 = T60 ? 1'h0 : T210;
  assign T210 = T58 ? 1'h0 : T211;
  assign T211 = T56 ? 1'h0 : T212;
  assign T212 = T54 ? 1'h0 : T213;
  assign T213 = T52 ? 1'h0 : T50;
  assign io_ctrl_rf_wen = reg_rf_wen;
  assign T392 = reset ? 1'h0 : rf_wen;
  assign rf_wen = T102 ? 1'h0 : T214;
  assign T214 = T100 ? 1'h1 : T215;
  assign T215 = T98 ? 1'h1 : T216;
  assign T216 = T96 ? 1'h1 : T217;
  assign T217 = T94 ? 1'h1 : T218;
  assign T218 = T92 ? 1'h1 : T219;
  assign T219 = T90 ? 1'h1 : T220;
  assign T220 = T88 ? 1'h1 : T221;
  assign T221 = T86 ? 1'h1 : T222;
  assign T222 = T84 ? 1'h1 : T223;
  assign T223 = T82 ? 1'h1 : T224;
  assign T224 = T80 ? 1'h1 : T225;
  assign T225 = T78 ? 1'h1 : T226;
  assign T226 = T76 ? 1'h1 : T227;
  assign T227 = T74 ? 1'h1 : T228;
  assign T228 = T72 ? 1'h1 : T229;
  assign T229 = T70 ? 1'h1 : T230;
  assign T230 = T68 ? 1'h0 : T231;
  assign T231 = T66 ? 1'h1 : T232;
  assign T232 = T64 ? 1'h1 : T233;
  assign T233 = T62 ? 1'h1 : T234;
  assign T234 = T60 ? 1'h1 : T235;
  assign T235 = T58 ? 1'h1 : T236;
  assign T236 = T56 ? 1'h1 : T237;
  assign T237 = T54 ? 1'h1 : T238;
  assign T238 = T52 ? 1'h1 : T239;
  assign T239 = T50 ? 1'h1 : T240;
  assign T240 = T48 ? 1'h0 : T241;
  assign T241 = T46 ? 1'h0 : T242;
  assign T242 = T44 ? 1'h0 : T243;
  assign T243 = T42 ? 1'h1 : T244;
  assign T244 = T40 ? 1'h0 : T38;
  assign io_ctrl_br_type = T393;
  assign T393 = reg_br_type[2'h2:1'h0];
  assign T394 = reset ? 5'h0 : br_type;
  assign io_ctrl_wb_dst = reg_wb_dst;
  assign io_ctrl_wb_sel = T395;
  assign T395 = reg_wb_sel[1'h1:1'h0];
  assign T396 = reset ? 3'h0 : wb_sel;
  assign wb_sel = T102 ? 3'h0 : T245;
  assign T245 = T100 ? 3'h0 : T246;
  assign T246 = T98 ? 3'h0 : T247;
  assign T247 = T96 ? 3'h0 : T248;
  assign T248 = T94 ? 3'h0 : T249;
  assign T249 = T92 ? 3'h0 : T250;
  assign T250 = T90 ? 3'h0 : T251;
  assign T251 = T88 ? 3'h0 : T252;
  assign T252 = T86 ? 3'h0 : T253;
  assign T253 = T84 ? 3'h0 : T254;
  assign T254 = T82 ? 3'h0 : T255;
  assign T255 = T80 ? 3'h0 : T256;
  assign T256 = T78 ? 3'h0 : T257;
  assign T257 = T76 ? 3'h0 : T258;
  assign T258 = T74 ? 3'h0 : T259;
  assign T259 = T72 ? 3'h0 : T260;
  assign T260 = T70 ? 3'h0 : T261;
  assign T261 = T68 ? 3'h0 : T262;
  assign T262 = T66 ? 3'h1 : T263;
  assign T263 = T64 ? 3'h0 : T264;
  assign T264 = T62 ? 3'h0 : T265;
  assign T265 = T60 ? 3'h0 : T266;
  assign T266 = T58 ? 3'h0 : T267;
  assign T267 = T56 ? 3'h0 : T268;
  assign T268 = T54 ? 3'h0 : T269;
  assign T269 = T52 ? 3'h0 : T270;
  assign T270 = T50 ? 3'h2 : T271;
  assign T271 = T48 ? 3'h2 : T272;
  assign T272 = T46 ? 3'h0 : T273;
  assign T273 = T44 ? 3'h0 : T274;
  assign T274 = T42 ? 3'h0 : T275;
  assign T275 = T40 ? 3'h0 : T276;
  assign T276 = T38 ? 3'h1 : 3'h0;
  assign io_ctrl_op2_sel = reg_op2_sel;
  assign T397 = reset ? 1'h0 : op2_sel;
  assign op2_sel = T102 ? 1'h0 : T277;
  assign T277 = T100 ? 1'h0 : T278;
  assign T278 = T98 ? 1'h0 : T279;
  assign T279 = T96 ? 1'h0 : T280;
  assign T280 = T94 ? 1'h0 : T281;
  assign T281 = T92 ? 1'h0 : T282;
  assign T282 = T90 ? 1'h0 : T283;
  assign T283 = T88 ? 1'h0 : T284;
  assign T284 = T86 ? 1'h0 : T285;
  assign T285 = T84 ? 1'h0 : T286;
  assign T286 = T82 ? 1'h0 : T287;
  assign T287 = T80 ? 1'h0 : T288;
  assign T288 = T78 ? 1'h0 : T289;
  assign T289 = T76 ? 1'h0 : T290;
  assign T290 = T74 ? 1'h0 : T291;
  assign T291 = T72 ? 1'h0 : T292;
  assign T292 = T70 ? 1'h0 : T293;
  assign T293 = T68 ? 1'h0 : T294;
  assign T294 = T66 ? 1'h0 : T295;
  assign T295 = T64 ? 1'h1 : T296;
  assign T296 = T62 ? 1'h1 : T297;
  assign T297 = T60 ? 1'h1 : T298;
  assign T298 = T58 ? 1'h1 : T299;
  assign T299 = T56 ? 1'h1 : T300;
  assign T300 = T54 ? 1'h1 : T301;
  assign T301 = T52 ? 1'h1 : T302;
  assign T302 = T50 ? 1'h1 : T303;
  assign T303 = T48 ? 1'h1 : T304;
  assign T304 = T46 ? 1'h1 : T305;
  assign T305 = T44 ? 1'h1 : T42;
  assign io_ctrl_op1_sel = reg_op1_sel;
  assign io_ctrl_alu_op = reg_alu_op;
  assign T398 = reset ? 4'h0 : alu_op;
  assign alu_op = T102 ? 4'h0 : T306;
  assign T306 = T100 ? 4'h0 : T307;
  assign T307 = T98 ? 4'h1 : T308;
  assign T308 = T96 ? 4'h0 : T309;
  assign T309 = T94 ? 4'h1 : T310;
  assign T310 = T92 ? 4'h3 : T311;
  assign T311 = T90 ? 4'h2 : T312;
  assign T312 = T88 ? 4'hb : T313;
  assign T313 = T86 ? 4'h4 : T314;
  assign T314 = T84 ? 4'h5 : T315;
  assign T315 = T82 ? 4'h7 : T316;
  assign T316 = T80 ? 4'h8 : T317;
  assign T317 = T78 ? 4'h9 : T318;
  assign T318 = T76 ? 4'h6 : T319;
  assign T319 = T74 ? 4'hc : T320;
  assign T320 = T72 ? 4'hd : T321;
  assign T321 = T70 ? 4'he : T322;
  assign T322 = T68 ? 4'h0 : T323;
  assign T323 = T66 ? 4'h0 : T324;
  assign T324 = T64 ? 4'h0 : T325;
  assign T325 = T62 ? 4'h3 : T326;
  assign T326 = T60 ? 4'h2 : T327;
  assign T327 = T58 ? 4'h4 : T328;
  assign T328 = T56 ? 4'h5 : T329;
  assign T329 = T54 ? 4'h6 : T330;
  assign T330 = T52 ? 4'h0 : T331;
  assign T331 = T50 ? 4'h0 : T332;
  assign T332 = T48 ? 4'h0 : T333;
  assign T333 = T46 ? 4'h0 : T334;
  assign T334 = T44 ? 4'h3 : T335;
  assign T335 = T42 ? 4'ha : 4'h0;
  assign io_ctrl_pc4 = reg_pc4;
  assign T399 = reset ? 32'h0 : io_pc4;
  assign io_ctrl_shamt = reg_shamt;
  assign T400 = reset ? 5'h0 : sa;
  assign sa = io_inst[4'ha:3'h6];
  assign io_ctrl_imm = reg_imm;
  assign T401 = reset ? 32'h0 : id_ext_imm;
  assign id_ext_imm = T367 ? sign_imm : T336;
  assign T336 = T337 ? zero_imm : sign_imm;
  assign zero_imm = {16'h0, imm};
  assign imm = io_inst[4'hf:1'h0];
  assign T337 = extend_type == 1'h0;
  assign extend_type = T102 ? 1'h0 : T338;
  assign T338 = T100 ? 1'h0 : T339;
  assign T339 = T98 ? 1'h0 : T340;
  assign T340 = T96 ? 1'h0 : T341;
  assign T341 = T94 ? 1'h0 : T342;
  assign T342 = T92 ? 1'h0 : T343;
  assign T343 = T90 ? 1'h0 : T344;
  assign T344 = T88 ? 1'h0 : T345;
  assign T345 = T86 ? 1'h0 : T346;
  assign T346 = T84 ? 1'h0 : T347;
  assign T347 = T82 ? 1'h0 : T348;
  assign T348 = T80 ? 1'h0 : T349;
  assign T349 = T78 ? 1'h0 : T350;
  assign T350 = T76 ? 1'h0 : T351;
  assign T351 = T74 ? 1'h0 : T352;
  assign T352 = T72 ? 1'h0 : T353;
  assign T353 = T70 ? 1'h0 : T354;
  assign T354 = T68 ? 1'h0 : T355;
  assign T355 = T66 ? 1'h0 : T356;
  assign T356 = T64 ? 1'h1 : T357;
  assign T357 = T62 ? 1'h0 : T358;
  assign T358 = T60 ? 1'h0 : T359;
  assign T359 = T58 ? 1'h0 : T360;
  assign T360 = T56 ? 1'h1 : T361;
  assign T361 = T54 ? 1'h1 : T362;
  assign T362 = T52 ? 1'h0 : T363;
  assign T363 = T50 ? 1'h1 : T364;
  assign T364 = T48 ? 1'h1 : T365;
  assign T365 = T46 ? 1'h1 : T44;
  assign sign_imm = {T366, imm};
  assign T366 = 16'h0 - T402;
  assign T402 = {15'h0, sign};
  assign sign = io_inst[4'hf:4'hf];
  assign T367 = extend_type == 1'h1;
  assign io_ctrl_data_b = reg_data_b;
  assign T403 = reset ? 32'h0 : op2;
  assign io_ctrl_data_a = reg_data_a;
  assign T404 = reset ? 32'h0 : op1;
  assign io_ctrl_inst = reg_inst;
  assign T405 = reset ? 32'h0 : inst;
  assign io_rt = T368;
  assign T368 = io_inst[5'h14:5'h10];
  assign io_rs = T369;
  assign T369 = io_inst[5'h19:5'h15];
  assign io_jrpc = op1;
  assign io_jpc = T370;
  assign T370 = {T372, T371};
  assign T371 = {addr, 2'h0};
  assign addr = io_inst[5'h19:1'h0];
  assign T372 = io_pc4[5'h1f:5'h1c];
  assign io_bpc = T406;
  assign T406 = T373[5'h1f:1'h0];
  assign T373 = T407 + T374;
  assign T374 = sign_imm << 2'h2;
  assign T407 = {2'h0, io_pc4};
  assign io_pcsource = T375;
  assign T375 = brt ? T376 : 2'h0;
  assign T376 = T385 ? 2'h1 : T377;
  assign T377 = T384 ? 2'h1 : T378;
  assign T378 = T383 ? 2'h2 : T379;
  assign T379 = T382 ? 2'h0 : T380;
  assign T380 = T381 ? 2'h3 : 2'h0;
  assign T381 = br_type == 5'h3;
  assign T382 = br_type == 5'h0;
  assign T383 = br_type == 5'h4;
  assign T384 = br_type == 5'h2;
  assign T385 = br_type == 5'h1;
  RegisterFile RegisterFile(.clk(clk), .reset(reset),
       .io_addr_a( rs ),
       .io_data_a( RegisterFile_io_data_a ),
       .io_addr_b( rt ),
       .io_data_b( RegisterFile_io_data_b ),
       .io_addr_t( io_rf_addr_t ),
       .io_data_t( RegisterFile_io_data_t ),
       .io_addr_w( io_wb_rf_addr ),
       .io_data_w( io_wb_rf_data ),
       .io_wen( io_wb_rf_wen ),
       .io_regs( RegisterFile_io_regs )
  );

  always @(posedge clk) begin
    if(reset) begin
      reg_irt <= 5'h0;
    end else if(io_stall) begin
      reg_irt <= 5'h0;
    end else begin
      reg_irt <= rt;
    end
    if(reset) begin
      reg_irs <= 5'h0;
    end else if(io_stall) begin
      reg_irs <= 5'h0;
    end else begin
      reg_irs <= rs;
    end
    if(reset) begin
      reg_brt <= 1'h0;
    end else if(T162) begin
      reg_brt <= 1'h0;
    end else if(T161) begin
      reg_brt <= equ;
    end else if(T105) begin
      reg_brt <= T104;
    end else if(T103) begin
      reg_brt <= 1'h1;
    end else begin
      reg_brt <= T5;
    end
    if(reset) begin
      reg_wb_dst <= 5'h0;
    end else if(T146) begin
      reg_wb_dst <= 5'h1f;
    end else if(T145) begin
      reg_wb_dst <= rt;
    end else if(T112) begin
      reg_wb_dst <= rd;
    end else begin
      reg_wb_dst <= 5'h0;
    end
    if(reset) begin
      reg_mem_wen <= 1'h0;
    end else if(T102) begin
      reg_mem_wen <= 1'h0;
    end else if(T100) begin
      reg_mem_wen <= 1'h0;
    end else if(T98) begin
      reg_mem_wen <= 1'h0;
    end else if(T96) begin
      reg_mem_wen <= 1'h0;
    end else if(T94) begin
      reg_mem_wen <= 1'h0;
    end else if(T92) begin
      reg_mem_wen <= 1'h0;
    end else if(T90) begin
      reg_mem_wen <= 1'h0;
    end else if(T88) begin
      reg_mem_wen <= 1'h0;
    end else if(T86) begin
      reg_mem_wen <= 1'h0;
    end else if(T84) begin
      reg_mem_wen <= 1'h0;
    end else if(T82) begin
      reg_mem_wen <= 1'h0;
    end else if(T80) begin
      reg_mem_wen <= 1'h0;
    end else if(T78) begin
      reg_mem_wen <= 1'h0;
    end else if(T76) begin
      reg_mem_wen <= 1'h0;
    end else if(T74) begin
      reg_mem_wen <= 1'h0;
    end else if(T72) begin
      reg_mem_wen <= 1'h0;
    end else if(T70) begin
      reg_mem_wen <= 1'h0;
    end else if(T68) begin
      reg_mem_wen <= 1'h0;
    end else if(T66) begin
      reg_mem_wen <= 1'h0;
    end else if(T64) begin
      reg_mem_wen <= 1'h0;
    end else if(T62) begin
      reg_mem_wen <= 1'h0;
    end else if(T60) begin
      reg_mem_wen <= 1'h0;
    end else if(T58) begin
      reg_mem_wen <= 1'h0;
    end else if(T56) begin
      reg_mem_wen <= 1'h0;
    end else if(T54) begin
      reg_mem_wen <= 1'h0;
    end else if(T52) begin
      reg_mem_wen <= 1'h0;
    end else if(T50) begin
      reg_mem_wen <= 1'h0;
    end else begin
      reg_mem_wen <= T48;
    end
    if(reset) begin
      reg_mem_ren <= 1'h0;
    end else if(T102) begin
      reg_mem_ren <= 1'h0;
    end else if(T100) begin
      reg_mem_ren <= 1'h0;
    end else if(T98) begin
      reg_mem_ren <= 1'h0;
    end else if(T96) begin
      reg_mem_ren <= 1'h0;
    end else if(T94) begin
      reg_mem_ren <= 1'h0;
    end else if(T92) begin
      reg_mem_ren <= 1'h0;
    end else if(T90) begin
      reg_mem_ren <= 1'h0;
    end else if(T88) begin
      reg_mem_ren <= 1'h0;
    end else if(T86) begin
      reg_mem_ren <= 1'h0;
    end else if(T84) begin
      reg_mem_ren <= 1'h0;
    end else if(T82) begin
      reg_mem_ren <= 1'h0;
    end else if(T80) begin
      reg_mem_ren <= 1'h0;
    end else if(T78) begin
      reg_mem_ren <= 1'h0;
    end else if(T76) begin
      reg_mem_ren <= 1'h0;
    end else if(T74) begin
      reg_mem_ren <= 1'h0;
    end else if(T72) begin
      reg_mem_ren <= 1'h0;
    end else if(T70) begin
      reg_mem_ren <= 1'h0;
    end else if(T68) begin
      reg_mem_ren <= 1'h0;
    end else if(T66) begin
      reg_mem_ren <= 1'h0;
    end else if(T64) begin
      reg_mem_ren <= 1'h0;
    end else if(T62) begin
      reg_mem_ren <= 1'h0;
    end else if(T60) begin
      reg_mem_ren <= 1'h0;
    end else if(T58) begin
      reg_mem_ren <= 1'h0;
    end else if(T56) begin
      reg_mem_ren <= 1'h0;
    end else if(T54) begin
      reg_mem_ren <= 1'h0;
    end else if(T52) begin
      reg_mem_ren <= 1'h0;
    end else begin
      reg_mem_ren <= T50;
    end
    if(reset) begin
      reg_rf_wen <= 1'h0;
    end else if(T102) begin
      reg_rf_wen <= 1'h0;
    end else if(T100) begin
      reg_rf_wen <= 1'h1;
    end else if(T98) begin
      reg_rf_wen <= 1'h1;
    end else if(T96) begin
      reg_rf_wen <= 1'h1;
    end else if(T94) begin
      reg_rf_wen <= 1'h1;
    end else if(T92) begin
      reg_rf_wen <= 1'h1;
    end else if(T90) begin
      reg_rf_wen <= 1'h1;
    end else if(T88) begin
      reg_rf_wen <= 1'h1;
    end else if(T86) begin
      reg_rf_wen <= 1'h1;
    end else if(T84) begin
      reg_rf_wen <= 1'h1;
    end else if(T82) begin
      reg_rf_wen <= 1'h1;
    end else if(T80) begin
      reg_rf_wen <= 1'h1;
    end else if(T78) begin
      reg_rf_wen <= 1'h1;
    end else if(T76) begin
      reg_rf_wen <= 1'h1;
    end else if(T74) begin
      reg_rf_wen <= 1'h1;
    end else if(T72) begin
      reg_rf_wen <= 1'h1;
    end else if(T70) begin
      reg_rf_wen <= 1'h1;
    end else if(T68) begin
      reg_rf_wen <= 1'h0;
    end else if(T66) begin
      reg_rf_wen <= 1'h1;
    end else if(T64) begin
      reg_rf_wen <= 1'h1;
    end else if(T62) begin
      reg_rf_wen <= 1'h1;
    end else if(T60) begin
      reg_rf_wen <= 1'h1;
    end else if(T58) begin
      reg_rf_wen <= 1'h1;
    end else if(T56) begin
      reg_rf_wen <= 1'h1;
    end else if(T54) begin
      reg_rf_wen <= 1'h1;
    end else if(T52) begin
      reg_rf_wen <= 1'h1;
    end else if(T50) begin
      reg_rf_wen <= 1'h1;
    end else if(T48) begin
      reg_rf_wen <= 1'h0;
    end else if(T46) begin
      reg_rf_wen <= 1'h0;
    end else if(T44) begin
      reg_rf_wen <= 1'h0;
    end else if(T42) begin
      reg_rf_wen <= 1'h1;
    end else if(T40) begin
      reg_rf_wen <= 1'h0;
    end else begin
      reg_rf_wen <= T38;
    end
    if(reset) begin
      reg_br_type <= 5'h0;
    end else if(T102) begin
      reg_br_type <= 5'h0;
    end else if(T100) begin
      reg_br_type <= 5'h0;
    end else if(T98) begin
      reg_br_type <= 5'h0;
    end else if(T96) begin
      reg_br_type <= 5'h0;
    end else if(T94) begin
      reg_br_type <= 5'h0;
    end else if(T92) begin
      reg_br_type <= 5'h0;
    end else if(T90) begin
      reg_br_type <= 5'h0;
    end else if(T88) begin
      reg_br_type <= 5'h0;
    end else if(T86) begin
      reg_br_type <= 5'h0;
    end else if(T84) begin
      reg_br_type <= 5'h0;
    end else if(T82) begin
      reg_br_type <= 5'h0;
    end else if(T80) begin
      reg_br_type <= 5'h0;
    end else if(T78) begin
      reg_br_type <= 5'h0;
    end else if(T76) begin
      reg_br_type <= 5'h0;
    end else if(T74) begin
      reg_br_type <= 5'h0;
    end else if(T72) begin
      reg_br_type <= 5'h0;
    end else if(T70) begin
      reg_br_type <= 5'h0;
    end else if(T68) begin
      reg_br_type <= 5'h3;
    end else if(T66) begin
      reg_br_type <= 5'h3;
    end else if(T64) begin
      reg_br_type <= 5'h0;
    end else if(T62) begin
      reg_br_type <= 5'h0;
    end else if(T60) begin
      reg_br_type <= 5'h0;
    end else if(T58) begin
      reg_br_type <= 5'h0;
    end else if(T56) begin
      reg_br_type <= 5'h0;
    end else if(T54) begin
      reg_br_type <= 5'h0;
    end else if(T52) begin
      reg_br_type <= 5'h0;
    end else if(T50) begin
      reg_br_type <= 5'h0;
    end else if(T48) begin
      reg_br_type <= 5'h0;
    end else if(T46) begin
      reg_br_type <= 5'h1;
    end else if(T44) begin
      reg_br_type <= 5'h2;
    end else if(T42) begin
      reg_br_type <= 5'h0;
    end else if(T40) begin
      reg_br_type <= 5'h4;
    end else if(T38) begin
      reg_br_type <= 5'h4;
    end else begin
      reg_br_type <= 5'h0;
    end
    if(reset) begin
      reg_wb_sel <= 3'h0;
    end else if(T102) begin
      reg_wb_sel <= 3'h0;
    end else if(T100) begin
      reg_wb_sel <= 3'h0;
    end else if(T98) begin
      reg_wb_sel <= 3'h0;
    end else if(T96) begin
      reg_wb_sel <= 3'h0;
    end else if(T94) begin
      reg_wb_sel <= 3'h0;
    end else if(T92) begin
      reg_wb_sel <= 3'h0;
    end else if(T90) begin
      reg_wb_sel <= 3'h0;
    end else if(T88) begin
      reg_wb_sel <= 3'h0;
    end else if(T86) begin
      reg_wb_sel <= 3'h0;
    end else if(T84) begin
      reg_wb_sel <= 3'h0;
    end else if(T82) begin
      reg_wb_sel <= 3'h0;
    end else if(T80) begin
      reg_wb_sel <= 3'h0;
    end else if(T78) begin
      reg_wb_sel <= 3'h0;
    end else if(T76) begin
      reg_wb_sel <= 3'h0;
    end else if(T74) begin
      reg_wb_sel <= 3'h0;
    end else if(T72) begin
      reg_wb_sel <= 3'h0;
    end else if(T70) begin
      reg_wb_sel <= 3'h0;
    end else if(T68) begin
      reg_wb_sel <= 3'h0;
    end else if(T66) begin
      reg_wb_sel <= 3'h1;
    end else if(T64) begin
      reg_wb_sel <= 3'h0;
    end else if(T62) begin
      reg_wb_sel <= 3'h0;
    end else if(T60) begin
      reg_wb_sel <= 3'h0;
    end else if(T58) begin
      reg_wb_sel <= 3'h0;
    end else if(T56) begin
      reg_wb_sel <= 3'h0;
    end else if(T54) begin
      reg_wb_sel <= 3'h0;
    end else if(T52) begin
      reg_wb_sel <= 3'h0;
    end else if(T50) begin
      reg_wb_sel <= 3'h2;
    end else if(T48) begin
      reg_wb_sel <= 3'h2;
    end else if(T46) begin
      reg_wb_sel <= 3'h0;
    end else if(T44) begin
      reg_wb_sel <= 3'h0;
    end else if(T42) begin
      reg_wb_sel <= 3'h0;
    end else if(T40) begin
      reg_wb_sel <= 3'h0;
    end else if(T38) begin
      reg_wb_sel <= 3'h1;
    end else begin
      reg_wb_sel <= 3'h0;
    end
    if(reset) begin
      reg_op2_sel <= 1'h0;
    end else if(T102) begin
      reg_op2_sel <= 1'h0;
    end else if(T100) begin
      reg_op2_sel <= 1'h0;
    end else if(T98) begin
      reg_op2_sel <= 1'h0;
    end else if(T96) begin
      reg_op2_sel <= 1'h0;
    end else if(T94) begin
      reg_op2_sel <= 1'h0;
    end else if(T92) begin
      reg_op2_sel <= 1'h0;
    end else if(T90) begin
      reg_op2_sel <= 1'h0;
    end else if(T88) begin
      reg_op2_sel <= 1'h0;
    end else if(T86) begin
      reg_op2_sel <= 1'h0;
    end else if(T84) begin
      reg_op2_sel <= 1'h0;
    end else if(T82) begin
      reg_op2_sel <= 1'h0;
    end else if(T80) begin
      reg_op2_sel <= 1'h0;
    end else if(T78) begin
      reg_op2_sel <= 1'h0;
    end else if(T76) begin
      reg_op2_sel <= 1'h0;
    end else if(T74) begin
      reg_op2_sel <= 1'h0;
    end else if(T72) begin
      reg_op2_sel <= 1'h0;
    end else if(T70) begin
      reg_op2_sel <= 1'h0;
    end else if(T68) begin
      reg_op2_sel <= 1'h0;
    end else if(T66) begin
      reg_op2_sel <= 1'h0;
    end else if(T64) begin
      reg_op2_sel <= 1'h1;
    end else if(T62) begin
      reg_op2_sel <= 1'h1;
    end else if(T60) begin
      reg_op2_sel <= 1'h1;
    end else if(T58) begin
      reg_op2_sel <= 1'h1;
    end else if(T56) begin
      reg_op2_sel <= 1'h1;
    end else if(T54) begin
      reg_op2_sel <= 1'h1;
    end else if(T52) begin
      reg_op2_sel <= 1'h1;
    end else if(T50) begin
      reg_op2_sel <= 1'h1;
    end else if(T48) begin
      reg_op2_sel <= 1'h1;
    end else if(T46) begin
      reg_op2_sel <= 1'h1;
    end else if(T44) begin
      reg_op2_sel <= 1'h1;
    end else begin
      reg_op2_sel <= T42;
    end
    reg_op1_sel <= 1'h0;
    if(reset) begin
      reg_alu_op <= 4'h0;
    end else if(T102) begin
      reg_alu_op <= 4'h0;
    end else if(T100) begin
      reg_alu_op <= 4'h0;
    end else if(T98) begin
      reg_alu_op <= 4'h1;
    end else if(T96) begin
      reg_alu_op <= 4'h0;
    end else if(T94) begin
      reg_alu_op <= 4'h1;
    end else if(T92) begin
      reg_alu_op <= 4'h3;
    end else if(T90) begin
      reg_alu_op <= 4'h2;
    end else if(T88) begin
      reg_alu_op <= 4'hb;
    end else if(T86) begin
      reg_alu_op <= 4'h4;
    end else if(T84) begin
      reg_alu_op <= 4'h5;
    end else if(T82) begin
      reg_alu_op <= 4'h7;
    end else if(T80) begin
      reg_alu_op <= 4'h8;
    end else if(T78) begin
      reg_alu_op <= 4'h9;
    end else if(T76) begin
      reg_alu_op <= 4'h6;
    end else if(T74) begin
      reg_alu_op <= 4'hc;
    end else if(T72) begin
      reg_alu_op <= 4'hd;
    end else if(T70) begin
      reg_alu_op <= 4'he;
    end else if(T68) begin
      reg_alu_op <= 4'h0;
    end else if(T66) begin
      reg_alu_op <= 4'h0;
    end else if(T64) begin
      reg_alu_op <= 4'h0;
    end else if(T62) begin
      reg_alu_op <= 4'h3;
    end else if(T60) begin
      reg_alu_op <= 4'h2;
    end else if(T58) begin
      reg_alu_op <= 4'h4;
    end else if(T56) begin
      reg_alu_op <= 4'h5;
    end else if(T54) begin
      reg_alu_op <= 4'h6;
    end else if(T52) begin
      reg_alu_op <= 4'h0;
    end else if(T50) begin
      reg_alu_op <= 4'h0;
    end else if(T48) begin
      reg_alu_op <= 4'h0;
    end else if(T46) begin
      reg_alu_op <= 4'h0;
    end else if(T44) begin
      reg_alu_op <= 4'h3;
    end else if(T42) begin
      reg_alu_op <= 4'ha;
    end else begin
      reg_alu_op <= 4'h0;
    end
    if(reset) begin
      reg_pc4 <= 32'h0;
    end else begin
      reg_pc4 <= io_pc4;
    end
    if(reset) begin
      reg_shamt <= 5'h0;
    end else begin
      reg_shamt <= sa;
    end
    if(reset) begin
      reg_imm <= 32'h0;
    end else if(T367) begin
      reg_imm <= sign_imm;
    end else if(T337) begin
      reg_imm <= zero_imm;
    end else begin
      reg_imm <= sign_imm;
    end
    if(reset) begin
      reg_data_b <= 32'h0;
    end else begin
      reg_data_b <= op2;
    end
    if(reset) begin
      reg_data_a <= 32'h0;
    end else begin
      reg_data_a <= op1;
    end
    if(reset) begin
      reg_inst <= 32'h0;
    end else if(io_stall) begin
      reg_inst <= 32'h0;
    end else begin
      reg_inst <= io_inst;
    end
  end
endmodule

module PipeEXE(input clk, input reset,
    input [31:0] io_id_inst,
    input [31:0] io_id_data_a,
    input [31:0] io_id_data_b,
    input [31:0] io_id_imm,
    input [4:0] io_id_shamt,
    input [31:0] io_id_pc4,
    input [3:0] io_id_alu_op,
    input  io_id_op1_sel,
    input  io_id_op2_sel,
    input [1:0] io_id_wb_sel,
    input [4:0] io_id_wb_dst,
    input [2:0] io_id_br_type,
    input  io_id_rf_wen,
    input  io_id_mem_ren,
    input  io_id_mem_wen,
    input  io_id_brt,
    input [4:0] io_id_rs,
    input [4:0] io_id_rt,
    output[31:0] io_ctrl_inst,
    output[31:0] io_ctrl_pc4,
    output[31:0] io_ctrl_alu_out,
    output[31:0] io_ctrl_data_b,
    output[4:0] io_ctrl_wb_dst,
    output[4:0] io_ctrl_rs,
    output[4:0] io_ctrl_rt,
    output[1:0] io_ctrl_wb_sel,
    output io_ctrl_rf_wen,
    output io_ctrl_mem_ren,
    output io_ctrl_mem_wen,
    output[4:0] io_rd,
    output io_wreg,
    output[31:0] io_exe_out
);

  wire[31:0] exec_alu_out;
  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  wire[31:0] T3;
  wire[31:0] T4;
  wire[31:0] T5;
  wire[31:0] T6;
  wire[31:0] T7;
  wire[31:0] T8;
  wire[31:0] T9;
  wire[31:0] T10;
  wire[31:0] T11;
  wire[31:0] T12;
  wire[31:0] T13;
  wire[31:0] T14;
  wire[31:0] T15;
  wire[15:0] T16;
  wire[31:0] op2;
  wire[31:0] T17;
  wire T18;
  wire T19;
  wire T20;
  wire[31:0] T21;
  wire[31:0] T22;
  wire[31:0] op1;
  wire T23;
  wire[31:0] T24;
  wire T25;
  wire[31:0] T26;
  wire[31:0] T27;
  wire[31:0] T28;
  wire T29;
  wire[31:0] T30;
  wire[31:0] T31;
  wire[31:0] T32;
  wire T33;
  wire[31:0] T34;
  wire[31:0] T35;
  wire[31:0] T36;
  wire T37;
  wire[31:0] T38;
  wire[31:0] T39;
  wire[31:0] T40;
  wire T41;
  wire[31:0] T42;
  wire[31:0] T43;
  wire[62:0] T44;
  wire T45;
  wire[31:0] T68;
  wire T46;
  wire T47;
  wire T48;
  wire[31:0] T69;
  wire T49;
  wire T50;
  wire[31:0] T51;
  wire[31:0] T52;
  wire T53;
  wire[31:0] T54;
  wire[31:0] T55;
  wire T56;
  wire[31:0] T57;
  wire T58;
  wire[31:0] T59;
  wire T60;
  wire[31:0] T61;
  wire T62;
  wire[31:0] T63;
  wire T64;
  wire[31:0] T65;
  wire[31:0] T66;
  wire T67;
  reg  reg_mem_wen;
  wire T70;
  reg  reg_mem_ren;
  wire T71;
  reg  reg_rf_wen;
  wire T72;
  reg [1:0] reg_wb_sel;
  wire[1:0] T73;
  reg [4:0] reg_rt;
  wire[4:0] T74;
  reg [4:0] reg_rs;
  wire[4:0] T75;
  reg [4:0] reg_wb_dst;
  wire[4:0] T76;
  reg [31:0] reg_data_b;
  wire[31:0] T77;
  reg [31:0] reg_exec_out;
  wire[31:0] T78;
  reg [31:0] reg_pc4;
  wire[31:0] T79;
  reg [31:0] reg_inst;
  wire[31:0] T80;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    reg_mem_wen = {1{$random}};
    reg_mem_ren = {1{$random}};
    reg_rf_wen = {1{$random}};
    reg_wb_sel = {1{$random}};
    reg_rt = {1{$random}};
    reg_rs = {1{$random}};
    reg_wb_dst = {1{$random}};
    reg_data_b = {1{$random}};
    reg_exec_out = {1{$random}};
    reg_pc4 = {1{$random}};
    reg_inst = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_exe_out = exec_alu_out;
  assign exec_alu_out = T0;
  assign T0 = T67 ? T65 : T1;
  assign T1 = T64 ? T63 : T2;
  assign T2 = T62 ? T61 : T3;
  assign T3 = T60 ? T59 : T4;
  assign T4 = T58 ? T57 : T5;
  assign T5 = T56 ? T54 : T6;
  assign T6 = T53 ? T69 : T7;
  assign T7 = T48 ? T68 : T8;
  assign T8 = T45 ? T42 : T9;
  assign T9 = T41 ? T38 : T10;
  assign T10 = T37 ? T34 : T11;
  assign T11 = T33 ? T30 : T12;
  assign T12 = T29 ? T26 : T13;
  assign T13 = T25 ? T21 : T14;
  assign T14 = T20 ? T15 : 32'h0;
  assign T15 = {T16, 16'h0};
  assign T16 = op2[4'hf:1'h0];
  assign op2 = T19 ? io_id_data_b : T17;
  assign T17 = T18 ? io_id_imm : 32'h0;
  assign T18 = io_id_op2_sel == 1'h1;
  assign T19 = io_id_op2_sel == 1'h0;
  assign T20 = io_id_alu_op == 4'ha;
  assign T21 = T22;
  assign T22 = $signed(T24) >>> op1;
  assign op1 = T23 ? io_id_data_a : 32'h0;
  assign T23 = io_id_op1_sel == 1'h0;
  assign T24 = op2;
  assign T25 = io_id_alu_op == 4'he;
  assign T26 = T27;
  assign T27 = T28[5'h1f:1'h0];
  assign T28 = op2 >> op1;
  assign T29 = io_id_alu_op == 4'hd;
  assign T30 = T31;
  assign T31 = T32[5'h1f:1'h0];
  assign T32 = op2 << op1;
  assign T33 = io_id_alu_op == 4'hc;
  assign T34 = T35;
  assign T35 = $signed(T36) >>> io_id_shamt;
  assign T36 = op2;
  assign T37 = io_id_alu_op == 4'h9;
  assign T38 = T39;
  assign T39 = T40[5'h1f:1'h0];
  assign T40 = op2 >> io_id_shamt;
  assign T41 = io_id_alu_op == 4'h8;
  assign T42 = T43;
  assign T43 = T44[5'h1f:1'h0];
  assign T44 = op2 << io_id_shamt;
  assign T45 = io_id_alu_op == 4'h7;
  assign T68 = {31'h0, T46};
  assign T46 = T47;
  assign T47 = op1 < op2;
  assign T48 = io_id_alu_op == 4'h6;
  assign T69 = {31'h0, T49};
  assign T49 = T50;
  assign T50 = $signed(T52) < $signed(T51);
  assign T51 = op2;
  assign T52 = op1;
  assign T53 = io_id_alu_op == 4'h5;
  assign T54 = ~ T55;
  assign T55 = op1 | op2;
  assign T56 = io_id_alu_op == 4'hb;
  assign T57 = op1 ^ op2;
  assign T58 = io_id_alu_op == 4'h4;
  assign T59 = op1 | op2;
  assign T60 = io_id_alu_op == 4'h2;
  assign T61 = op1 & op2;
  assign T62 = io_id_alu_op == 4'h3;
  assign T63 = op1 - op2;
  assign T64 = io_id_alu_op == 4'h1;
  assign T65 = T66[5'h1f:1'h0];
  assign T66 = op1 + op2;
  assign T67 = io_id_alu_op == 4'h0;
  assign io_wreg = io_id_rf_wen;
  assign io_rd = io_id_wb_dst;
  assign io_ctrl_mem_wen = reg_mem_wen;
  assign T70 = reset ? 1'h0 : io_id_mem_wen;
  assign io_ctrl_mem_ren = reg_mem_ren;
  assign T71 = reset ? 1'h0 : io_id_mem_ren;
  assign io_ctrl_rf_wen = reg_rf_wen;
  assign T72 = reset ? 1'h0 : io_id_rf_wen;
  assign io_ctrl_wb_sel = reg_wb_sel;
  assign T73 = reset ? 2'h0 : io_id_wb_sel;
  assign io_ctrl_rt = reg_rt;
  assign T74 = reset ? 5'h0 : io_id_rt;
  assign io_ctrl_rs = reg_rs;
  assign T75 = reset ? 5'h0 : io_id_rs;
  assign io_ctrl_wb_dst = reg_wb_dst;
  assign T76 = reset ? 5'h0 : io_id_wb_dst;
  assign io_ctrl_data_b = reg_data_b;
  assign T77 = reset ? 32'h0 : io_id_data_b;
  assign io_ctrl_alu_out = reg_exec_out;
  assign T78 = reset ? 32'h0 : exec_alu_out;
  assign io_ctrl_pc4 = reg_pc4;
  assign T79 = reset ? 32'h0 : io_id_pc4;
  assign io_ctrl_inst = reg_inst;
  assign T80 = reset ? 32'h0 : io_id_inst;

  always @(posedge clk) begin
    if(reset) begin
      reg_mem_wen <= 1'h0;
    end else begin
      reg_mem_wen <= io_id_mem_wen;
    end
    if(reset) begin
      reg_mem_ren <= 1'h0;
    end else begin
      reg_mem_ren <= io_id_mem_ren;
    end
    if(reset) begin
      reg_rf_wen <= 1'h0;
    end else begin
      reg_rf_wen <= io_id_rf_wen;
    end
    if(reset) begin
      reg_wb_sel <= 2'h0;
    end else begin
      reg_wb_sel <= io_id_wb_sel;
    end
    if(reset) begin
      reg_rt <= 5'h0;
    end else begin
      reg_rt <= io_id_rt;
    end
    if(reset) begin
      reg_rs <= 5'h0;
    end else begin
      reg_rs <= io_id_rs;
    end
    if(reset) begin
      reg_wb_dst <= 5'h0;
    end else begin
      reg_wb_dst <= io_id_wb_dst;
    end
    if(reset) begin
      reg_data_b <= 32'h0;
    end else begin
      reg_data_b <= io_id_data_b;
    end
    if(reset) begin
      reg_exec_out <= 32'h0;
    end else begin
      reg_exec_out <= exec_alu_out;
    end
    if(reset) begin
      reg_pc4 <= 32'h0;
    end else begin
      reg_pc4 <= io_id_pc4;
    end
    if(reset) begin
      reg_inst <= 32'h0;
    end else begin
      reg_inst <= io_id_inst;
    end
  end
endmodule

module PipeMEM(input clk, input reset,
    input [31:0] io_exe_inst,
    input [31:0] io_exe_pc4,
    input [31:0] io_exe_alu_out,
    input [31:0] io_exe_data_b,
    input [4:0] io_exe_wb_dst,
    input [4:0] io_exe_rs,
    input [4:0] io_exe_rt,
    input [1:0] io_exe_wb_sel,
    input  io_exe_rf_wen,
    input  io_exe_mem_ren,
    input  io_exe_mem_wen,
    output io_mem_wen,
    output[31:0] io_mem_addr,
    output[31:0] io_mem_data_a,
    input [31:0] io_mem_data_b,
    output[31:0] io_ctrl_inst,
    output[31:0] io_ctrl_pc4,
    output[31:0] io_ctrl_mem_data,
    output io_ctrl_mem_ren,
    output[4:0] io_ctrl_wb_dst,
    output[1:0] io_ctrl_wb_sel,
    output io_ctrl_rf_wen,
    output[4:0] io_rd,
    output io_wreg,
    output[31:0] io_mem_out,
    output[4:0] io_mem_dst
);

  wire[31:0] mem_out;
  wire[31:0] T0;
  wire[31:0] T1;
  wire T2;
  wire[2:0] T10;
  wire[31:0] T3;
  wire T4;
  wire[2:0] T11;
  wire T5;
  wire[2:0] T12;
  reg  reg_rf_wen;
  wire T13;
  reg [1:0] reg_wb_sel;
  wire[1:0] T14;
  reg [4:0] reg_wb_dst;
  wire[4:0] T15;
  reg  reg_mem_ren;
  wire T16;
  reg [31:0] reg_mem_out;
  wire[31:0] T17;
  reg [31:0] reg_pc4;
  wire[31:0] T18;
  reg [31:0] reg_inst;
  wire[31:0] T19;
  wire[31:0] T6;
  wire T7;
  wire T8;
  reg [4:0] reg_rd;
  wire[4:0] T20;
  wire[31:0] T21;
  wire[29:0] T9;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    reg_rf_wen = {1{$random}};
    reg_wb_sel = {1{$random}};
    reg_wb_dst = {1{$random}};
    reg_mem_ren = {1{$random}};
    reg_mem_out = {1{$random}};
    reg_pc4 = {1{$random}};
    reg_inst = {1{$random}};
    reg_rd = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_mem_dst = io_exe_wb_dst;
  assign io_mem_out = mem_out;
  assign mem_out = T5 ? io_exe_alu_out : T0;
  assign T0 = T4 ? T3 : T1;
  assign T1 = T2 ? io_exe_pc4 : 32'h0;
  assign T2 = T10 == 3'h1;
  assign T10 = {1'h0, io_exe_wb_sel};
  assign T3 = io_exe_mem_wen ? io_exe_data_b : io_mem_data_b;
  assign T4 = T11 == 3'h2;
  assign T11 = {1'h0, io_exe_wb_sel};
  assign T5 = T12 == 3'h0;
  assign T12 = {1'h0, io_exe_wb_sel};
  assign io_wreg = io_exe_rf_wen;
  assign io_rd = io_exe_wb_dst;
  assign io_ctrl_rf_wen = reg_rf_wen;
  assign T13 = reset ? 1'h0 : io_exe_rf_wen;
  assign io_ctrl_wb_sel = reg_wb_sel;
  assign T14 = reset ? 2'h0 : io_exe_wb_sel;
  assign io_ctrl_wb_dst = reg_wb_dst;
  assign T15 = reset ? 5'h0 : io_exe_wb_dst;
  assign io_ctrl_mem_ren = reg_mem_ren;
  assign T16 = reset ? 1'h0 : io_exe_mem_ren;
  assign io_ctrl_mem_data = reg_mem_out;
  assign T17 = reset ? 32'h0 : mem_out;
  assign io_ctrl_pc4 = reg_pc4;
  assign T18 = reset ? 32'h0 : io_exe_pc4;
  assign io_ctrl_inst = reg_inst;
  assign T19 = reset ? 32'h0 : io_exe_inst;
  assign io_mem_data_a = T6;
  assign T6 = T7 ? reg_mem_out : io_exe_data_b;
  assign T7 = reg_mem_ren & T8;
  assign T8 = io_exe_rt == reg_rd;
  assign T20 = reset ? 5'h0 : io_exe_wb_dst;
  assign io_mem_addr = T21;
  assign T21 = {2'h0, T9};
  assign T9 = io_exe_alu_out >> 2'h2;
  assign io_mem_wen = io_exe_mem_wen;

  always @(posedge clk) begin
    if(reset) begin
      reg_rf_wen <= 1'h0;
    end else begin
      reg_rf_wen <= io_exe_rf_wen;
    end
    if(reset) begin
      reg_wb_sel <= 2'h0;
    end else begin
      reg_wb_sel <= io_exe_wb_sel;
    end
    if(reset) begin
      reg_wb_dst <= 5'h0;
    end else begin
      reg_wb_dst <= io_exe_wb_dst;
    end
    if(reset) begin
      reg_mem_ren <= 1'h0;
    end else begin
      reg_mem_ren <= io_exe_mem_ren;
    end
    if(reset) begin
      reg_mem_out <= 32'h0;
    end else if(T5) begin
      reg_mem_out <= io_exe_alu_out;
    end else if(T4) begin
      reg_mem_out <= T3;
    end else if(T2) begin
      reg_mem_out <= io_exe_pc4;
    end else begin
      reg_mem_out <= 32'h0;
    end
    if(reset) begin
      reg_pc4 <= 32'h0;
    end else begin
      reg_pc4 <= io_exe_pc4;
    end
    if(reset) begin
      reg_inst <= 32'h0;
    end else begin
      reg_inst <= io_exe_inst;
    end
    if(reset) begin
      reg_rd <= 5'h0;
    end else begin
      reg_rd <= io_exe_wb_dst;
    end
  end
endmodule

module PipeWB(input clk, input reset,
    input [31:0] io_mem_inst,
    input [31:0] io_mem_pc4,
    input [31:0] io_mem_mem_data,
    input  io_mem_mem_ren,
    input [4:0] io_mem_wb_dst,
    input [1:0] io_mem_wb_sel,
    input  io_mem_rf_wen,
    output io_ctrl_rf_wen,
    output[4:0] io_ctrl_rf_addr,
    output[31:0] io_ctrl_rf_data,
    output[31:0] io_inst,
    output[4:0] io_rd,
    output io_wreg
);

  reg [31:0] reg_inst;
  wire[31:0] T0;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    reg_inst = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_wreg = io_mem_rf_wen;
  assign io_rd = io_mem_wb_dst;
  assign io_inst = reg_inst;
  assign T0 = reset ? 32'h0 : io_mem_inst;
  assign io_ctrl_rf_data = io_mem_mem_data;
  assign io_ctrl_rf_addr = io_mem_wb_dst;
  assign io_ctrl_rf_wen = io_mem_rf_wen;

  always @(posedge clk) begin
    if(reset) begin
      reg_inst <= 32'h0;
    end else begin
      reg_inst <= io_mem_inst;
    end
  end
endmodule

module PipeStall(
    input [4:0] io_rs_id,
    input [4:0] io_rt_id,
    input [4:0] io_rd_mem,
    input [4:0] io_rd_exe,
    input [4:0] io_rd_wb,
    input  io_wreg_mem,
    input  io_wreg_exe,
    input  io_wreg_wb,
    input  io_exe_mem_ren,
    input [31:0] io_inst,
    output io_stall
);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire[31:0] T9;


  assign io_stall = T0;
  assign T0 = T7 & T1;
  assign T1 = T3 & T2;
  assign T2 = io_rd_exe != 5'h0;
  assign T3 = io_exe_mem_ren & T4;
  assign T4 = T6 | T5;
  assign T5 = io_rt_id == io_rd_exe;
  assign T6 = io_rs_id == io_rd_exe;
  assign T7 = T8 == 1'h0;
  assign T8 = T9 == 32'hac000000;
  assign T9 = io_inst & 32'hfc000000;
endmodule

module CoreCPU(input clk, input reset,
    output io_mem_wen,
    output[31:0] io_mem_addr,
    output[31:0] io_mem_data_a,
    input [31:0] io_mem_data_b,
    output[31:0] io_pc,
    input [31:0] io_inst,
    output[1023:0] io_debug_regs,
    output[31:0] io_debug_if_inst,
    output[31:0] io_debug_id_inst,
    output[31:0] io_debug_exe_inst,
    output[31:0] io_debug_mem_inst,
    output[31:0] io_debug_wb_inst
);

  wire[31:0] PipeIF_io_inst;
  wire[31:0] PipeIF_io_pc;
  wire[31:0] PipeEXE_io_ctrl_inst;
  wire[31:0] PipeEXE_io_ctrl_pc4;
  wire[31:0] PipeEXE_io_ctrl_alu_out;
  wire[31:0] PipeEXE_io_ctrl_data_b;
  wire[4:0] PipeEXE_io_ctrl_wb_dst;
  wire[4:0] PipeEXE_io_ctrl_rs;
  wire[4:0] PipeEXE_io_ctrl_rt;
  wire[1:0] PipeEXE_io_ctrl_wb_sel;
  wire PipeEXE_io_ctrl_rf_wen;
  wire PipeEXE_io_ctrl_mem_ren;
  wire PipeEXE_io_ctrl_mem_wen;
  wire[4:0] PipeEXE_io_rd;
  wire PipeEXE_io_wreg;
  wire[31:0] PipeEXE_io_exe_out;
  wire PipeMEM_io_mem_wen;
  wire[31:0] PipeMEM_io_mem_addr;
  wire[31:0] PipeMEM_io_mem_data_a;
  wire[31:0] PipeMEM_io_ctrl_inst;
  wire[31:0] PipeMEM_io_ctrl_pc4;
  wire[31:0] PipeMEM_io_ctrl_mem_data;
  wire PipeMEM_io_ctrl_mem_ren;
  wire[4:0] PipeMEM_io_ctrl_wb_dst;
  wire[1:0] PipeMEM_io_ctrl_wb_sel;
  wire PipeMEM_io_ctrl_rf_wen;
  wire[4:0] PipeMEM_io_rd;
  wire PipeMEM_io_wreg;
  wire[31:0] PipeMEM_io_mem_out;
  wire[4:0] PipeMEM_io_mem_dst;
  wire PipeWB_io_ctrl_rf_wen;
  wire[4:0] PipeWB_io_ctrl_rf_addr;
  wire[31:0] PipeWB_io_ctrl_rf_data;
  wire[31:0] PipeWB_io_inst;
  wire[4:0] PipeWB_io_rd;
  wire PipeWB_io_wreg;
  wire PipeStall_io_stall;
  wire[1:0] PipeID_io_pcsource;
  wire[31:0] PipeID_io_bpc;
  wire[31:0] PipeID_io_jpc;
  wire[31:0] PipeID_io_jrpc;
  wire[4:0] PipeID_io_rs;
  wire[4:0] PipeID_io_rt;
  wire[31:0] PipeID_io_ctrl_inst;
  wire[31:0] PipeID_io_ctrl_data_a;
  wire[31:0] PipeID_io_ctrl_data_b;
  wire[31:0] PipeID_io_ctrl_imm;
  wire[4:0] PipeID_io_ctrl_shamt;
  wire[31:0] PipeID_io_ctrl_pc4;
  wire[3:0] PipeID_io_ctrl_alu_op;
  wire PipeID_io_ctrl_op1_sel;
  wire PipeID_io_ctrl_op2_sel;
  wire[1:0] PipeID_io_ctrl_wb_sel;
  wire[4:0] PipeID_io_ctrl_wb_dst;
  wire[2:0] PipeID_io_ctrl_br_type;
  wire PipeID_io_ctrl_rf_wen;
  wire PipeID_io_ctrl_mem_ren;
  wire PipeID_io_ctrl_mem_wen;
  wire PipeID_io_ctrl_brt;
  wire[4:0] PipeID_io_ctrl_rs;
  wire[4:0] PipeID_io_ctrl_rt;
  wire[1023:0] PipeID_io_regs;


  assign io_debug_wb_inst = PipeWB_io_inst;
  assign io_debug_mem_inst = PipeMEM_io_ctrl_inst;
  assign io_debug_exe_inst = PipeEXE_io_ctrl_inst;
  assign io_debug_id_inst = PipeID_io_ctrl_inst;
  assign io_debug_if_inst = PipeIF_io_inst;
  assign io_debug_regs = PipeID_io_regs;
  assign io_pc = PipeIF_io_pc;
  assign io_mem_data_a = PipeMEM_io_mem_data_a;
  assign io_mem_addr = PipeMEM_io_mem_addr;
  assign io_mem_wen = PipeMEM_io_mem_wen;
  PipeIF PipeIF(.clk(clk), .reset(reset),
       .io_pcsource( PipeID_io_pcsource ),
       .io_bpc( PipeID_io_bpc ),
       .io_jpc( PipeID_io_jpc ),
       .io_jrpc( PipeID_io_jrpc ),
       .io_stall( PipeStall_io_stall ),
       .io_brt( PipeID_io_ctrl_brt ),
       .io_imem( io_inst ),
       .io_inst( PipeIF_io_inst ),
       .io_pc( PipeIF_io_pc )
  );
  PipeID PipeID(.clk(clk), .reset(reset),
       .io_inst( PipeIF_io_inst ),
       .io_pc4( PipeIF_io_pc ),
       .io_pcsource( PipeID_io_pcsource ),
       .io_bpc( PipeID_io_bpc ),
       .io_jpc( PipeID_io_jpc ),
       .io_jrpc( PipeID_io_jrpc ),
       .io_stall( PipeStall_io_stall ),
       .io_rs( PipeID_io_rs ),
       .io_rt( PipeID_io_rt ),
       .io_wb_rf_wen( PipeWB_io_ctrl_rf_wen ),
       .io_wb_rf_addr( PipeWB_io_ctrl_rf_addr ),
       .io_wb_rf_data( PipeWB_io_ctrl_rf_data ),
       .io_ctrl_inst( PipeID_io_ctrl_inst ),
       .io_ctrl_data_a( PipeID_io_ctrl_data_a ),
       .io_ctrl_data_b( PipeID_io_ctrl_data_b ),
       .io_ctrl_imm( PipeID_io_ctrl_imm ),
       .io_ctrl_shamt( PipeID_io_ctrl_shamt ),
       .io_ctrl_pc4( PipeID_io_ctrl_pc4 ),
       .io_ctrl_alu_op( PipeID_io_ctrl_alu_op ),
       .io_ctrl_op1_sel( PipeID_io_ctrl_op1_sel ),
       .io_ctrl_op2_sel( PipeID_io_ctrl_op2_sel ),
       .io_ctrl_wb_sel( PipeID_io_ctrl_wb_sel ),
       .io_ctrl_wb_dst( PipeID_io_ctrl_wb_dst ),
       .io_ctrl_br_type( PipeID_io_ctrl_br_type ),
       .io_ctrl_rf_wen( PipeID_io_ctrl_rf_wen ),
       .io_ctrl_mem_ren( PipeID_io_ctrl_mem_ren ),
       .io_ctrl_mem_wen( PipeID_io_ctrl_mem_wen ),
       .io_ctrl_brt( PipeID_io_ctrl_brt ),
       .io_ctrl_rs( PipeID_io_ctrl_rs ),
       .io_ctrl_rt( PipeID_io_ctrl_rt ),
       //.io_rf_addr_t(  )
       //.io_rf_data_t(  )
       .io_regs( PipeID_io_regs ),
       .io_exe_out( PipeEXE_io_exe_out ),
       .io_mem_out( PipeMEM_io_mem_out ),
       .io_mem_dst( PipeMEM_io_mem_dst )
  );
`ifndef SYNTHESIS
// synthesis translate_off
    assign PipeID.io_rf_addr_t = {1{$random}};
// synthesis translate_on
`endif
  PipeEXE PipeEXE(.clk(clk), .reset(reset),
       .io_id_inst( PipeID_io_ctrl_inst ),
       .io_id_data_a( PipeID_io_ctrl_data_a ),
       .io_id_data_b( PipeID_io_ctrl_data_b ),
       .io_id_imm( PipeID_io_ctrl_imm ),
       .io_id_shamt( PipeID_io_ctrl_shamt ),
       .io_id_pc4( PipeID_io_ctrl_pc4 ),
       .io_id_alu_op( PipeID_io_ctrl_alu_op ),
       .io_id_op1_sel( PipeID_io_ctrl_op1_sel ),
       .io_id_op2_sel( PipeID_io_ctrl_op2_sel ),
       .io_id_wb_sel( PipeID_io_ctrl_wb_sel ),
       .io_id_wb_dst( PipeID_io_ctrl_wb_dst ),
       .io_id_br_type( PipeID_io_ctrl_br_type ),
       .io_id_rf_wen( PipeID_io_ctrl_rf_wen ),
       .io_id_mem_ren( PipeID_io_ctrl_mem_ren ),
       .io_id_mem_wen( PipeID_io_ctrl_mem_wen ),
       .io_id_brt( PipeID_io_ctrl_brt ),
       .io_id_rs( PipeID_io_ctrl_rs ),
       .io_id_rt( PipeID_io_ctrl_rt ),
       .io_ctrl_inst( PipeEXE_io_ctrl_inst ),
       .io_ctrl_pc4( PipeEXE_io_ctrl_pc4 ),
       .io_ctrl_alu_out( PipeEXE_io_ctrl_alu_out ),
       .io_ctrl_data_b( PipeEXE_io_ctrl_data_b ),
       .io_ctrl_wb_dst( PipeEXE_io_ctrl_wb_dst ),
       .io_ctrl_rs( PipeEXE_io_ctrl_rs ),
       .io_ctrl_rt( PipeEXE_io_ctrl_rt ),
       .io_ctrl_wb_sel( PipeEXE_io_ctrl_wb_sel ),
       .io_ctrl_rf_wen( PipeEXE_io_ctrl_rf_wen ),
       .io_ctrl_mem_ren( PipeEXE_io_ctrl_mem_ren ),
       .io_ctrl_mem_wen( PipeEXE_io_ctrl_mem_wen ),
       .io_rd( PipeEXE_io_rd ),
       .io_wreg( PipeEXE_io_wreg ),
       .io_exe_out( PipeEXE_io_exe_out )
  );
  PipeMEM PipeMEM(.clk(clk), .reset(reset),
       .io_exe_inst( PipeEXE_io_ctrl_inst ),
       .io_exe_pc4( PipeEXE_io_ctrl_pc4 ),
       .io_exe_alu_out( PipeEXE_io_ctrl_alu_out ),
       .io_exe_data_b( PipeEXE_io_ctrl_data_b ),
       .io_exe_wb_dst( PipeEXE_io_ctrl_wb_dst ),
       .io_exe_rs( PipeEXE_io_ctrl_rs ),
       .io_exe_rt( PipeEXE_io_ctrl_rt ),
       .io_exe_wb_sel( PipeEXE_io_ctrl_wb_sel ),
       .io_exe_rf_wen( PipeEXE_io_ctrl_rf_wen ),
       .io_exe_mem_ren( PipeEXE_io_ctrl_mem_ren ),
       .io_exe_mem_wen( PipeEXE_io_ctrl_mem_wen ),
       .io_mem_wen( PipeMEM_io_mem_wen ),
       .io_mem_addr( PipeMEM_io_mem_addr ),
       .io_mem_data_a( PipeMEM_io_mem_data_a ),
       .io_mem_data_b( io_mem_data_b ),
       .io_ctrl_inst( PipeMEM_io_ctrl_inst ),
       .io_ctrl_pc4( PipeMEM_io_ctrl_pc4 ),
       .io_ctrl_mem_data( PipeMEM_io_ctrl_mem_data ),
       .io_ctrl_mem_ren( PipeMEM_io_ctrl_mem_ren ),
       .io_ctrl_wb_dst( PipeMEM_io_ctrl_wb_dst ),
       .io_ctrl_wb_sel( PipeMEM_io_ctrl_wb_sel ),
       .io_ctrl_rf_wen( PipeMEM_io_ctrl_rf_wen ),
       .io_rd( PipeMEM_io_rd ),
       .io_wreg( PipeMEM_io_wreg ),
       .io_mem_out( PipeMEM_io_mem_out ),
       .io_mem_dst( PipeMEM_io_mem_dst )
  );
  PipeWB PipeWB(.clk(clk), .reset(reset),
       .io_mem_inst( PipeMEM_io_ctrl_inst ),
       .io_mem_pc4( PipeMEM_io_ctrl_pc4 ),
       .io_mem_mem_data( PipeMEM_io_ctrl_mem_data ),
       .io_mem_mem_ren( PipeMEM_io_ctrl_mem_ren ),
       .io_mem_wb_dst( PipeMEM_io_ctrl_wb_dst ),
       .io_mem_wb_sel( PipeMEM_io_ctrl_wb_sel ),
       .io_mem_rf_wen( PipeMEM_io_ctrl_rf_wen ),
       .io_ctrl_rf_wen( PipeWB_io_ctrl_rf_wen ),
       .io_ctrl_rf_addr( PipeWB_io_ctrl_rf_addr ),
       .io_ctrl_rf_data( PipeWB_io_ctrl_rf_data ),
       .io_inst( PipeWB_io_inst ),
       .io_rd( PipeWB_io_rd ),
       .io_wreg( PipeWB_io_wreg )
  );
  PipeStall PipeStall(
       .io_rs_id( PipeID_io_rs ),
       .io_rt_id( PipeID_io_rt ),
       .io_rd_mem( PipeMEM_io_rd ),
       .io_rd_exe( PipeEXE_io_rd ),
       .io_rd_wb( PipeWB_io_rd ),
       .io_wreg_mem( PipeMEM_io_wreg ),
       .io_wreg_exe( PipeEXE_io_wreg ),
       .io_wreg_wb( PipeWB_io_wreg ),
       .io_exe_mem_ren( PipeID_io_ctrl_mem_ren ),
       .io_inst( PipeIF_io_inst ),
       .io_stall( PipeStall_io_stall )
  );
endmodule

module Memory(input clk, input reset,
    input  io_wen,
    input [31:0] io_addr,
    input [31:0] io_data_a,
    output[31:0] io_data_b
);

  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  wire[31:0] T3;
  wire[31:0] T4;
  wire[31:0] T5;
  reg [31:0] memory_0;
  wire[31:0] T163;
  wire[31:0] T6;
  wire T7;
  wire T8;
  wire[31:0] T9;
  wire[4:0] T10;
  wire[4:0] T164;
  reg [31:0] memory_1;
  wire[31:0] T165;
  wire[31:0] T11;
  wire T12;
  wire T13;
  wire T14;
  wire[31:0] T15;
  reg [31:0] memory_2;
  wire[31:0] T166;
  wire[31:0] T16;
  wire T17;
  wire T18;
  reg [31:0] memory_3;
  wire[31:0] T167;
  wire[31:0] T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire[31:0] T24;
  wire[31:0] T25;
  reg [31:0] memory_4;
  wire[31:0] T168;
  wire[31:0] T26;
  wire T27;
  wire T28;
  reg [31:0] memory_5;
  wire[31:0] T169;
  wire[31:0] T29;
  reg [31:0] R30;
  wire[31:0] T170;
  wire T31;
  wire T32;
  wire T33;
  wire[31:0] T34;
  reg [31:0] memory_6;
  wire[31:0] T171;
  wire[31:0] T35;
  reg [31:0] R36;
  wire[31:0] T172;
  wire T37;
  wire T38;
  reg [31:0] memory_7;
  wire[31:0] T173;
  wire[31:0] T39;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire[31:0] T45;
  wire[31:0] T46;
  wire[31:0] T47;
  reg [31:0] memory_8;
  wire[31:0] T174;
  wire[31:0] T48;
  wire T49;
  wire T50;
  reg [31:0] memory_9;
  wire[31:0] T175;
  wire[31:0] T51;
  wire T52;
  wire T53;
  wire T54;
  wire[31:0] T55;
  reg [31:0] memory_10;
  wire[31:0] T176;
  wire[31:0] T56;
  wire T57;
  wire T58;
  reg [31:0] memory_11;
  wire[31:0] T177;
  wire[31:0] T59;
  wire T60;
  wire T61;
  wire T62;
  wire T63;
  wire[31:0] T64;
  wire[31:0] T65;
  reg [31:0] memory_12;
  wire[31:0] T178;
  wire[31:0] T66;
  wire T67;
  wire T68;
  reg [31:0] memory_13;
  wire[31:0] T179;
  wire[31:0] T69;
  wire T70;
  wire T71;
  wire T72;
  wire[31:0] T73;
  reg [31:0] memory_14;
  wire[31:0] T180;
  wire[31:0] T74;
  wire T75;
  wire T76;
  reg [31:0] memory_15;
  wire[31:0] T181;
  wire[31:0] T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire T82;
  wire T83;
  wire[31:0] T84;
  wire[31:0] T85;
  wire[31:0] T86;
  wire[31:0] T87;
  reg [31:0] memory_16;
  wire[31:0] T182;
  wire[31:0] T88;
  wire T89;
  wire T90;
  reg [31:0] memory_17;
  wire[31:0] T183;
  wire[31:0] T91;
  wire T92;
  wire T93;
  wire T94;
  wire[31:0] T95;
  reg [31:0] memory_18;
  wire[31:0] T184;
  wire[31:0] T96;
  wire T97;
  wire T98;
  reg [31:0] memory_19;
  wire[31:0] T185;
  wire[31:0] T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire[31:0] T104;
  wire[31:0] T105;
  reg [31:0] memory_20;
  wire[31:0] T186;
  wire[31:0] T106;
  wire T107;
  wire T108;
  reg [31:0] memory_21;
  wire[31:0] T187;
  wire[31:0] T109;
  wire T110;
  wire T111;
  wire T112;
  wire[31:0] T113;
  reg [31:0] memory_22;
  wire[31:0] T188;
  wire[31:0] T114;
  wire T115;
  wire T116;
  reg [31:0] memory_23;
  wire[31:0] T189;
  wire[31:0] T117;
  wire T118;
  wire T119;
  wire T120;
  wire T121;
  wire T122;
  wire[31:0] T123;
  wire[31:0] T124;
  wire[31:0] T125;
  reg [31:0] memory_24;
  wire[31:0] T190;
  wire[31:0] T126;
  wire T127;
  wire T128;
  reg [31:0] memory_25;
  wire[31:0] T191;
  wire[31:0] T129;
  wire T130;
  wire T131;
  wire T132;
  wire[31:0] T133;
  reg [31:0] memory_26;
  wire[31:0] T192;
  wire[31:0] T134;
  wire T135;
  wire T136;
  reg [31:0] memory_27;
  wire[31:0] T193;
  wire[31:0] T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire[31:0] T142;
  wire[31:0] T143;
  reg [31:0] memory_28;
  wire[31:0] T194;
  wire[31:0] T144;
  wire T145;
  wire T146;
  reg [31:0] memory_29;
  wire[31:0] T195;
  wire[31:0] T147;
  wire T148;
  wire T149;
  wire T150;
  wire[31:0] T151;
  reg [31:0] memory_30;
  wire[31:0] T196;
  wire[31:0] T152;
  wire T153;
  wire T154;
  reg [31:0] memory_31;
  wire[31:0] T197;
  wire[31:0] T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire T162;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    memory_0 = {1{$random}};
    memory_1 = {1{$random}};
    memory_2 = {1{$random}};
    memory_3 = {1{$random}};
    memory_4 = {1{$random}};
    memory_5 = {1{$random}};
    R30 = {1{$random}};
    memory_6 = {1{$random}};
    R36 = {1{$random}};
    memory_7 = {1{$random}};
    memory_8 = {1{$random}};
    memory_9 = {1{$random}};
    memory_10 = {1{$random}};
    memory_11 = {1{$random}};
    memory_12 = {1{$random}};
    memory_13 = {1{$random}};
    memory_14 = {1{$random}};
    memory_15 = {1{$random}};
    memory_16 = {1{$random}};
    memory_17 = {1{$random}};
    memory_18 = {1{$random}};
    memory_19 = {1{$random}};
    memory_20 = {1{$random}};
    memory_21 = {1{$random}};
    memory_22 = {1{$random}};
    memory_23 = {1{$random}};
    memory_24 = {1{$random}};
    memory_25 = {1{$random}};
    memory_26 = {1{$random}};
    memory_27 = {1{$random}};
    memory_28 = {1{$random}};
    memory_29 = {1{$random}};
    memory_30 = {1{$random}};
    memory_31 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_data_b = T0;
  assign T0 = io_wen ? 32'h0 : T1;
  assign T1 = T162 ? T84 : T2;
  assign T2 = T83 ? T45 : T3;
  assign T3 = T44 ? T24 : T4;
  assign T4 = T23 ? T15 : T5;
  assign T5 = T14 ? memory_1 : memory_0;
  assign T163 = reset ? 32'h0 : T6;
  assign T6 = T7 ? io_data_a : memory_0;
  assign T7 = io_wen & T8;
  assign T8 = T9[1'h0:1'h0];
  assign T9 = 1'h1 << T10;
  assign T10 = T164;
  assign T164 = io_addr[3'h4:1'h0];
  assign T165 = reset ? 32'h0 : T11;
  assign T11 = T12 ? io_data_a : memory_1;
  assign T12 = io_wen & T13;
  assign T13 = T9[1'h1:1'h1];
  assign T14 = T10[1'h0:1'h0];
  assign T15 = T22 ? memory_3 : memory_2;
  assign T166 = reset ? 32'h0 : T16;
  assign T16 = T17 ? io_data_a : memory_2;
  assign T17 = io_wen & T18;
  assign T18 = T9[2'h2:2'h2];
  assign T167 = reset ? 32'h0 : T19;
  assign T19 = T20 ? io_data_a : memory_3;
  assign T20 = io_wen & T21;
  assign T21 = T9[2'h3:2'h3];
  assign T22 = T10[1'h0:1'h0];
  assign T23 = T10[1'h1:1'h1];
  assign T24 = T43 ? T34 : T25;
  assign T25 = T33 ? memory_5 : memory_4;
  assign T168 = reset ? 32'h0 : T26;
  assign T26 = T27 ? io_data_a : memory_4;
  assign T27 = io_wen & T28;
  assign T28 = T9[3'h4:3'h4];
  assign T169 = reset ? 32'h0 : T29;
  assign T29 = T31 ? io_data_a : R30;
  assign T170 = reset ? 32'h4 : R30;
  assign T31 = io_wen & T32;
  assign T32 = T9[3'h5:3'h5];
  assign T33 = T10[1'h0:1'h0];
  assign T34 = T42 ? memory_7 : memory_6;
  assign T171 = reset ? 32'h0 : T35;
  assign T35 = T37 ? io_data_a : R36;
  assign T172 = reset ? 32'h10 : R36;
  assign T37 = io_wen & T38;
  assign T38 = T9[3'h6:3'h6];
  assign T173 = reset ? 32'h0 : T39;
  assign T39 = T40 ? io_data_a : memory_7;
  assign T40 = io_wen & T41;
  assign T41 = T9[3'h7:3'h7];
  assign T42 = T10[1'h0:1'h0];
  assign T43 = T10[1'h1:1'h1];
  assign T44 = T10[2'h2:2'h2];
  assign T45 = T82 ? T64 : T46;
  assign T46 = T63 ? T55 : T47;
  assign T47 = T54 ? memory_9 : memory_8;
  assign T174 = reset ? 32'h0 : T48;
  assign T48 = T49 ? io_data_a : memory_8;
  assign T49 = io_wen & T50;
  assign T50 = T9[4'h8:4'h8];
  assign T175 = reset ? 32'h0 : T51;
  assign T51 = T52 ? io_data_a : memory_9;
  assign T52 = io_wen & T53;
  assign T53 = T9[4'h9:4'h9];
  assign T54 = T10[1'h0:1'h0];
  assign T55 = T62 ? memory_11 : memory_10;
  assign T176 = reset ? 32'h0 : T56;
  assign T56 = T57 ? io_data_a : memory_10;
  assign T57 = io_wen & T58;
  assign T58 = T9[4'ha:4'ha];
  assign T177 = reset ? 32'h0 : T59;
  assign T59 = T60 ? io_data_a : memory_11;
  assign T60 = io_wen & T61;
  assign T61 = T9[4'hb:4'hb];
  assign T62 = T10[1'h0:1'h0];
  assign T63 = T10[1'h1:1'h1];
  assign T64 = T81 ? T73 : T65;
  assign T65 = T72 ? memory_13 : memory_12;
  assign T178 = reset ? 32'h0 : T66;
  assign T66 = T67 ? io_data_a : memory_12;
  assign T67 = io_wen & T68;
  assign T68 = T9[4'hc:4'hc];
  assign T179 = reset ? 32'h0 : T69;
  assign T69 = T70 ? io_data_a : memory_13;
  assign T70 = io_wen & T71;
  assign T71 = T9[4'hd:4'hd];
  assign T72 = T10[1'h0:1'h0];
  assign T73 = T80 ? memory_15 : memory_14;
  assign T180 = reset ? 32'h0 : T74;
  assign T74 = T75 ? io_data_a : memory_14;
  assign T75 = io_wen & T76;
  assign T76 = T9[4'he:4'he];
  assign T181 = reset ? 32'h0 : T77;
  assign T77 = T78 ? io_data_a : memory_15;
  assign T78 = io_wen & T79;
  assign T79 = T9[4'hf:4'hf];
  assign T80 = T10[1'h0:1'h0];
  assign T81 = T10[1'h1:1'h1];
  assign T82 = T10[2'h2:2'h2];
  assign T83 = T10[2'h3:2'h3];
  assign T84 = T161 ? T123 : T85;
  assign T85 = T122 ? T104 : T86;
  assign T86 = T103 ? T95 : T87;
  assign T87 = T94 ? memory_17 : memory_16;
  assign T182 = reset ? 32'h0 : T88;
  assign T88 = T89 ? io_data_a : memory_16;
  assign T89 = io_wen & T90;
  assign T90 = T9[5'h10:5'h10];
  assign T183 = reset ? 32'h0 : T91;
  assign T91 = T92 ? io_data_a : memory_17;
  assign T92 = io_wen & T93;
  assign T93 = T9[5'h11:5'h11];
  assign T94 = T10[1'h0:1'h0];
  assign T95 = T102 ? memory_19 : memory_18;
  assign T184 = reset ? 32'h0 : T96;
  assign T96 = T97 ? io_data_a : memory_18;
  assign T97 = io_wen & T98;
  assign T98 = T9[5'h12:5'h12];
  assign T185 = reset ? 32'h0 : T99;
  assign T99 = T100 ? io_data_a : memory_19;
  assign T100 = io_wen & T101;
  assign T101 = T9[5'h13:5'h13];
  assign T102 = T10[1'h0:1'h0];
  assign T103 = T10[1'h1:1'h1];
  assign T104 = T121 ? T113 : T105;
  assign T105 = T112 ? memory_21 : memory_20;
  assign T186 = reset ? 32'h0 : T106;
  assign T106 = T107 ? io_data_a : memory_20;
  assign T107 = io_wen & T108;
  assign T108 = T9[5'h14:5'h14];
  assign T187 = reset ? 32'h0 : T109;
  assign T109 = T110 ? io_data_a : memory_21;
  assign T110 = io_wen & T111;
  assign T111 = T9[5'h15:5'h15];
  assign T112 = T10[1'h0:1'h0];
  assign T113 = T120 ? memory_23 : memory_22;
  assign T188 = reset ? 32'h0 : T114;
  assign T114 = T115 ? io_data_a : memory_22;
  assign T115 = io_wen & T116;
  assign T116 = T9[5'h16:5'h16];
  assign T189 = reset ? 32'h0 : T117;
  assign T117 = T118 ? io_data_a : memory_23;
  assign T118 = io_wen & T119;
  assign T119 = T9[5'h17:5'h17];
  assign T120 = T10[1'h0:1'h0];
  assign T121 = T10[1'h1:1'h1];
  assign T122 = T10[2'h2:2'h2];
  assign T123 = T160 ? T142 : T124;
  assign T124 = T141 ? T133 : T125;
  assign T125 = T132 ? memory_25 : memory_24;
  assign T190 = reset ? 32'h0 : T126;
  assign T126 = T127 ? io_data_a : memory_24;
  assign T127 = io_wen & T128;
  assign T128 = T9[5'h18:5'h18];
  assign T191 = reset ? 32'h0 : T129;
  assign T129 = T130 ? io_data_a : memory_25;
  assign T130 = io_wen & T131;
  assign T131 = T9[5'h19:5'h19];
  assign T132 = T10[1'h0:1'h0];
  assign T133 = T140 ? memory_27 : memory_26;
  assign T192 = reset ? 32'h0 : T134;
  assign T134 = T135 ? io_data_a : memory_26;
  assign T135 = io_wen & T136;
  assign T136 = T9[5'h1a:5'h1a];
  assign T193 = reset ? 32'h0 : T137;
  assign T137 = T138 ? io_data_a : memory_27;
  assign T138 = io_wen & T139;
  assign T139 = T9[5'h1b:5'h1b];
  assign T140 = T10[1'h0:1'h0];
  assign T141 = T10[1'h1:1'h1];
  assign T142 = T159 ? T151 : T143;
  assign T143 = T150 ? memory_29 : memory_28;
  assign T194 = reset ? 32'h0 : T144;
  assign T144 = T145 ? io_data_a : memory_28;
  assign T145 = io_wen & T146;
  assign T146 = T9[5'h1c:5'h1c];
  assign T195 = reset ? 32'h0 : T147;
  assign T147 = T148 ? io_data_a : memory_29;
  assign T148 = io_wen & T149;
  assign T149 = T9[5'h1d:5'h1d];
  assign T150 = T10[1'h0:1'h0];
  assign T151 = T158 ? memory_31 : memory_30;
  assign T196 = reset ? 32'h0 : T152;
  assign T152 = T153 ? io_data_a : memory_30;
  assign T153 = io_wen & T154;
  assign T154 = T9[5'h1e:5'h1e];
  assign T197 = reset ? 32'h0 : T155;
  assign T155 = T156 ? io_data_a : memory_31;
  assign T156 = io_wen & T157;
  assign T157 = T9[5'h1f:5'h1f];
  assign T158 = T10[1'h0:1'h0];
  assign T159 = T10[1'h1:1'h1];
  assign T160 = T10[2'h2:2'h2];
  assign T161 = T10[2'h3:2'h3];
  assign T162 = T10[3'h4:3'h4];

  always @(posedge clk) begin
    if(reset) begin
      memory_0 <= 32'h0;
    end else if(T7) begin
      memory_0 <= io_data_a;
    end
    if(reset) begin
      memory_1 <= 32'h0;
    end else if(T12) begin
      memory_1 <= io_data_a;
    end
    if(reset) begin
      memory_2 <= 32'h0;
    end else if(T17) begin
      memory_2 <= io_data_a;
    end
    if(reset) begin
      memory_3 <= 32'h0;
    end else if(T20) begin
      memory_3 <= io_data_a;
    end
    if(reset) begin
      memory_4 <= 32'h0;
    end else if(T27) begin
      memory_4 <= io_data_a;
    end
    if(reset) begin
      memory_5 <= 32'h4;
    end else if(T31) begin
      memory_5 <= io_data_a;
    end else begin
      memory_5 <= R30;
    end
    if(reset) begin
      R30 <= 32'h0;
    end
    if(reset) begin
      memory_6 <= 32'h10;
    end else if(T37) begin
      memory_6 <= io_data_a;
    end else begin
      memory_6 <= R36;
    end
    if(reset) begin
      R36 <= 32'h0;
    end
    if(reset) begin
      memory_7 <= 32'h0;
    end else if(T40) begin
      memory_7 <= io_data_a;
    end
    if(reset) begin
      memory_8 <= 32'h0;
    end else if(T49) begin
      memory_8 <= io_data_a;
    end
    if(reset) begin
      memory_9 <= 32'h0;
    end else if(T52) begin
      memory_9 <= io_data_a;
    end
    if(reset) begin
      memory_10 <= 32'h0;
    end else if(T57) begin
      memory_10 <= io_data_a;
    end
    if(reset) begin
      memory_11 <= 32'h0;
    end else if(T60) begin
      memory_11 <= io_data_a;
    end
    if(reset) begin
      memory_12 <= 32'h0;
    end else if(T67) begin
      memory_12 <= io_data_a;
    end
    if(reset) begin
      memory_13 <= 32'h0;
    end else if(T70) begin
      memory_13 <= io_data_a;
    end
    if(reset) begin
      memory_14 <= 32'h0;
    end else if(T75) begin
      memory_14 <= io_data_a;
    end
    if(reset) begin
      memory_15 <= 32'h0;
    end else if(T78) begin
      memory_15 <= io_data_a;
    end
    if(reset) begin
      memory_16 <= 32'h0;
    end else if(T89) begin
      memory_16 <= io_data_a;
    end
    if(reset) begin
      memory_17 <= 32'h0;
    end else if(T92) begin
      memory_17 <= io_data_a;
    end
    if(reset) begin
      memory_18 <= 32'h0;
    end else if(T97) begin
      memory_18 <= io_data_a;
    end
    if(reset) begin
      memory_19 <= 32'h0;
    end else if(T100) begin
      memory_19 <= io_data_a;
    end
    if(reset) begin
      memory_20 <= 32'h0;
    end else if(T107) begin
      memory_20 <= io_data_a;
    end
    if(reset) begin
      memory_21 <= 32'h0;
    end else if(T110) begin
      memory_21 <= io_data_a;
    end
    if(reset) begin
      memory_22 <= 32'h0;
    end else if(T115) begin
      memory_22 <= io_data_a;
    end
    if(reset) begin
      memory_23 <= 32'h0;
    end else if(T118) begin
      memory_23 <= io_data_a;
    end
    if(reset) begin
      memory_24 <= 32'h0;
    end else if(T127) begin
      memory_24 <= io_data_a;
    end
    if(reset) begin
      memory_25 <= 32'h0;
    end else if(T130) begin
      memory_25 <= io_data_a;
    end
    if(reset) begin
      memory_26 <= 32'h0;
    end else if(T135) begin
      memory_26 <= io_data_a;
    end
    if(reset) begin
      memory_27 <= 32'h0;
    end else if(T138) begin
      memory_27 <= io_data_a;
    end
    if(reset) begin
      memory_28 <= 32'h0;
    end else if(T145) begin
      memory_28 <= io_data_a;
    end
    if(reset) begin
      memory_29 <= 32'h0;
    end else if(T148) begin
      memory_29 <= io_data_a;
    end
    if(reset) begin
      memory_30 <= 32'h0;
    end else if(T153) begin
      memory_30 <= io_data_a;
    end
    if(reset) begin
      memory_31 <= 32'h0;
    end else if(T156) begin
      memory_31 <= io_data_a;
    end
  end
endmodule

module Main(input clk, input reset,
    output[31:0] io_pc,
    input [31:0] io_inst,
    output[1023:0] io_debug_regs,
    output[31:0] io_debug_if_inst,
    output[31:0] io_debug_id_inst,
    output[31:0] io_debug_exe_inst,
    output[31:0] io_debug_mem_inst,
    output[31:0] io_debug_wb_inst
);

  wire[31:0] Memory_io_data_b;
  wire CoreCPU_io_mem_wen;
  wire[31:0] CoreCPU_io_mem_addr;
  wire[31:0] CoreCPU_io_mem_data_a;
  wire[31:0] CoreCPU_io_pc;
  wire[1023:0] CoreCPU_io_debug_regs;
  wire[31:0] CoreCPU_io_debug_if_inst;
  wire[31:0] CoreCPU_io_debug_id_inst;
  wire[31:0] CoreCPU_io_debug_exe_inst;
  wire[31:0] CoreCPU_io_debug_mem_inst;
  wire[31:0] CoreCPU_io_debug_wb_inst;


  assign io_debug_wb_inst = CoreCPU_io_debug_wb_inst;
  assign io_debug_mem_inst = CoreCPU_io_debug_mem_inst;
  assign io_debug_exe_inst = CoreCPU_io_debug_exe_inst;
  assign io_debug_id_inst = CoreCPU_io_debug_id_inst;
  assign io_debug_if_inst = CoreCPU_io_debug_if_inst;
  assign io_debug_regs = CoreCPU_io_debug_regs;
  assign io_pc = CoreCPU_io_pc;
  CoreCPU CoreCPU(.clk(clk), .reset(reset),
       .io_mem_wen( CoreCPU_io_mem_wen ),
       .io_mem_addr( CoreCPU_io_mem_addr ),
       .io_mem_data_a( CoreCPU_io_mem_data_a ),
       .io_mem_data_b( Memory_io_data_b ),
       .io_pc( CoreCPU_io_pc ),
       .io_inst( io_inst ),
       .io_debug_regs( CoreCPU_io_debug_regs ),
       .io_debug_if_inst( CoreCPU_io_debug_if_inst ),
       .io_debug_id_inst( CoreCPU_io_debug_id_inst ),
       .io_debug_exe_inst( CoreCPU_io_debug_exe_inst ),
       .io_debug_mem_inst( CoreCPU_io_debug_mem_inst ),
       .io_debug_wb_inst( CoreCPU_io_debug_wb_inst )
  );
  Memory Memory(.clk(clk), .reset(reset),
       .io_wen( CoreCPU_io_mem_wen ),
       .io_addr( CoreCPU_io_mem_addr ),
       .io_data_a( CoreCPU_io_mem_data_a ),
       .io_data_b( Memory_io_data_b )
  );
endmodule

