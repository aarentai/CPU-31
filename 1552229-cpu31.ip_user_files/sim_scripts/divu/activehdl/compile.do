vlib work
vlib activehdl

vlib activehdl/xbip_utils_v3_0_6
vlib activehdl/axi_utils_v2_0_2
vlib activehdl/xbip_pipe_v3_0_2
vlib activehdl/xbip_dsp48_wrapper_v3_0_4
vlib activehdl/xbip_dsp48_addsub_v3_0_2
vlib activehdl/xbip_bram18k_v3_0_2
vlib activehdl/mult_gen_v12_0_11
vlib activehdl/floating_point_v7_0_12
vlib activehdl/xbip_dsp48_mult_v3_0_2
vlib activehdl/xbip_dsp48_multadd_v3_0_2
vlib activehdl/div_gen_v5_1_10
vlib activehdl/xil_defaultlib

vmap xbip_utils_v3_0_6 activehdl/xbip_utils_v3_0_6
vmap axi_utils_v2_0_2 activehdl/axi_utils_v2_0_2
vmap xbip_pipe_v3_0_2 activehdl/xbip_pipe_v3_0_2
vmap xbip_dsp48_wrapper_v3_0_4 activehdl/xbip_dsp48_wrapper_v3_0_4
vmap xbip_dsp48_addsub_v3_0_2 activehdl/xbip_dsp48_addsub_v3_0_2
vmap xbip_bram18k_v3_0_2 activehdl/xbip_bram18k_v3_0_2
vmap mult_gen_v12_0_11 activehdl/mult_gen_v12_0_11
vmap floating_point_v7_0_12 activehdl/floating_point_v7_0_12
vmap xbip_dsp48_mult_v3_0_2 activehdl/xbip_dsp48_mult_v3_0_2
vmap xbip_dsp48_multadd_v3_0_2 activehdl/xbip_dsp48_multadd_v3_0_2
vmap div_gen_v5_1_10 activehdl/div_gen_v5_1_10
vmap xil_defaultlib activehdl/xil_defaultlib

vcom -work xbip_utils_v3_0_6 -93 \
"../../../ipstatic/xbip_utils_v3_0_6/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_2 -93 \
"../../../ipstatic/axi_utils_v2_0_2/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_2 -93 \
"../../../ipstatic/xbip_pipe_v3_0_2/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
"../../../ipstatic/xbip_pipe_v3_0_2/hdl/xbip_pipe_v3_0.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_4 -93 \
"../../../ipstatic/xbip_dsp48_wrapper_v3_0_4/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_addsub_v3_0_2 -93 \
"../../../ipstatic/xbip_dsp48_addsub_v3_0_2/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
"../../../ipstatic/xbip_dsp48_addsub_v3_0_2/hdl/xbip_dsp48_addsub_v3_0.vhd" \

vcom -work xbip_bram18k_v3_0_2 -93 \
"../../../ipstatic/xbip_bram18k_v3_0_2/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
"../../../ipstatic/xbip_bram18k_v3_0_2/hdl/xbip_bram18k_v3_0.vhd" \

vcom -work mult_gen_v12_0_11 -93 \
"../../../ipstatic/mult_gen_v12_0_11/hdl/mult_gen_v12_0_vh_rfs.vhd" \
"../../../ipstatic/mult_gen_v12_0_11/hdl/mult_gen_v12_0.vhd" \

vcom -work floating_point_v7_0_12 -93 \
"../../../ipstatic/floating_point_v7_0_12/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_mult_v3_0_2 -93 \
"../../../ipstatic/xbip_dsp48_mult_v3_0_2/hdl/xbip_dsp48_mult_v3_0_vh_rfs.vhd" \
"../../../ipstatic/xbip_dsp48_mult_v3_0_2/hdl/xbip_dsp48_mult_v3_0.vhd" \

vcom -work xbip_dsp48_multadd_v3_0_2 -93 \
"../../../ipstatic/xbip_dsp48_multadd_v3_0_2/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \
"../../../ipstatic/xbip_dsp48_multadd_v3_0_2/hdl/xbip_dsp48_multadd_v3_0.vhd" \

vcom -work div_gen_v5_1_10 -93 \
"../../../ipstatic/div_gen_v5_1_10/hdl/div_gen_v5_1_vh_rfs.vhd" \
"../../../ipstatic/div_gen_v5_1_10/hdl/div_gen_v5_1.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../1552229-cpu31.srcs/sources_1/ip/divu/sim/divu.vhd" \

