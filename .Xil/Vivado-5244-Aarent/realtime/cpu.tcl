# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "E:/vivado_projects/1552229-cpu31/.Xil/Vivado-5244-Aarent/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a100tcsg324-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog {
      E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/pcreg.v
      E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/mux1.v
      E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/decoder.v
      E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/iram.v
      E:/vivado_projects/1552229-cpu31/1552229-cpu31.srcs/sources_1/new/regfile.v
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
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top cpu
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "E:/vivado_projects/1552229-cpu31/.Xil/Vivado-5244-Aarent/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}