# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_param simulator.modelsimInstallPath C:/modeltech_pe_10.4c/win32pe
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/vivado_projects/1552229-cpu31/1552229-cpu31.cache/wt [current_project]
set_property parent.project_path E:/vivado_projects/1552229-cpu31/1552229-cpu31.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files E:/vivado_projects/1552229-cpu31/_1_addi.hex.coe
add_files -quiet E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/ip/ipcore/ipcore.dcp
set_property used_in_implementation false [get_files E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/ip/ipcore/ipcore.dcp]
read_verilog -library xil_defaultlib {
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/mux1.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pcreg.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/Regfiles.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/ram.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pc_ext3.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pc_addext.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pc_add8.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pc_add4.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/mux_5.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/mux0.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/mux.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/ext_5.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/ext_18.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/ext_16.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/cpu_dataflow.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/alu.v
  E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/cpu.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/constrs_1/new/cpuxdc.xdc
set_property used_in_implementation false [get_files E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/constrs_1/new/cpuxdc.xdc]


synth_design -top cpu -part xc7a100tcsg324-1


write_checkpoint -force -noxdef cpu.dcp

catch { report_utilization -file cpu_utilization_synth.rpt -pb cpu_utilization_synth.pb }